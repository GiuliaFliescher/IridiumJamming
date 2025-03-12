% Read the file
filename = 'iqframes_2402_pt1.txt'; % Replace with your actual filename
fid = fopen(filename, 'r');
rawText = fread(fid, '*char')';
fclose(fid);

% Extract the IQ data using regular expressions
iqPattern = '\((-?\d+\.\d+),(-?\d+\.\d+)\)'; % Pattern for extracting IQ pairs
iqData = regexp(rawText, iqPattern, 'tokens');

% Convert extracted data to a double array
iqArray = cellfun(@(x) str2double(x), vertcat(iqData{:}));

% Reshape into Nx2 matrix (I and Q components)
iqframes_2402_pt1 = reshape(iqArray, [], 1);

% Display the first few rows
disp(iqframes_2402_pt1(1:10, :)); 
