function run_base_dss(DSSText, masterdsspath)
    
    command = strcat('Compile "', masterdsspath,'"');
    
    try
        run_dss_command(DSSText,command);

    catch Error
        rethrow(Error);
    end
end