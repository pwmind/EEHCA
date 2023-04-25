function outarray = format_interpolated(inarray,period,orig_size)
%format_interpolated Generate an interpolated vector with 0 padding
%   Create an interopolated array.  The interpolated array will not be
%   sized to match (1/period)*orig_size so padding will need to be added to
%   the beginning and end of the array.
    temp = transpose(interp1(1:orig_size,inarray(1:orig_size),1:period:orig_size));

    outarray = [0; 0; temp; 0];
end