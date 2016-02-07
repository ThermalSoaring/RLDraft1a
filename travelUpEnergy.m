function [ ] = travelUpEnergy( nSteps, stepSize, windField, startPos, gridParams)
%travelUpEnergy The plane moves towards higher energy each step

% Specify the mesh used for value generation
meFVFun = gridParams(1) ;
sideLength = gridParams(2);

% Store the points our path goes through
pathPoints = zeros(nSteps, 2);
pathPoints(1,:) = startPos;

% Store current position
currPos = startPos;

for i = 1:(nSteps-1) % Move n-1 times to get n points        
    %% Evaluate the windField on a grid surrounding this point  
    % Calling form:
    % value function, fineness of local value function, side of square
    % discretized value function returned, UAV position  
    gridSideSize = sideLength*meFVFun; % Needs to be an even multiple of meF
    nearE = getLocalValue(windField, meFVFun, gridSideSize, currPos);
    
    %% Greedy Policy
    % Calling form:
    % local value function, fineness of local value function, 
    % UAV position, norm of displacement vector 
    nextPos  = greedyPolicy(nearE, meFVFun, currPos, stepSize);
    
    %% Update path
    
    % End when i = 9, and we have 10 points
    pathPoints(i+1,:) = nextPos; %pathPoints(i,:) + vToMove;
    
    % Update current position
    currPos = pathPoints(i+1,:);
end

% Plots the path
xPath = pathPoints(:,1);
yPath = pathPoints(:,2);
plot(xPath, yPath,'k','LineWidth',4);

end

