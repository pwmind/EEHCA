function out = dss_run_sim(DSSCircuit, DSSCircObj, DSSText, numpts, collectionflags)
%dss_run_sim Run the currently configured simulation and output recorded values
%   Execute the simulation using the currently set configuration.  Returns
%   a struct containing the busdata, loaddata, linedata, transformerdata,
%   and lossdata.

    global scriptname;

    if ~isempty(scriptname)
        logger = mlog.Logger(scriptname);
    
        logger.info("Running dss_run_sim");
    end

    % Run the simulations, record the results. Only data in OpenDSS COM
    % objects are recorded.
    
    % Calculate voltage bases before running the solution to guarantee all
    % buses are created.
    run_dss_command(DSSText,"calcv");
    
    collectionnames = fieldnames(collectionflags);

    runs = struct();

    for i=1:height(collectionnames)
        if collectionflags.(collectionnames{i})
            runs.(collectionnames{i}) = cell(1,numpts);
        end
    end

    for i = 1:numpts
    
        % solve the circuit for this time period
        DSSCircuit.Solution.Solve;
    
        % If the solution failed to converge, collect the currently
        % recorded information and add an Error field to the return struct
        % with the exception information.
        if (DSSCircuit.Solution.Converged == false)

            iterations = DSSCircuit.Solution.Totaliterations;

            E = MException('EE480HCA:OpenDSS:SolutionConvergenceError', "Solution failed to converge at iteration %d",iterations);

            out = dss_send_recorded(runs);

            out.Error = E;
            logger.error(E.message);

            % Errored so return to end execution of the function.
            return
        end

        % Collect data for the flagged data types
        if (collectionflags.Buses)
            buses = struct2table(getBusInfo(DSSCircObj));
            buses.RunNum = repmat(i,height(buses),1);
            runs.Buses{i} = buses;
        end

        if (collectionflags.Loads)
            loads = struct2table(getLoadInfo(DSSCircObj));
            loads.RunNum = repmat(i,height(loads),1);
            runs.Loads{i} = loads;
        end

        if (collectionflags.Lines)
            lines = struct2table(getLineInfo(DSSCircObj));
            lines.RunNum = repmat(i,height(lines),1);
            runs.Lines{i} = lines;
        end

        if (collectionflags.Transformers)
            transformers = struct2table(getTransformerInfo(DSSCircObj));
            transformers.RunNum = repmat(i,height(transformers),1);
            runs.Transformers{i} = transformers;
        end

        if (collectionflags.PVSystems)
            pvsystems = struct2table(getPVInfo(DSSCircObj));
            pvsystems.RunNum = repmat(i,height(pvsystems));
            runs.PVSystems{i} = pvsystems;
        end

    end

    out = dss_send_recorded(runs);
end