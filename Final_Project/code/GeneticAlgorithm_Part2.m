%% KARATIS DIMITRIOS 10775

%% Main script for the Genetic Algorithm implementation (Part 2, with variance in V)

clc; clear; close all;

% Random seed so that results are reproducible

a = [1.25 1.25 1.25 1.25 1.25 1.5 1.5 1.5 1.5 1.5 1 1 1 1 1 1 1];
c = [54.13 21.56 34.08 49.19 33.03 21.84 29.96 24.87 47.24 33.97 ...
        26.89 32.76 39.98 37.12 53.83 61.65 59.73];
t = ones([1, 17]) * 1;

% V between 85 and 115
V = 100; 
V = V * (0.85 + 0.30 * rand);
fprintf("V: %.2f\n", V);
tolerance = 1e-7;
population_size = 30;

% Initialize population
initialPopulation = zeros(population_size, 17);
for i = 1:population_size
    initialPopulation(i, :) = GenerateInitialPopulation(V, c);
end

% Fitness evaluation
fitnessScores = FitnessFunction(a, c, initialPopulation, t, tolerance);
[selectionCounts, selectedIndices] = Roulette(fitnessScores);
generationCount = 0;
fitnessEvolution = zeros(1000, population_size);
fitnessEvolution(1, :) = fitnessScores';

% Maximum number of generations to prevent infinite loops
maxGenerations = 1000; 

while generationCount < maxGenerations
    % Dynamic mutation rate
    mutationRate = max(0.05, 0.5 * exp(-generationCount / 200));

    % Generate new population
    generationCount = generationCount + 1;
    newPopulation = GenerateNextPopulation(initialPopulation, selectionCounts, selectedIndices);
    fitnessEvolution(generationCount, :) = FitnessFunction(a, c, newPopulation, t, tolerance)';
    
    % Mutate the population
    mutationIndices = randperm(population_size, ceil(mutationRate * population_size));
    for i = mutationIndices
        newPopulation(i, :) = Mutation(newPopulation(i, :), c, V, tolerance, mutationRate);
    end

    % Perform crossover
    [parent1Index, parent2Index] = deal(randi([1, population_size]), randi([1, population_size]));
    [newPopulation(parent1Index, :), newPopulation(parent2Index, :)] = ...
        Crossover(newPopulation(parent1Index, :), newPopulation(parent2Index, :), c, V, tolerance);
    
    % Check for convergence
    if generationCount > 1
        change = norm((fitnessEvolution(generationCount - 1, :) - fitnessEvolution(generationCount, :)) ./ fitnessEvolution(generationCount - 1, :));
        if change < 1e-7
            break;
        end
    end
    
    % Select the next generation
    [selectionCounts, selectedIndices] = Roulette(fitnessEvolution(generationCount, :));
    initialPopulation = newPopulation;
end

% Print results
fprintf("Number of generations until convergence: %d\n", generationCount);
fprintf("Final Chromosome:\n");
fprintf("%.2f ", newPopulation(population_size, :));
fprintf("\n");
totalTime = 0;
for j = 1:17
    totalTime = totalTime + t(j) + a(j) * newPopulation(population_size, j) / (1 - (newPopulation(population_size, j) / c(j)));
end
fprintf("Total time: %.2f\n", totalTime);
if Check(newPopulation(population_size, :), c, V, tolerance) == true
    fprintf("The solution is feasible.\n");
else
    fprintf("The solution is NOT feasible.\n");
end

% Plot fitness evolution
figure;
plot(1:generationCount, fitnessEvolution(1:generationCount, :), '-o', 'LineWidth', 2.5);
title('Fitness Evolution Across Generations (WITH VARIANCE IN V)', 'FontSize', 18);
xlabel('Generations', 'FontSize', 16);
ylabel('Fitness (-Total Time)', 'FontSize', 16);
legend('Fitness', 'Location', 'best', 'FontSize', 16);
set(gca, 'FontSize', 16);

% Plot max and average fitness evolution
figure;
maxFitnessPerGeneration = max(fitnessEvolution(1:generationCount, :), [], 2);
avgFitnessPerGeneration = mean(fitnessEvolution(1:generationCount, :), 2);
plot(1:generationCount, maxFitnessPerGeneration, '-o', 'LineWidth', 2.5, 'MarkerSize', 5, 'DisplayName', 'Best Fitness');
hold on;
plot(1:generationCount, avgFitnessPerGeneration, '-s', 'LineWidth', 2.5, 'MarkerSize', 5, 'DisplayName', 'Average Fitness');
title('Fitness Evolution Across Generations (WITH VARIANCE IN V)', 'FontSize', 18);
xlabel('Generations', 'FontSize', 16);
ylabel('Fitness (-Total Time)', 'FontSize', 16);
legend('Location', 'best', 'FontSize', 16);
grid on;
set(gca, 'FontSize', 16);
hold off;
