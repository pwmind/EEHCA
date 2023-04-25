function lambda = get_fractional_year(daynumber,hour)
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here
    lambda = 2*pi*(daynumber - 1 + (hour - 12)/24)/365;
end