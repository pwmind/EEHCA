function interpolated = interpolate_data(data,period) 
% interpolate_data Generate interpolated version of data
% Data must have the following columns: DNI, DHI, GHI, SurfaceAlbedo
% data - table
% period - fraction of hour for interpolation.  I.E., 15 minutes = 0.25.

% Need to add input checking for data.  Possibly include list for columns
% to include

    inverse = 1/period;
    orig_size = size(data,1);
    %interp_size = orig_size*inverse;

    interpolated = table;
    
    interpolated.Month = repelem(data.Month,inverse);
    interpolated.Day = repelem(data.Day,inverse);
    interpolated.Hour = repelem(data.Hour,inverse);

    % needs to be fixed to auto size according to period
    interpolated.Minute = repmat([0; 15; 30; 45], [orig_size,1]);
    
    interpolated.DNI = format_interpolated(data.DNI,period,orig_size);
    interpolated.DHI = format_interpolated(data.DHI,period,orig_size);
    interpolated.SurfaceAlbedo = format_interpolated(data.SurfaceAlbedo,period,orig_size);
    interpolated.GHI = format_interpolated(data.GHI,period,orig_size);
    interpolated.Temperature = format_interpolated(data.Temperature,period,orig_size);
end