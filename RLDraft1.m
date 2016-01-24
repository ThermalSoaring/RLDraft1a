function [ ] = RLDraft1( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clearvars
close all

% Provides wind energy as a function of (x,y)
windField = createWindField();

% Plots 2D contour plot of wind energy
% Second argument sets 3D if high. Last is mesh fineness for plotting.
meFPlot = 0.05; 
is3D = 0;
plotWindfield(windField,is3D,meFPlot);

% Plot path of UAV
if (is3D == 0)
    hold on

    % Demonstrate greedy policy
    % Value function is energy from wind field
    % Demonstrate how to plot simulation
    % Demonstrate how plane can move and make decisions autonomously
    nSteps = 100;
    startPos = [0 1];
    stepSize = 0.1;

    % Describe how value function is discretized
    % sideLength must be even (how far away airplane can see in mesh units / 2)
    meFVFun = 0.05; sideLength = 8; % Ex
    travelUpEnergy(nSteps, stepSize, windField,startPos, meFVFun, sideLength);
    
    title('Path of UAV in Windfield');
    hold off
end

end

