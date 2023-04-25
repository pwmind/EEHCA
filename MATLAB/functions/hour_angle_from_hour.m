function hour_angle = hour_angle_from_hour(hour)
% hour_angle_from_hour  Calculate the hour angle for the given hour
%   hour - Hour of the day, between 0 and less than 24.  Minutes are given
%   in fractions of an hour, i.e. 1:15 PM = 13.25

    if any(hour < 0) || any(hour >= 24)
        error('hour_angle_from_hour:InputOutOfRange', 'Hour must be between 0 and 24, hour = %s', num2str(hour))
    else
        hour_angle = deg2rad(15*(12-hour));
    end
end