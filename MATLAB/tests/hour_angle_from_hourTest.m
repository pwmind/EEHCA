classdef hour_angle_from_hourTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function noonTest(testCase)
            actual = hour_angle_from_hour(12);
            expected = 0;
            testCase.verifyEqual(actual,expected);
        end

        function sixThirtyAMTest(testCase)
            actual = hour_angle_from_hour(6.5);
            expected = deg2rad(15*(12-6.5));
            testCase.verifyEqual(actual,expected);
        end

        function inputArrayTest(testCase)
            hours = [11.5 11.75 12];

            actual = hour_angle_from_hour(hours);

            expected = deg2rad(15*(12-hours));

            testCase.verifyEqual(actual,expected);
        end

        function invalidInputTest(testCase)
            testCase.verifyError(@() hour_angle_from_hour(24), "hour_angle_from_hour:InputOutOfRange");
        end

        function invalidArrayInputTest(testCase)
            hours = [11.5 -1 12];

            testCase.verifyError(@() hour_angle_from_hour(hours), "hour_angle_from_hour:InputOutOfRange");
        end

    end

end