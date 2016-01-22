function [ ] = RLDraft1( )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
clear all
close all

% Provides wind energy as a function of (x,y)
windField = createWindField();

% Plots 2D contour plot
% Second argument sets 3D if high. Last is mesh fineness for plotting.
plotWindfield(windField,0,0.005)


end

