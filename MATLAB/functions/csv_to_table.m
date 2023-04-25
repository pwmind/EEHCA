function outtable = csv_to_table(csvlist)
%csv_to_table Combine list of CSV files to a single table
%   Given a list of CSV files, each with the same header, take the data
%   from each file and combine the results into a single table
    
    % suppress warnings about column header renaming
    warning('off','MATLAB:table:ModifiedAndSavedVarnames');

    listlen = length(csvlist);

    tmplist = cell(1,listlen);

    for i=1:listlen
        opts = detectImportOptions(csvlist{i});
        csvdata = readtable(csvlist{i},opts);

        % No data for this run, continue
        if height(csvdata) < 1
            continue;
        else
            csvdata.RunNum = repmat(i,height(csvdata),1);
        end

        tmplist{i} = csvdata;
    end

    outtable = vertcat(tmplist{:});
end