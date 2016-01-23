function [ ] = RLDraft1( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clearvars
close all

% Provides wind energy as a function of (x,y)
windField = createWindField();

% Plots 2D contour plot
% Second argument sets 3D if high. Last is mesh fineness for plotting.
plotWindfield(windField,0,0.05);

hold on

% Demonstrate how to set path points
% manualDemoPath();

% Demonstrate how to plot simulation
% Demonstrate how plane can move and make decisions autonomously
 nSteps = 100;
 startPos = [1 0];
 travelUpEnergy(nSteps, windField,startPos);

hold off
end

