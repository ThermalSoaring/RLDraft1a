function [ inputVals, targets ] = createTrainData(gridParams,windField,trainGrid,arrSizeTrain,printToGraph,nDirections)
% Create training data for neural net
% Given (x,y,z,windValue) tells best direction to go
    
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
    
    % Create a vector of target values
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
               
            % Find ideal next position
            gridSideSize = sideLength*meFVFun; 
            nearE = getLocalValue(windField, meFVFun, gridSideSize, currPosTrain);
            nextPosTrain  = greedyPolicy(nearE, meFVFun, currPosTrain, arrSizeTrain);
            
            % Snap to nearest compass direction
            
            % Create arrows of the right length in the compass directions
            
            angles = 0:(2*pi/nDirections):2*pi;
            xRef = arrSizeTrain*cos(angles);
            yRef = arrSizeTrain*sin(angles);
            refArrow = [xRef', yRef'];            
            refArrow = refArrow(1:end-1,:);
            
            % Find closest compass direction arrow to ideal travel arrow
            origArrow = nextPosTrain - currPosTrain;
            distFromCompass = refArrow * origArrow';
            [~, bestArrowIndex] = max(distFromCompass);
            bestArrow = refArrow(bestArrowIndex,:);           
            
            % Append just calculated arrow to training data
            trainData(whichX, whichY) = bestArrowIndex;            
            
            % Append input output pair to neural matrices
            inputVals(whichInput,:) = [trainX, trainY];
            targets(whichInput) = bestArrowIndex;
            
            
            % Display current arrow in training data
            if (printToGraph == 1)
                dispArrow(currPosTrain, currPosTrain + bestArrow);
            end
            
            whichY = whichY + 1;
            whichInput = whichInput + 1;
        end
        whichX = whichX  + 1;
    end    
    
    % Print in an orientation that is easy to match with the graph
    disp(flipud(trainData'))  
end

