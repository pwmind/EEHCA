classdef cos_thetaTest < matlab.unittest.TestCase

    methods (TestClassSetup)
        % Shared setup for the entire test class
    end

    methods (TestMethodSetup)
        % Setup for each test
    end

    methods (Test)
        % Test methods

        function scalarInputTest(testCase)
            phi = deg2rad(180);
            Beta = deg2rad(90);
            collector_azimuth = deg2rad(180);
            Sigma = deg2rad(45);

            actual = cos_theta(phi,Beta,collector_azimuth,Sigma);

            expected = cos(Beta) * cos(phi - collector_azimuth) * sin(Sigma) + sin(Beta) * cos(Sigma);

            testCase.verifyEqual(actual,expected);
        end

        function arrayInputTest(testCase)
            phi = deg2rad([90 180 270]);
            Beta = deg2rad([0 45 90]);
            collector_azimuth = deg2rad(180);
            Sigma = deg2rad(45);

            actual = cos_theta(phi,Beta,collector_azimuth,Sigma);

            expected = transpose(cos(Beta) .* cos(phi - collector_azimuth) .* sin(Sigma) + sin(Beta) .* cos(Sigma));

            testCase.verifyEqual(actual, expected);
        end
    end

end