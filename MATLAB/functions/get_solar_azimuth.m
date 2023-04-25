function phi = get_solar_azimuth(declination,Beta, hour_angle)
    arguments
        declination (:,1) double
        Beta (:,1) double
        hour_angle (:,1) double
    end
% get_solar_azimuth Get the solar azimuth from the solar declination,
% altitude angle, and hour angle
%   declination - solar declination in radians
%   Beta - solar altitude in radians
%   hour_angle - hour angle in radians

    phi = asin(cos(declination) .* sin(hour_angle) ./ cos(Beta));

end