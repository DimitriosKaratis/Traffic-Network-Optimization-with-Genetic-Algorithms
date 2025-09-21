% This function generates the next population based on the fitness proportions of the current populations
function [newPopulation] = GenerateNextPopulation(currentPopulation, fitnessProportions, selectedIndices)
    numIndividuals = size(currentPopulation, 1); % Number of individuals in the population
    numGenes = size(currentPopulation, 2); % Number of genes per individual
    newPopulation = zeros(numIndividuals, numGenes);

    % Create the new population based on fitness proportions
    count = 1;
    for i = 1:length(fitnessProportions)
        if fitnessProportions(i) > 0
            % Add the individual to the new population the specified number of times
            for j = 1:fitnessProportions(i)
                if count <= numIndividuals
                    newPopulation(count, :) = currentPopulation(selectedIndices(i), :);
                    count = count + 1;
                else
                    break; % Stop if the population is full
                end
            end
        end
    end

    % If the population is not fully filled, fill the remaining slots with random individuals
    if count <= numIndividuals
        remainingIndices = setdiff(1:numIndividuals, selectedIndices); 
        numRemaining = numIndividuals - count + 1;
        newPopulation(count:end, :) = currentPopulation(remainingIndices(1:numRemaining), :);
    end
end