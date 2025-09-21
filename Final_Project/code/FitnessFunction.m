% This function computes the fitness of a given population for the genetic algorithm
function [fitnessValues] = FitnessFunction(a, c, population, t, tolerance)
    % Ensure population values stay within the valid range
    population = min(max(population, 0), c - tolerance); 

    % Compute the time for each individual
    timeArray = t + a .* (population ./ (1 - (population ./ c) + 1e-6));

    % Sum total time across individuals
    totalTime = sum(timeArray, 2) + 1e-6;  % Prevent division issues

    % Fitness function is the negative total time (we maximize fitness to minimize total time)
    fitnessValues = -totalTime;
end
