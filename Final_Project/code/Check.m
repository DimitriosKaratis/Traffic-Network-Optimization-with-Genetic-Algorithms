% This function checks if the given weight vector could be a valid solution 
% to the problem based on the problem's constraints.
function [passed] = Check(weight, c, V, tolerance)
    passed = false;
    
    % Check if any weight is out of bounds
    if any(weight > c) || any(weight < 0)
        return; 
    end
    
    % Define the conditions
    conditions = [
        abs(weight(1) + weight(2) + weight(3) + weight(4) - V) < tolerance;
        abs(weight(1) - (weight(5) + weight(6))) < tolerance;
        abs(weight(2) - (weight(7) + weight(8))) < tolerance;
        abs(weight(4) - (weight(9) + weight(10))) < tolerance;
        abs(weight(3) + weight(8) + weight(9) - (weight(11) + weight(12) + weight(13))) < tolerance;
        abs(weight(13) + weight(7) + weight(6) - (weight(14) + weight(15))) < tolerance;
        abs(weight(14) + weight(5) - weight(16)) < tolerance;
        abs(weight(11) + weight(10) - weight(17)) < tolerance;
        abs(weight(17) + weight(12) + weight(15) + weight(16) - V) < tolerance
    ];
    
    % Check if all conditions are met
    if all(conditions)
        passed = true; 
    end
end