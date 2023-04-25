classdef get_solar_azimuthTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function scalarInputTest(testCase)
            declination = deg2rad(23.45);
            Beta = deg2rad(90);
            hour_angle = hour_angle_from_hour(12);

            actual = get_solar_azimuth(declination, Beta, hour_angle);

            expected = asin(cos(declination) * sin(hour_angle) / cos(Beta));

            testCase.verifyEqual(actual,expected);
        end

        function arrayInputTest(testCase)
            declination = deg2rad([23.45 23 20]);
            Beta = deg2rad([45 60 90]);
            hour_angle = hour_angle_from_hour([11 11.5 12]);

            actual = get_solar_azimuth(declination, Beta, hour_angle);

            expected = transpose(asin(cos(declination) .* sin(hour_angle) ./ cos(Beta)));

            testCase.verifyEqual(actual,expected);
        end
    end

end