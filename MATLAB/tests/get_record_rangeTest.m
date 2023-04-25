classdef get_record_rangeTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function firstday15mTest(testCase)
       
            [start_record,end_record] = get_record_range(1,1,96);
            actual = [start_record,end_record];
            expected = [1,96];
            testCase.verifyEqual(actual,expected);
        end

        function firstday1hTest(testCase)
            [start_record,end_record] = get_record_range(1,1,24);
            actual = [start_record,end_record];
            expected = [1,24];
            testCase.verifyEqual(actual,expected);
        end

        function lastday15mTest(testCase)
            [start_record,end_record] = get_record_range(365,365,96);
            
            actual = [start_record,end_record];

            expected = [34945,35040];
            
            testCase.verifyEqual(actual,expected);
        end

        function january15mTest(testCase)
            [start_record,end_record] = get_record_range(1,31,96);

            actual = [start_record,end_record];

            expected = [1,2976];
            
            testCase.verifyEqual(actual,expected);
        end

        function december15mTest(testCase)
            [start_record,end_record] = get_record_range(334,365,96);

            actual = [start_record,end_record];

            expected = [31969,35040];
            
            testCase.verifyEqual(actual,expected);
        end
    end

end