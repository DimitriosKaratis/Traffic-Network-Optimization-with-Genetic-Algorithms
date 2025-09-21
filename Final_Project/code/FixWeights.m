% This function changes the weights of the network based on the given mutations
% (if a weight changes, we need to change all the weights that depend on it,
% so that the constraints are still satisfied).
% (used alongside the Mutation function).
function [weight_new] = FixWeights(weight, weight_new, weight_limits)

    % Ensure the first four weights are within the allowed bounds
    if (weight_new(1) >= 0 && weight_new(1) < weight_limits(1)) && ...
       (weight_new(2) >= 0 && weight_new(2) < weight_limits(2)) && ...
       (weight_new(3) >= 0 && weight_new(3) < weight_limits(3)) && ...
       (weight_new(4) >= 0 && weight_new(4) < weight_limits(4))

        % Split weight_new(1) if it differs from weight(1)
        if weight_new(1) ~= weight(1)
            isValid = false;
            while ~isValid
                % Split weight_new(1) into weight_new(5) and weight_new(6)
                weight_new(5) = rand * weight_new(1);
                weight_new(6) = weight_new(1) - weight_new(5);
                isValid = (weight_new(5) >= 0 && weight_new(5) < weight_limits(5)) && ...
                          (weight_new(6) >= 0 && weight_new(6) < weight_limits(6));
            end
        end

        % Split weight_new(2) if it differs from weight(2)
        if weight_new(2) ~= weight(2)
            isValid = false;
            while ~isValid
                % Split weight_new(2) into weight_new(7) and weight_new(8)
                weight_new(7) = rand * weight_new(2);
                weight_new(8) = weight_new(2) - weight_new(7);
                isValid = (weight_new(7) >= 0 && weight_new(7) < weight_limits(7)) && ...
                          (weight_new(8) >= 0 && weight_new(8) < weight_limits(8));
            end
        end

        % Split weight_new(4) if it differs from weight(4)
        if weight_new(4) ~= weight(4)
            isValid = false;
            while ~isValid
                % Split weight_new(4) into weight_new(9) and weight_new(10)
                weight_new(10) = rand * weight_new(4);
                weight_new(9) = weight_new(4) - weight_new(10);
                isValid = (weight_new(9) >= 0 && weight_new(9) < weight_limits(9)) && ...
                          (weight_new(10) >= 0 && weight_new(10) < weight_limits(10));
            end
        end

        % Adjust the flow weights if necessary
        if weight_new(9) ~= weight(9) || weight_new(3) ~= weight(3) || weight_new(8) ~= weight(8)
            isValid = false;
            while ~isValid
                % Adjust flow weights for combined flow
                combinedFlow = weight_new(9) + weight_new(3) + weight_new(8);
                weight_new(11) = rand * combinedFlow;
                weight_new(12) = rand * combinedFlow;
                weight_new(13) = combinedFlow - weight_new(11) - weight_new(12);
                weight_new(17) = weight_new(10) + weight_new(11);

                % Ensure all the adjusted flows are within bounds
                isValid = (weight_new(11) > 0 && weight_new(11) < weight_limits(11)) && ...
                          (weight_new(12) > 0 && weight_new(12) < weight_limits(12)) && ...
                          (weight_new(13) > 0 && weight_new(13) < weight_limits(13)) && ...
                          (weight_new(17) > 0 && weight_new(17) < weight_limits(17));
            end
        end

        % Adjust the second set of flow weights if necessary
        if weight_new(7) ~= weight(7) || weight_new(6) ~= weight(6) || weight_new(13) ~= weight(13)
            isValid = false;
            while ~isValid
                % Adjust combined flow for second set of weights
                combinedFlow2 = weight_new(6) + weight_new(7) + weight_new(13);
                weight_new(14) = rand * 37.12;
                weight_new(15) = combinedFlow2 - weight_new(14);
                weight_new(16) = weight_new(5) + weight_new(14);

                % Ensure all flows remain within valid bounds
                isValid = (weight_new(14) >= 0 && weight_new(14) < weight_limits(14)) && ...
                          (weight_new(15) >= 0 && weight_new(15) < weight_limits(15)) && ...
                          (weight_new(16) >= 0 && weight_new(16) < weight_limits(16));
            end
        end

        % Ensure the sum of weights 10 and 11 is updated correctly
        if weight_new(10) ~= weight(10) || weight_new(11) ~= weight(11)
            weight_new(17) = weight_new(10) + weight_new(11);
        end
    end
end
