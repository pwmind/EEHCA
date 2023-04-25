classdef get_solar_altitude_angleTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function scalarArgsTest(testCase)
            declination = deg2rad(23.45);
            latitude = deg2rad(45);
            hour_angle = hour_angle_from_hour(12);

            actual = get_solar_altitude_angle(declination, latitude, hour_angle);
            
            expected = asin(sin(declination) * sin(latitude) + cos(declination) * cos(latitude) * cos(hour_angle));

            testCase.verifyEqual(actual,expected);
        end

        function arrayArgsTest(testCase)
            declination = deg2rad([23.45 23 20]);
            latitude = deg2rad(45);
            hour_angle = hour_angle_from_hour([11 11.5 12]);

            actual = get_solar_altitude_angle(declination, latitude, hour_angle);

            expected = transpose(asin(sin(declination) .* sin(latitude) + cos(declination) .* cos(latitude) .* cos(hour_angle)));

            testCase.verifyEqual(actual,expected);
        end
    end

end