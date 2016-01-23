function [ ] = travelUpEnergy( nSteps, windField, startPos)
%travelUpEnergy The plane moves towards higher energy each step

% Store the points our path goes through
pathPoints = zeros(nSteps, 2);
pathPoints(1,:) = startPos;

% How far we step on each change of position
stepSize = 0.05;

% Store current position
currPos = startPos;

for i = 1:(nSteps-1) % Move n-1 times to get n points
    % Evaluate the windField on a grid surrounding this point
    meF = 0.1; % mesh fineness 
    %(if you change this, you must adjust the (0,0) centering coide)
    
    meLX = currPos(1)-0.2; % mesh lower bound
    meUX = currPos(1)+0.2; % mesh upper bound
    meLY = currPos(2)-0.2; % mesh lower bound
    meUY = currPos(2)+0.2; % mesh upper bound
    
    [X , Y] = meshgrid(meLX:meF:meUX, meUY:-meF:meLY);

    % Find the point of maximum energy nearby
    % See here: http://www.mathworks.com/help/matlab/ref/max.html#bupr8_p
    nearE = windField(X,Y);
    disp(nearE)    
    [~,I] = max(nearE(:));
    [I_row, I_col] = ind2sub(size(nearE),I); 
    
    % Put (0,0) in the center (this correction is a function of mesh
    % fineness)
    I_row = -I_row + 3; % y correction
    I_col = I_col - 3; % x correction
    
    pMaxE = [currPos(1) + meF*I_col,currPos(2) + meF*I_row]; % Position of max energy
    disp(pMaxE)
    
    
    
    % Displacement vector to desired place from current position
    vDiff = pMaxE - currPos;

    % Vector to move
    vToMove = stepSize * (vDiff/norm(vDiff));  
    
    % End when i = 9, and we have 10 points
    pathPoints(i+1,:) = pathPoints(i,:) + vToMove;
    
    % Update current position
    currPos = pathPoints(i+1,:);
end

disp(pathPoints)
% Plots the path
xPath = pathPoints(:,1);
yPath = pathPoints(:,2);
plot(xPath, yPath,'k','LineWidth',4);

end

