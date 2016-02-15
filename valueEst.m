function [ inputVals, targets ] = valueEst(gridParams,windField,trainGrid,numMeFSteps)
% Create training data for neural net (regression)
% Given (x,y), tells the value of going right
    
    % Unpacking training grid parameters
    xBoundsTrain = trainGrid(1,:);
    yBoundsTrain = trainGrid(2,:);
    trainDataFineness = trainGrid(3,1);
    
    % Specify the mesh used for value generation
    meFVFun = gridParams(1) ;
    sideLength = gridParams(2);

    % Define the points at which we provide training data
    xValsTrain = xBoundsTrain(1):trainDataFineness:xBoundsTrain(2);
    yValsTrain = yBoundsTrain(1):trainDataFineness:yBoundsTrain(2);
    
    % Create a matrix of the input vales
    % Each row contains an (x,y) pair  
    inputVals=zeros(length(xValsTrain)*length(yValsTrain),2);
    
    % Create a vector of target values (values)
    targets = zeros(length(xValsTrain)*length(yValsTrain),1);
    
    % Create training data at each of these specified points
    trainData = zeros(length(xValsTrain), length(yValsTrain));  
    
    % Keep track of where we are in the grid
    whichInput = 1;
    whichX = 1;  
    for trainX =  xValsTrain
        whichY = 1;
        for trainY = yValsTrain            
            
            % Define start position 
            currPosTrain = [trainX trainY];                     
               
            % Get local value function
            gridSideSize = sideLength*meFVFun; 
            nearE = getLocalValue(windField, meFVFun, gridSideSize, currPosTrain);
            
            % Find current value
            currVal = nearE(1,1);
            
            % Find value after moving to the right
            % numMeFSteps is the number of grid steps we take to the right            
            valAfterRight = nearE(1 + numMeFSteps,1); % Position of max energy
            
            % Find different in value
            valueMove = valAfterRight - currVal;
            
            % Append just calculated value of moving right to training data
            trainData(whichX, whichY) = valueMove;            
            
            % Append input output pair to matrices for training neural net
            inputVals(whichInput,:) = [trainX, trainY];
            targets(whichInput) = valueMove;            
            
            whichY = whichY + 1;
            whichInput = whichInput + 1;
        end
        whichX = whichX  + 1;
    end   
    
    % Plot surface
    [X , Y] = meshgrid(xValsTrain,yValsTrain);
    z = rot90(trainData,2);
    figure();
    surf(X,Y,z);
end

