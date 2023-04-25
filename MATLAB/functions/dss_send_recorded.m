function out = dss_send_recorded(varargin)
%function out = dss_send_recorded(NameValueArgs)
%dss_send_recorded Collect the currently recorded values and return them in
%a struct
%   Collect the currently recorded values and return them in a struct.
%   Columns that contain categorical data are converted to the categorical
%   type

    % funcation arguments are in Name=Value format or rolled into a struct
    defaultcell = cell(0,0);

    p = inputParser;
    addParameter(p,'Buses',defaultcell);
    addParameter(p,'Loads',defaultcell);
    addParameter(p,'Lines',defaultcell);
    addParameter(p,'Transformers',defaultcell);
    addParameter(p,'PVSystems',defaultcell);
    parse(p,varargin{:});


    global scriptname;

    if ~isempty(scriptname)
        logger = mlog.Logger(scriptname);
    
        logger.info("Running dss_send_recorded");
    end

    out = struct;

    % Send MATLAB recorded data
    
    if height(p.Results.Buses) > 0
        busdata = vertcat(p.Results.Buses{:});
        out.busdata = splitvars(convertvars(busdata,{'name'},'categorical'));
    end
    
    if height(p.Results.Loads) > 0
        loaddata = vertcat(p.Results.Loads{:});
        out.loaddata = splitvars(convertvars(loaddata,{'name','busName'},'categorical'));
    end

    if height(p.Results.Lines) > 0
        linedata = vertcat(p.Results.Lines{:});
        out.linedata = splitvars(convertvars(linedata,{'name','bus1','bus2'},'categorical'));
    end

    if height(p.Results.Transformers) > 0
        transformerdata = vertcat(p.Results.Transformers{:});
        out.transformerdata = splitvars(convertvars(transformerdata,{'name','bus1','bus2'},'categorical'));
    end

    if height(p.Results.PVSystems) > 0
        pvsystemdata = vertcat(p.Results.PVSystems{:});
        out.pvsystemdata = pvsystemdata;
    end

end