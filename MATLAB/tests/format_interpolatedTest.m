classdef format_interpolatedTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function fiveElementSizeTest(testCase)
            values = transpose(1:5);
            period = 0.25;
            
            result = format_interpolated(values,period,size(values,1));

            actual = size(result,1);

            expected = 20;

            testCase.verifyEqual(actual,expected);
        end

        function fiveElementElementValueTest(testCase)
            values = transpose(1:5);
            period = 0.25;
            
            actual = format_interpolated(values,period,size(values,1));
        
            expected = [0; 0; 1.0000; 1.2500; 1.5000; 1.7500; 2.0000; 
                2.2500; 2.5000; 2.7500; 3.0000; 3.2500; 3.5000; 3.7500;
                4.0000; 4.2500; 4.5000; 4.7500; 5.0000; 0];

            testCase.verifyEqual(actual,expected);
        end
    end

end