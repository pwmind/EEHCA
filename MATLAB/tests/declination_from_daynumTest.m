classdef declination_from_daynumTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function jan1Test(testCase)
            actual = declination_from_daynum(1);
            expected = deg2rad(23.45*sind(360*(-80)/365));
            testCase.verifyEqual(actual,expected);
        end

        function mar21Test(testCase)
            actual = declination_from_daynum(81);
            expected = 0;
            testCase.verifyEqual(actual,expected);
        end

        function invalidnumTest(testCase)
            testCase.verifyError(@() declination_from_daynum(-1), ...
                "declination_from_daynum:InputOutOfRange");
        end

        function invalidArrayInputTest(testCase)
            days = [11 -1 12];

            testCase.verifyError(@() declination_from_daynum(days), ...
                "declination_from_daynum:InputOutOfRange");
        end
    end

end