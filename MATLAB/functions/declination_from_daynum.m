function declination = declination_from_daynum(daynum)
% declination_from_daynum   Calculate the solar declination from the day
% number of the year.  Leap years are not handled by this function
%   daynum - The nth day of the year starting from 1

% Standard formula for declination angle:
% 23.45 * sin(360*(n - 81)/365)
% convert result to radians

    if any(daynum < 1) || any(daynum > 365)
        error('declination_from_daynum:InputOutOfRange','Day number must be between 1 and 365, inclusive.  daynum = %s', num2str(daynum))
    else
        declination = deg2rad(23.45*sind(360*(daynum - 81)/365));
    end

end