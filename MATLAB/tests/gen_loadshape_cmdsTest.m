classdef gen_loadshape_cmdsTest < matlab.unittest.TestCase

    properties
        validDirSingle = "testdata\gen_loadshape_cmds_valid_single";
        validDirMulti = "testdata\gen_loadshape_cmds_valid_multi";

        fileNumberMismatchDir = "testdata\gen_loadshape_cmds_fileNumberMismatch";
        fileLengthMismatchDir = "testdata\gen_loadshape_cmds_fileLengthMismatch";
    
    end

    methods (TestClassSetup)
        % Shared setup for the entire test class

    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function fullCorrectRunSingleFileTest(testCase)

            dayNum = 1;
            actual = gen_loadshape_cmds(testCase.validDirSingle,dayNum);

            kwfilepath = fullfile(testCase.validDirSingle,"com_kw_2616_d1_pu.csv");
            kvarfilepath = fullfile(testCase.validDirSingle,"com_kvar_2616_d1_pu.csv");

            validOutput = {sprintf('New Loadshape.com_kw_2616_pu npts=96 interval=0.25 mult = (file="%s") qmult = (file="%s")\n', ...
            kwfilepath,kvarfilepath)};

            testCase.verifyEqual(actual,validOutput);
        end

        function fullCorrectRunMultiFileTest(testCase)

            dayNum = 1;
            actual = gen_loadshape_cmds(testCase.validDirMulti,dayNum);

            kwfilepath1 = fullfile(testCase.validDirMulti,"com_kw_2616_d1_pu.csv");
            kvarfilepath1 = fullfile(testCase.validDirMulti,"com_kvar_2616_d1_pu.csv");

            kwfilepath2 = fullfile(testCase.validDirMulti,"com_kw_34423_d1_pu.csv");
            kvarfilepath2 = fullfile(testCase.validDirMulti,"com_kvar_34423_d1_pu.csv");

            validOutput = {sprintf('New Loadshape.com_kw_2616_pu npts=96 interval=0.25 mult = (file="%s") qmult = (file="%s")\n', kwfilepath1,kvarfilepath1),
                sprintf('New Loadshape.com_kw_34423_pu npts=96 interval=0.25 mult = (file="%s") qmult = (file="%s")\n', kwfilepath2,kvarfilepath2)};

            testCase.verifyEqual(actual,validOutput);
        end

        function noFilesFoundTest(testCase)
            testCase.verifyError(@() gen_loadshape_cmds(testCase.fileNumberMismatchDir,1),'gen_loadshape_cmds:NoFilesFound');
        end
    end

end