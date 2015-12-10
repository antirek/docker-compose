local config = require('/etc/asterisk/dialplan/config');
local db = require('/etc/asterisk/dialplan/lib/db');
local inspect = require('inspect');

local dbHelper = db(config);

local inner = require('/etc/asterisk/dialplan/lib/inner')(dbHelper);
local ivr = require('/etc/asterisk/dialplan/lib/ivr')(dbHelper);
local queue = require('/etc/asterisk/dialplan/lib/queue')(dbHelper);
local time = require('/etc/asterisk/dialplan/lib/time')(dbHelper);
local services = require('/etc/asterisk/dialplan/lib/services')(dbHelper);


function info ()
    peername = channel.CHANNEL("peername"):get();
    name = channel.CALLERID("name"):get();
    num = channel.CALLERID("num"):get();
    all = channel.CALLERID("all"):get();
end;

function hangupHandler (context, extension)
    app.noop('hangup handle');
    app.noop(context);
    local dialstatus = channel["DIALSTATUS"]:get() or 'undefined';
    app.noop("dialstatus: "..dialstatus);
    app['return']();
end;

function incoming (c, e, rule)
    --app.goto('queues,1200,1');
    app.noop('incoming'..c..e..inspect(rule));
    if (rule.target) then 
        app['goto'](rule.target);
    else 
        app.hangup();
    end;
end;

function getIncomingExtensions ()
    local extensions = dbHelper.getIncomingExtensions();

    local q = {};
    for key, rule in pairs(extensions) do
        q[key] = function (context, extension)
            incoming(context, extension, rule);
        end;
    end;
    return q;
end;

local Dialplan = {
    getExtensions = function ()
        return {
            ["internal"] = {
                
                ["_2XX"] = ivr.menu;
            
                ["*12"] = services.sayunixtime;
            
                ["_3XX"] = queue.call_queue;
            
                ["_1XX"] = inner.call_device;
                
                ["_*1XX"] = inner.call_mobile;
            
                ["112"] = emergency;
                ["_8XXXXXXXXXX"] = outbound;
                
                --["h"] = hangupHandler;
            };

            ["hangups"] = {
                ["s"] = hangupHandler;
            };

            
	    --[[
            ["incoming"] = {
                ["_."] = getIncomingExtensions;
            };
	    ]]--


        };
    end;

    getHints = function ()
        return {

        };
    end;
};

return Dialplan;