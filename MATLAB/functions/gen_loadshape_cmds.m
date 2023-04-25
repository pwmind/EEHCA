function cmdlist = gen_loadshape_cmds(profilesdir, daynum)

    % get a list of all the files that match the day number.  Put this list in
    % a table, then sort the table on the 'name' field.  This should guarantee
    % that kwfiles(1) is the same load shape id as kvarfiles(1)

    %kwfiles = sortrows(struct2table(dir(strcat(profilesdir,sprintf('\\*_kw_*_d%d_pu.csv',daynum)))),'name');
    kwfiles = sortrows(dss_get_filtered_files(profilesdir,sprintf('\\*_kw_*_d%d_pu.csv',daynum)));

    %kvarfiles = sortrows(struct2table(dir(strcat(profilesdir,sprintf('\\*_kvar_*_d%d_pu.csv',daynum)))),'name');
    kvarfiles = sortrows(dss_get_filtered_files(profilesdir,sprintf('\\*_kvar_*_d%d_pu.csv',daynum)));

    num_kwfiles = size(kwfiles,1);
    num_kvarfiles = size(kvarfiles,1);

    % Check that files were found
    if (num_kwfiles < 1 || num_kvarfiles < 1)
        error('gen_loadshape_cmds:NoFilesFound','No kw or kvar files were found in directory %s', profilesdir);
    end

    % Verify that the two tables have the same number of rows
    if (size(kwfiles,1) ~= size(kvarfiles,1)) 
      error('gen_loadshape_cmds:FileCountMismatch','Number of kwfiles and kvarfiles do not match');
    end

    numshapes = size(kwfiles,1);
    
    cmdlist = cell(numshapes,1);

    for i = 1:numshapes
    
        lsnameout = string(split(kwfiles{i,{'name'}},'.'));
        lsname = regexprep(lsnameout(1),'_d\d+','');
    
        kwfile = strcat(kwfiles{i,{'folder'}},'\',kwfiles{i,{'name'}});
        kvarfile = strcat(kvarfiles{i,{'folder'}},'\',kvarfiles{i,{'name'}});
    
        kwfile_content = readlines(kwfile,"EmptyLineRule","skip");
        kvarfile_content = readlines(kvarfile,"EmptyLineRule","skip");
    
        kwfile_len = size(kwfile_content,1);
        kvarfile_len = size(kvarfile_content,1);
    
        if (kwfile_len ~= kvarfile_len)
            error("Loadshape file length mismatch for %s",lsname);
        else
            numpts = kwfile_len;
            interval = 24 / kwfile_len;
        end
    
        cmdlist{i} = sprintf('New Loadshape.%s npts=%d interval=%.2f mult = (file="%s") qmult = (file="%s")\n',lsname,numpts,interval,kwfile,kvarfile);
    end

    %disp(cmdlist)
end
