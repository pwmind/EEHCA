classdef get_daynumberTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function twentyfourhourTest(testCase)
            data = zeros([48,1]);

            expected = [zeros([24,1]) + 1; zeros([24,1])+2];

            actual = get_daynumber(1,data);

            testCase.verifyEqual(actual,expected);
        end

        function fifteenminuteTest(testCase)
            data = zeros([96*2,1]);

            expected = [zeros([96,1])+1; zeros([96,1])+2];

            actual = get_daynumber(0.25,data);

            testCase.verifyEqual(actual,expected);
        end
    end

end