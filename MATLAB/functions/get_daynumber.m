function daynumbers = get_daynumber(period, data)
%get_daynumber Create a list of day numbers for the provided data
% Create a list of day numbers for the provided data.  Number of
% reoccurences for a day depends on period.

periods_in_day = 24*1/period;

% create list of numbers the size of data
daynumbers = 1:size(data,1);

for i = 1:size(data,1)
    daynumbers(i) = floor((i - 1)/ periods_in_day) + 1;
end

daynumbers = transpose(daynumbers);

end