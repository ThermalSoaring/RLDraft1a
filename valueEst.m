function [ inputVals, targets ] = valueEst(windField,trainGrid,stepRightSize,plotValue)
% Create training data for neural net (regression)
% Given (x,y), tells the value of going right
% Could extend to give calue of going in every direction
    
    % Unpacking training grid parameters
    xBoundsTrain = trainGrid(1,:);
    yBoundsTrain = trainGrid(2,:);
    trainDataFineness = trainGrid(3,1);
    
    % Define the points at which we provide training data
    xValsTrain = xBoundsTrain(1):trainDataFineness:xBoundsTrain(2);
    yValsTrain = yBoundsTrain(1):trainDataFineness:yBoundsTrain(2);
    
    % Find difference in value function on specified training grid  
    % (the difference given by moving right)
    [X , Y] = meshgrid(xValsTrain,yValsTrain);
    valHere = windField(X,Y);
    valRight = windField(X+stepRightSize,Y);
    valueDiff = valRight - valHere; % Matrix of input values 
    
    % Reshape these value difference values so we have the format:
    % (x,y) -> value difference
    xCol = reshape(X,length(xValsTrain)*length(xValsTrain),1);
    yCol = reshape(Y,length(yValsTrain)*length(yValsTrain),1);
    inputVals = [xCol yCol];
    
    targets = reshape(valueDiff,length(xValsTrain)*length(yValsTrain),1);
     
     % Plot surface as contour plot (if desired)
    if plotValue == 1
        figure();
        surf(X,Y,valueDiff);
        xlabel('x')
        ylabel('y')
        title('Value of Going Right')
    end
end

