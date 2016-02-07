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
    meFVFun = 0.05; sideLength = 8; % Ex
    gridParams = [meFVFun, sideLength];
    travelUpEnergy(nSteps, stepSize, windField,startPos, gridParams);
    
    title('Path of UAV in Windfield');
    
    %% Create training data for neural network
    % Given (x,y,z,windValue) tells best direction to go
    % Generate this by using the gradient based method in travelUpEnergy
    % trainData
    
    % Bounds and fineness of training data grid
    xBoundsTrain = [-1.5 2];
    yBoundsTrain = [-1.5 2];
    trainDataFineness = 0.5*[1 1];
    trainGrid = [xBoundsTrain;yBoundsTrain;trainDataFineness];  
    
    % Distance can see in windfield when deciding optimal direction
    arrSizeTrain  = 0.2; 
    
    % Whether or not the training data is displayed
    printToGraph = 1;
    
    % Number of distinct compass directions
    % This will be the number of outputs in the neural net
    nDirections = 8; 
    
    createTrainData(gridParams,windField,trainGrid,arrSizeTrain,printToGraph,nDirections);
    
    %% Neural net:
    % Inputs: (x,y,z,windValue)
    % Outputs: value of going in 8 compass directions 
    
end



end

