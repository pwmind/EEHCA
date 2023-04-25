function [start_record,end_record] = get_record_range(start_day,end_day, periods_per_day)
%get_record_range Get the range (start and end number) of records
%   Given the start day, end day, and periods per day, get the range of
%   records for the specified period.

    % MATLAB uses arrays starting at 1
    start_record = (start_day - 1) * periods_per_day + 1;
    end_record = end_day * periods_per_day;
end