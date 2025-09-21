% This function generates the inital population of the genetic algorithm
function [weight] = GenerateInitialPopulation(V, weight_limits)

    weight = zeros(1, 17);    

    % Generate initial weights for indices 1 to 4
    while true
        weight(1) = rand * weight_limits(1);
        weight(2) = rand * weight_limits(2);
        weight(3) = rand * weight_limits(3);
        weight(4) = rand * weight_limits(4);
        total = weight(1) + weight(2) + weight(3) + weight(4);

        weight(1:4) = (weight(1:4) / total) * V;

        if weight(1) < weight_limits(1) && weight(2) < weight_limits(2) && weight(3) < weight_limits(3) && weight(4) < weight_limits(4) && ...
           weight(1) >= 0 && weight(2) >= 0 && weight(3) >= 0 && weight(4) >= 0
            break;
        end
    end

    % Split weight(1) into weight(5) and weight(6)
    while true
        weight(5) = rand * weight(1);
        weight(6) = weight(1) - weight(5);
        if weight(5) < weight_limits(5) && weight(6) < weight_limits(6) && weight(5) >= 0 && weight(6) >= 0
            break;
        end
    end

    % Split weight(2) into weight(7) and weight(8)
    while true
        weight(7) = rand * weight(2);
        weight(8) = weight(2) - weight(7);
        if weight(7) < weight_limits(7) && weight(8) < weight_limits(8) && weight(7) >= 0 && weight(8) >= 0
            break;
        end
    end

    % Split weight(4) into weight(9) and weight(10)
    while true
        weight(9) = rand * weight(4);
        weight(10) = weight(4) - weight(9);
        if weight(9) < weight_limits(9) && weight(10) < weight_limits(10) && weight(9) >= 0 && weight(10) >= 0
            break;
        end
    end

    % Generate weights 11 to 13 based on combinedFlow
    combinedFlow = weight(9) + weight(3) + weight(8);
    while true
        weight(11) = rand * combinedFlow;
        weight(12) = rand * combinedFlow;
        weight(13) = combinedFlow - weight(11) - weight(12);
        weight(17) = weight(10) + weight(11);

        if weight(11) > 0 && weight(11) < weight_limits(11) && ...
           weight(12) > 0 && weight(12) < weight_limits(12) && ...
           weight(13) > 0 && weight(13) < weight_limits(13) && ...
           weight(17) > 0 && weight(17) < weight_limits(17) 
            break;
        end
    end

    % Generate weights 14 to 16 based on combinedFlow2
    combinedFlow2 = weight(6) + weight(7) + weight(13);
    while true
        weight(14) = rand * weight_limits(14);
        weight(15) = combinedFlow2 - weight(14);
        weight(16) = weight(5) + weight(14);

        if weight(14) > 0 && weight(14) < weight_limits(14) && ...
           weight(15) > 0 && weight(15) < weight_limits(15) && ...
           weight(16) > 0 && weight(16) < weight_limits(16)
            break;
        end
    end
end
