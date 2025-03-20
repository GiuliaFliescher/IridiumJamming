function extracted = extract_message_sizes_from_log(filename,saveas)% Define the filename (replace with your actual filename)

% Read the file content
fid = fopen(filename, 'r');
rawText = fread(fid, '*char')';
fclose(fid);

% Define the pattern to match anything inside square brackets
pattern = '\[[^\]]*\]';

% Extract all matches of the pattern
matches = regexp(rawText, pattern, 'match');


% Initialize an array to store the count of '(' in each match
messagelength = zeros(length(matches), 1);

% Loop through all matches and count the number of '(' characters in each
for i = 1:length(matches)
    % Count the number of '(' characters in the current match
    messagelength(i) = count(matches{i}, '(');
end

% Initialize an array to store the numeric values
jamming = [];

% Loop through all matches and extract numeric values
for i = 1:length(matches)
    % Extract the numbers from the current match using regular expression
    numberPattern = '-?\d+\.\d+'; % Pattern to match decimal numbers
    numbers = regexp(matches{i}, numberPattern, 'match');
    
    % Convert the numbers to a double array
    numericArray = str2double(numbers);
    
    % Ensure numericArray is a column vector and append to the numericValues array
    jamming = [jamming; numericArray(:)];  % This ensures vertical concatenation
end

save(saveas, "jamming", "messagelength")