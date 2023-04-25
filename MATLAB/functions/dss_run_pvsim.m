function output = dss_run_pvsim(DSSCircuit,DSSCircObj,DSSText,pvsystem,pvlevel,numpts,collectionflags)
%dss_run_pvsim Run a simulation on the current circuit with the PVSystems
%at the specified levels
%   Run a simulation on teh current circuit with the PVSystems at the
%   current level.  Output adds PVKW and PVSystem to each output record.

    %{
    % XXX: this was added to handle multi-bus scenarios.  This should be
    % rethought.
    for pvsystem = string(pvsystems)
        run_dss_command(DSSText,sprintf("Edit PVSystem.%s kVA=%d pmpp=%d",pvsystem, pvlevel, pvlevel));
    end
    %}

    global scriptname;

    if ~isempty(scriptname)
        logger = mlog.Logger(scriptname);
    
        logger.info(sprintf("Running dss_run_pvsim: pvsystem=%s, pvlevel=%d, numpts=%d",pvsystem,pvlevel,numpts));
    end
    
    output = dss_run_sim(DSSCircuit,DSSCircObj,DSSText,numpts,collectionflags);
    
    % Add PVKW and PVSystem fields to the data
    if (collectionflags.Buses)
        output.busdata.PVKW = repmat(pvlevel,height(output.busdata),1);
        output.busdata.PVSystem = repmat(pvsystem,height(output.busdata),1);
    end

    if (collectionflags.Loads)
        output.loaddata.PVKW = repmat(pvlevel,height(output.loaddata),1);
        output.loaddata.PVSystem = repmat(pvsystem,height(output.loaddata),1);
    end

    if (collectionflags.Lines)
        output.linedata.PVKW = repmat(pvlevel,height(output.linedata),1);
        output.linedata.PVSystem = repmat(pvsystem,height(output.linedata),1);
    end
    
    if (collectionflags.Transformers)
        output.transformerdata.PVKW = repmat(pvlevel,height(output.transformerdata),1);
        output.transformerdata.PVSystem = repmat(pvsystem,height(output.transformerdata),1);
    end

    if (collectionflags.PVSystems)
        output.pvsystemdata.PVKW = repmat(pvlevel,height(output.pvsystemdata),1);
        output.pvsystemdata.PVSystem = repmat(pvsystem,height(output.pvsystemdata),1);
    end
end