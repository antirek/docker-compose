
local dial = function (context, extension)
    app.progress();
    app.noop("context: " .. context .. ", extension: " .. extension);
    app.dial('SIP/' .. extension, 10);
    
    local dialstatus = channel["DIALSTATUS"]:get();
    app.noop('dialstatus: '..dialstatus);
    app.set("CHANNEL(language)=ru");

    if dialstatus == 'BUSY' then
        app.playback("followme/sorry", "noanswer");        
    elseif dialstatus == 'CHANUNAVAIL' then 
        app.playback("followme/sorry", "noanswer");
    end;

    app.hangup();
end;

local ivr = function (context, extension)        
    app.read("IVR_CHOOSE", "/var/menu/demo", 1, nil, 2, 3);
    local choose = channel["IVR_CHOOSE"]:get();

    if choose == '1' then
        app.queue('1234');
    elseif choose == '2' then
        dial('internal', '101');
    else
        app.hangup();
    end;
end;

local queue = function (context, extension)
    app.queue(extension);
end

extensions = {
    ["internal"] = {

        ["*12"] = function ()
            app.sayunixtime();
        end;

        ["_1XX"] = dial;

        ["_2XX"] = ivr;

        ["_3XX"] = queue;

        ["_NXXXXXX"] = outgoing_route_function;
    };
};

hints = {};