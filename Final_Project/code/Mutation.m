% This function implements the mutation operation on a given solution
function [weight_new] = Mutation(weight, c, V, tolerance, mutationRate)
    weight_new = weight;
    perturbationFactor = 0.1;  
    
    % Apply mutations
    for i = 1:length(weight)
        if rand() < mutationRate
            % Perturbation with normal distribution
            mutationAmount = normrnd(0, perturbationFactor * weight(i));
            weight_new(i) = weight(i) + mutationAmount;
        end
    end
    
    % Handle constraints
    weight_new = max(weight_new, 0);
    weight_new = min(weight_new, c - tolerance);
    
    % Try to fix weights multiple times before giving up
    for attempt = 1:3
        fixed_weights = FixWeights(weight, weight_new, c);
        if Check(fixed_weights, c, V, tolerance)
            weight_new = fixed_weights;
            return;
        end
        % If fixing failed, try a smaller mutation
        weight_new = weight + 0.5 * (weight_new - weight);
    end
    
    % Only revert if all attempts failed
    if ~Check(weight_new, c, V, tolerance)
        weight_new = weight;
    end
end
