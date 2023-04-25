
function cmdlist = gen_pvsystem_cmds(buses, loads)

    cmdlist = {};

    for i = 1:height(buses)
    
        bus = buses(i,:);
    
        % Don't attach a PV to the source bus
        if (strcmp(string(bus.name),"Source"))
            continue;
        end
    
        attached_loads = loads(contains(string(Loads.busName),string(bus.name)),:);
    
        voltage = bus.voltage / bus.voltagePU / 1000;
    
        if (bus.numPhases > 1)
            voltage = voltage * sqrt(3);
        end
        
        % Power output of the PV array should be equal to the max kW attached
        % to the bus
        % XXX: or should it be the sum of all power on the bus?
        maxkW = max(attached_loads.kW);
    
        % only add PVSystem to loaded busses.
        if (isempty(maxkW))
            continue;
        end

        % constant power factor of 1.0 
        pf = 1.0;
    
        % Set the max power point to the power output of the array
        pmpp = maxkW;
        
        cmdlist{end+1} = sprintf("new PVSystem.PVbus%s bus1=%s irradiance=1 phases=%1.0f kv=%2.2f kVA=%2.2f pf=%2.2f pmpp=%2.2f daily=irradiance",string(bus.name), string(bus.name), bus.numPhases, voltage, maxkW, pf,pmpp);
        
    end
end