function result = run_dss_command(DSSText, command)
    
   global scriptname;

    DSSText.command = command;

    result = DSSText.get;

     
    if ~isempty(scriptname)
        logger = mlog.Logger(scriptname);
        logger.info('DSSText.Command: "%s", Result: "%s"', command, result.Result);
    end

    if (strlength(result.Result) ~= 0)

        % OpenDSS doesn't appear to reliably return an error in the Result
        % string.  Some result strings contain command output.

        if (contains(result.Result, "WARNING","IgnoreCase",true))
    
            warning('run_dss_command:ResultWarning','Command: "%s", Warning: "%s"', result.Command, result.Result);
    
        elseif (contains(result.Result, "Not Found"))
    
            error('Command: "%s", Error: "%s"', result.Command, result.Result);

        end
    end
end