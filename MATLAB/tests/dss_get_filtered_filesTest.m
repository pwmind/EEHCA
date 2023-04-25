classdef dss_get_filtered_filesTest < matlab.unittest.TestCase

    properties
        validDir = "testdata\dss_get_filtered_files";
        fullexpected = table();
    end

    methods (TestClassSetup)
        % Shared setup for the entire test class
        function testSetup(testCase)
            varfile = load(fullfile(testCase.validDir,'output.mat'));
            testCase.fullexpected = varfile.testout;
        end
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function singleFileTest(testCase)
            filter = '\\com_kw_1234_d1_pu.csv';

            actual = dss_get_filtered_files(testCase.validDir,filter);

            % Set expected to be a table with single row
            expected = testCase.fullexpected(testCase.fullexpected.name == 'com_kw_1234_d1_pu.csv',:);


            testCase.verifyEqual(actual,expected);

        end

        function MultipleFileTest(testCase)
            filter = '\\com_kw_*_d1_pu.csv';

            actual = dss_get_filtered_files(testCase.validDir,filter);

            testCase.verifyEqual(actual,testCase.fullexpected);

        end
    end

end