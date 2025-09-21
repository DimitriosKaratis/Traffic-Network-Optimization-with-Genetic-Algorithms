% This function implements the roulette wheel selection method for selecting individuals
function [cnt, I] = Roulette(fit)
    % Shift fitness to make all values positive while keeping selection preference
    minFitness = min(fit);
    if minFitness < 0
        fit = fit - minFitness;  % Shift so the worst fitness is 0
    end
    fit = fit + 1e-6;  % Prevent division by zero

    % Compute selection probabilities (exponential scaling for better spread)
    probabilities = fit .^ 2;  
    totalFitness = sum(probabilities);
    
    probabilities = probabilities / totalFitness;
    
    % Compute cumulative probabilities
    cumulativeProbabilities = cumsum(probabilities);
    
    % Initialize counters for selection
    cnt = zeros(size(fit));
    
    % Generate random selection
    randomValues = rand(length(fit), 1);
    for k = 1:length(randomValues)
        for idx = 1:length(cumulativeProbabilities)
            if randomValues(k) < cumulativeProbabilities(idx)
                cnt(idx) = cnt(idx) + 1;
                break;
            end
        end
    end

    % Keep original ordering
    I = 1:length(fit);  
end

