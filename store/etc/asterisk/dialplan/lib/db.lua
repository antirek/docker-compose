local mongo = require('mongo');
local inspect = require('inspect');

function db (config)
    
    local db = mongo.Connection.New();
    db:connect(config.db.host);
    
    function getIncomingExtensions ()
        local query = db:query("viola.incoming");
        local exts = {};
        
        for result in query:results() do
            exts[result.extension] = result;
        end;
        
        return exts;
    end;

    function findUserByExtension (extension)
        app.noop('extension for find'..extension);
        local cursor = db:query("viola.extensions", {
            extension = extension
        });
        local user = cursor:next();
        app.noop(item);

        if (user) then            
            app.noop("peername: "..inspect(user.peername));
        end;
        return user;
    end;    

    function checkRecord (peername)
        local cursor = db:query("viola.extensions", {
            peername = peername
        });

        local user = cursor:next();
        app.noop(user);
        local record;

        if (user) then
            record = user.record;
            app.noop("record: "..record);
        end;
        return record;
    end;

    function findIVRByExtension (extension)
        app.noop('extension for find in ivr: '..extension);
        local cursor = db:query("viola.ivrs", {
            extension = extension
        });
        local item = cursor:next();
        local menu;
        
        if (item) then
            menu = item;
            app.noop("ivr menu: "..inspect(menu));
        end;
        return menu;
    end;

    function findTimeByExtension(extension)
        app.noop("time"..extension);
        local cursor = db:query("viola.times", {
            extension = extension
        });

        local item = cursor:next();
        local time;

        if (item) then
            time = item;
            app.noop("time: "..inspect(time));
        end;
        return time;
    end;

    function findQueueByExtension (extension)
        app.noop('extension for find in queue: '..extension);
        local cursor = db:query("viola.queue", {
            extension = extension
        });
        local item = cursor:next();
        local queue;
        
        if (item) then
            queue = item;
            app.noop("queue: "..inspect(queue));
        end;
        return queue;
    end;

    return {
        ["findUserByExtension"] = findUserByExtension;        
        ["checkRecord"] = checkRecord;
        ["findIVRByExtension"] = findIVRByExtension;
        ["findQueueByExtension"] = findQueueByExtension;
        ["getIncomingExtensions"] = getIncomingExtensions;
        ["findTimeByExtension"] = findTimeByExtension;
    };

end;

return db;