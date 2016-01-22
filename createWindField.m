function [ windField] = createWindField( )
%UNTITLED2 Create a 2D wind energy distribution
%   Returns wind energy as a function of (x,y)

% Calling sequence: % norm2D(mu, R, W)

% Create individual thermals
nd1 = norm2D([0 0], 1, 1);
nd2 = norm2D([1 1], 0.5, 1);
nd3 = norm2D([-0.5 1], 0.2, 0.5);

% Sum the thermals
windField = @(x,y) nd1(x,y) + nd2(x,y)+ nd3(x,y);

end

