function outtable = dss_get_filtered_files(basedir,filter)
%dss_get_filtered_files Get a table of files matching the given filter
%   Return a table of files matching filter in basedir.  Convert single
%   file output to cells

    filelist = dir(strcat(basedir,filter));
    
    outtable = struct2table(filelist);

    
    outtable.name = string(outtable.name);
    outtable.folder = string(outtable.folder);
    outtable.date = string(outtable.date);
   
end