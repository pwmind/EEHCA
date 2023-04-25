function Beta = get_solar_altitude_angle(declination, latitude, hour_angle)
    arguments
        declination (:,1) double
        latitude (1,1) double
        hour_angle (:,1) double
    end
% get_solar_altitude_angle  Get the solar altitude angle from the
% declination, latitude, and hour angle
%   declination - Solar declination in radians
%   latitude - Global latitude in radians
%   hour_angle - Hour angle in radians

    Beta = asin(sin(declination) .* sin(latitude) + cos(declination) .* cos(latitude) .* cos(hour_angle));

end