
function inner(dbHelper)

    function inner_call (target)        
        checkRecord();

        if (target) then
            app.progress();
            app.dial(target, 10);        
        else 
            app.hangup(34);
        end;

        local dialstatus = channel["DIALSTATUS"]:get();
        app.noop('dialstatus: '..dialstatus);
        app.set("CHANNEL(language)=ru");

        if dialstatus == 'BUSY' then
            app.playback("followme/sorry");        
        elseif dialstatus == 'CHANUNAVAIL' then 
            app.playback("followme/sorry");
        end; 
        app.hangup();
    end;

    function checkRecord ()
        local date = os.date("*t");
        local peername = channel.CHANNEL("peername"):get();
        app.noop('check record for peername: '..peername);

        local recordCalled = dbHelper.checkRecord(peername);
        local uniqueid = channel.UNIQUEID:get();
        local basePath = '/tmp/records';

        if (recordCalled == 'yes') then
            local fname = string.format("%s_%s-%s-%s_%s:%s:%s", uniqueid, date.year, date.month, date.day, date.hour, date.min, date.sec);
            WAV = "/wav/";
            MP3 = string.format("/mp3/%s-%s-%s/", date.year, date.month, date.day);

            local recordCommand = "/usr/bin/nice -n 19 mkdir -p %s && /usr/bin/lame -b 16 --silent %s%s.wav %s%s.mp3";
            local options = string.format(recordCommand, basePath..MP3, basePath..WAV, fname, basePath..MP3, fname);

            app.mixmonitor(string.format("%s%s.wav,b,%s", basePath..WAV, fname, options));
            channel["CDR(record)"]:set(string.format("%s%s.mp3", MP3, fname));
        end;
        return;
    end;

    function call_device (context, extension) 
        local user = dbHelper.findUserByExtension(extension);
        inner_call('SIP/'..user.peername);
    end;

    function call_mobile (context, extension) 
        local user = dbHelper.findUserByExtension(extension);
        inner_call('SIP/'..user.mobile);
    end;

    return {
        ["call_device"] = call_device;
        ["call_mobile"] = call_mobile;
    }
end;

return inner;