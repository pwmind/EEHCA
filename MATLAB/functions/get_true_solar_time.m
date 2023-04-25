function tst = get_true_solar_time(hour,minute,time_offset)
%UNTITLED23 Summary of this function goes here
%   Detailed explanation goes here
    tst = hour*60 + minute + time_offset;
end