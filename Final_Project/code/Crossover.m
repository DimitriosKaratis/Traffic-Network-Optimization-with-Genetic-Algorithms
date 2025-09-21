% This function implements the crossover operation between two parent solutions
function [child1, child2] = Crossover(mother, father, c, V, tolerance)
    % Maximum number of crossover attempts
    maxAttempts = 3; 
    
    % Initialize the offspring
    child1 = mother; 
    child2 = father;
    
    % Attempt crossover multiple times until valid offspring are produced
    for attempt = 1:maxAttempts
        % Randomly select a crossover point
        crossoverPoint = randi([1, length(mother)-1]);
        
        % Perform crossover
        child1(1:crossoverPoint) = mother(1:crossoverPoint);
        child1(crossoverPoint+1:end) = father(crossoverPoint+1:end);
        child2(1:crossoverPoint) = father(1:crossoverPoint);
        child2(crossoverPoint+1:end) = mother(crossoverPoint+1:end);
        
        % Check if both offspring satisfy the constraints
        if Check(child1, c, V, tolerance) && Check(child2, c, V, tolerance)
            return; % Exit if both offspring are valid
        end
    end
    
    % If maxAttempts is reached and no valid offspring are found, revert to parents
    child1 = mother;
    child2 = father;
end