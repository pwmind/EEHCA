function hour_angle = get_noaa_hour_angle(tst)
%UNTITLED25 Summary of this function goes here
%   Detailed explanation goes here
    hour_angle = deg2rad(tst/4 - 180);
end