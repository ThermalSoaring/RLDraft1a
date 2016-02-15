function [ Vnear ] = getLocalValue( V, meF, gridSideSize, currPos)
%getLocalValue Returns a mesh of values for nearby points, given a
%continuous formula for value
% V is value function
% meF is desired fineness in returned mesh
% gridSideSize is the size of the square subset of V that is discretized
% currPos is current position of UAV
    
% Set mesh boundaries
%x 
meLX = currPos(1)-gridSideSize/2; % mesh lower bound
meUX = currPos(1)+gridSideSize/2; % mesh upper bound

%y
meLY = currPos(2)-gridSideSize/2; % mesh lower bound
meUY = currPos(2)+gridSideSize/2; % mesh upper bound

% Create mesh (x and y values)
[X , Y] = meshgrid(meLX:meF:meUX, meUY:-meF:meLY);

% Return local values
Vnear =  V(X,Y);
end

