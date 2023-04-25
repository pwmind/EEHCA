function daystrings = dss_get_daynumbers(profilesdir)
%dss_get_daynumbers Retrieve a list of daynumbers for load profiles.
%   For testing a selection of day were extracted from the yearly loads.
%   This function retrieves a list of days that are available.
    fileparts = split(string(struct2table(dir(fullfile(profilesdir,"com_kvar_2616_d*_pu.csv"))).name),'_');

    daystrings = sort(erase(fileparts(:,4),'d'));

    %days = str2double(daystrings);
      
end