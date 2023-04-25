function time_offset = get_time_offset(eqtime,longitude, timezone)
%UNTITLED22 Summary of this function goes here
%   Detailed explanation goes here
    time_offset = eqtime - 4*longitude - 60*timezone;
end