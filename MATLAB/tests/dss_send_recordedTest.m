classdef dss_send_recordedTest < matlab.unittest.TestCase

    properties
        busesTable
        linesTable
        loadsTable
        transformersTable
        pvsystemsTable
    end

    methods (TestClassSetup)

        function setupTest(testCase)

            busstruct = struct('name','test1');

            testCase.busesTable = struct2table(busstruct);

            linesstruct = struct('name','test1','bus1','testbus1','bus2','testbus2');
            testCase.linesTable = struct2table(linesstruct);

            loadsstruct = struct('name','test1','busName','testbus1');
            testCase.loadsTable = struct2table(loadsstruct);

            transformersstruct = struct('name','test1','bus1','testbus1','bus2','testbus2');
            testCase.transformersTable = struct2table(transformersstruct);

            pvsystemsstruct = struct('name','test1');
            testCase.pvsystemsTable = struct2table(pvsystemsstruct);
            
        end

    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function collectSingleSetTest(testCase)
            
            name = "sourcebus";
            numPhases = 3;
            nodes = [1,2,3];

            busdata = table(name,numPhases,nodes);

            name = "675";
            numPhases = 3;
            nodes = [1,2,3];
            appendbus = table(name,numPhases,nodes);

            runs_buses = cell(1,2);
            runs_buses{1} = busdata;
            runs_buses{2} = appendbus;

            out = dss_send_recorded(Buses=runs_buses);

            temp = vertcat(runs_buses{:});
            expected = splitvars(convertvars(temp,{'name'},'categorical'));

            testCase.verifyEqual(out.busdata, expected);
        end

        function collectMultipleSetTest(testCase)

            name = "650632";
            bus1 = "rg60.1.2.3";
            bus2 = "632.1.2.3";

            linedata = table(name,bus1,bus2);

            name = "632670";
            bus1 = "632.1.2.3";
            bus2 = "670.1.2.3";

            appendline = table(name,bus1,bus2);

            runs_lines = cell(1,2);
            runs_lines{1} = linedata;
            runs_lines{2} = appendline;

            name = "sourcebus";
            numPhases = 3;
            nodes = [1,2,3];

            busdata = table(name,numPhases,nodes);

            
            name = "675";
            numPhases = 3;
            nodes = [1,2,3];
            appendbus = table(name,numPhases,nodes);

            runs_buses = cell(1,2);
            runs_buses{1} = busdata;
            runs_buses{2} = appendbus;

            out = dss_send_recorded(Buses=runs_buses,Lines=runs_lines);

            tempbus = vertcat(runs_buses{:});
            expectedbus = splitvars(convertvars(tempbus,{'name'},'categorical'));

            templines = vertcat(runs_lines{:});
            expectedlines = splitvars(convertvars(templines,{'name','bus1','bus2'},'categorical'));

            testCase.verifyEqual(out,struct('busdata',expectedbus,'linedata',expectedlines));
        end

        function structInputTest(testCase)

            runs = struct();

            name = "650632";
            bus1 = "rg60.1.2.3";
            bus2 = "632.1.2.3";

            linedata = table(name,bus1,bus2);

            name = "632670";
            bus1 = "632.1.2.3";
            bus2 = "670.1.2.3";

            appendline = table(name,bus1,bus2);

            runs.Lines = cell(1,2);
            runs.Lines{1} = linedata;
            runs.Lines{2} = appendline;

            name = "sourcebus";
            numPhases = 3;
            nodes = [1,2,3];

            busdata = table(name,numPhases,nodes);

            name = "675";
            numPhases = 3;
            nodes = [1,2,3];
            appendbus = table(name,numPhases,nodes);

            runs.Buses = cell(1,2);
            runs.Buses{1} = busdata;
            runs.Buses{2} = appendbus;

            out = dss_send_recorded(runs);

            tempbus = vertcat(runs.Buses{:});
            expectedbus = splitvars(convertvars(tempbus,{'name'},'categorical'));

            templines = vertcat(runs.Lines{:});
            expectedlines = splitvars(convertvars(templines,{'name','bus1','bus2'},'categorical'));

            testCase.verifyEqual(out,struct('busdata',expectedbus,'linedata',expectedlines));
        end
    end

end