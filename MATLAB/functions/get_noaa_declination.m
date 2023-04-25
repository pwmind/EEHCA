function declination = get_noaa_declination(lambda)
%UNTITLED21 Summary of this function goes here
%   Detailed explanation goes here
    declination = 0.006918 - 0.399912*cos(lambda) + 0.070257*sin(lambda) - 0.006758*cos(2*lambda) + 0.000907*sin(2*lambda) - 0.002697*cos(3*lambda) + 0.00148*sin(3*lambda);
end