function [ ] = RLDraft1( )
clearvars
close all

% Provides wind energy as a function of (x,y)
windField = createWindField();

%% Plots 2D contour plot of wind energy
% Second argument sets 3D if high. Last is mesh fineness for plotting.
meFPlot = 0.05; 
is3D = 0;
plotWindfield(windField,is3D,meFPlot);

if (is3D == 0)
    hold on

    %% Demonstrate greedy policy (show position of UAV)
    % Value function is energy from wind field
    % Demonstrate how to plot simulation
    % Demonstrate how plane can move and make decisions autonomously
    nSteps = 100;
    startPos = [0.5 -1.5];
    stepSize = 0.1;

    % Describe how value function is discretized
    % sideLength must be even (how far away airplane can see in mesh units / 2)
    % meF refers to mesh fineness for value function (size of box in grid)
    % sideLength is the number of boxes to a side in the mesh created
    meFVFun = 0.02; sideLength = 16; % Ex
    gridParams = [meFVFun, sideLength];
    travelUpEnergy(nSteps, stepSize, windField,startPos, gridParams);
    
    title('Path of UAV in Windfield');
    
    %% Create training data for neural network
    % Given (x,y,z,windValue) tells best direction to go
    % Generate this by using the gradient based method in travelUpEnergy
    % trainData
    
    % Bounds and fineness of training data grid
    % Currently used for both classification and regression code
    xBoundsTrain = [-2 2.5];
    yBoundsTrain = [-2 2.5];
    trainDataFineness = 0.3*[1 1];
    trainGrid = [xBoundsTrain;yBoundsTrain;trainDataFineness];  
        
    %% Creation of classification training data
   % Distance can see in windfield when deciding optimal direction 
    % Used for creation of classification data
    arrSizeTrain  = 0.2; 
    
    % Whether or not the training data (arrows) is displayed
    % This is the classification training data
    printToGraph = 0;
    
    % Number of distinct compass directions
    % This will be the number of outputs in the neural net 
    nDirections = 8; 
    
    % Inputs: input features to neural net (x,y)
    % Targets: desired output (direction to go)
    % This is the format PyBrain likes
    [inputVals, targets] = createTrainData(gridParams,windField,trainGrid,arrSizeTrain,printToGraph,nDirections);
    
    % Write data to txt file
    fileToStore = 'classData.txt';
    dlmwrite(fileToStore,[inputVals targets]);     
    
    %% Creation of value estimation training data (regression)
    % Find the value function for going right in each case
    stepRightSize = 0.1;
    plotValue = 1; % Plot the resulting value surface 
    % Inputs: input features to neural net (x,y)
    % Targets: desired output (height of value surface)
    [inputValsValueEst, targetsValueEst] = valueEst(windField,trainGrid,stepRightSize,plotValue);
   
    % Write data to txt file
    fileForRegression = 'regrData.txt';
    vertScale = 100;
    dlmwrite(fileForRegression,[inputValsValueEst,vertScale*targetsValueEst]);
    type(fileForRegression);
end



end

