function eot = get_equation_of_time(lambda)
%get_equation_of_time Get the value for equation of time from the
%fractional year
%   From NOAA General Solar Position Calculations
    eot = 229.18*(0.000075 + 0.001868*cos(lambda) - 0.032077*sin(lambda) ...
        - 0.014615*cos(2*lambda) - 0.040849*sin(2*lambda));
end