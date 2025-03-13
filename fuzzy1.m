clear; clc; close all;

% Just for myself to keep track:
% Input 1 [4 8]         Sepal Length
% Input 2 [2 4.5]       Sepal Width
% Input 3 [1 7]         Petal Length
% Input 4 [2 2.5]       Petal Width

% Output 1 = Setosa
% Output 2 = Veriscolor
% Output 3 = Virginica

% Test example using the four inputs
testInput = [6 2 2 2]; 

%%

fis = readfis("IrisFlower.fis");
% evalfis(fis, testInput)

% Load data from .csv file
flowerData = readtable("IRIS.csv");

% Extract numeric input columns and the actual species
inputs = table2array(flowerData(:, 1:4));  % first 4 columns are inputs
actualSpecies = flowerData.species;        

% Preallocate
numSamples = size(inputs, 1);
outputs = strings(numSamples, 1);

% initialize counters
noRuleCount = 0;
correctPredictions = 0;

% Evaluate each row with the FIS
for i = 1:numSamples
    result = evalfis(fis, inputs(i, :));
    
    % Check if the FIS output equals 5 (default value indicating no rule fired)
    if result == 5 % I increased the Output range to [0, 10] so the mean range value is 5
        predictedSpecies = "No Answer";
        noRuleCount = noRuleCount + 1;
    else
        % Map numeric output to species labels based on result range
        if result < 1.5
            predictedSpecies = "Iris-setosa";
        elseif result < 2.5
            predictedSpecies = "Iris-veriscolor";
        elseif result < 3.5
            predictedSpecies = "Iris-virginica";
        end
    end
    
    outputs(i) = predictedSpecies;
    
    % Compare predicted with actual species
    if strcmpi(predictedSpecies, actualSpecies{i})
        correctPredictions = correctPredictions + 1;
    end
end

% Add predictions to the table
flowerData.Predicted_Species = outputs;
disp(flowerData); % Display results

% Statistics
fprintf("Number of unmatched (no-rule) sets: %d\n", noRuleCount);
fprintf("Number of correct predictions: %d out of %d (%.2f%%)\n", ...
    correctPredictions, numSamples, (correctPredictions / numSamples) * 100);
