classdef run_dss_commandTest < matlab.mock.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        
            
        
    end

    methods (Test)
        % Test methods

        function throwsWarning(testCase)

            import matlab.mock.actions.AssignOutputs;

            [mock,behavior] = createMock(testCase,'AddedMethods',{'get'},'AddedProperties',{'command'});

            warningCommand = "New PVSystem.PVbus634";
            warningOutput = 'Warning: Duplicate new element definition: "PVSystem.PVbus634"←↵Element being redefined.';
            
            testCase.assignOutputsWhen(withAnyInputs(behavior.get),...
                struct('Command',warningCommand,'Result',warningOutput));

            testCase.verifyWarning(@() run_dss_command(mock,warningCommand),'run_dss_command:ResultWarning');

        end
    end

end