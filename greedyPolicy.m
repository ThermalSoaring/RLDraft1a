function [ nextPos ] = greedyPolicy( Vnear, meF, currPos, stepSize)
%greedyPolicy: Move to the highest value position nearby
% Vnear is value function for nearby states
% meF is the mesh fineness of the value function data provided
% currPos is the current position of the UAV
% stepSize is the distance the aircraft travels each step

    % Find the maximum location of the value of nearby states
    [~,I] = max(Vnear(:));
    [I_row, I_col] = ind2sub(size(Vnear),I); 
    
    % Reference our displacement with (0,0) in center of value matrix
    % Value matrix needs to have an odd number of rows and columns
    % So that we can find a center
    if (sum(mod(size(Vnear),2) == 0) > 0)
       error('Error: V must have an odd number of rows and columns');        
    end
    I_row = -I_row + (size(Vnear,2)+1)/2;   % y correction 
    I_col = I_col - (size(Vnear,2)+1)/2;    % x correction for 5x5 matrix is: -3 ( -(n_col + 1)/2) (for odd)
    
    pMaxE = [currPos(1) + meF*I_col,currPos(2) + meF*I_row]; % Position of max energy
      
    % Displacement vector to desired place from current position
    pDiff = pMaxE - currPos;

    % Return new position
    if (norm(pDiff) ~= 0) % Avoid dividing by zero
        vToMove = stepSize * (pDiff/norm(pDiff));   
        nextPos = currPos + vToMove;
    else
        nextPos = currPos;
    end   

end

