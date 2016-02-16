function [ windField] = createWindField( )
%UNTITLED2 Create a 2D wind energy distribution
%   Returns wind energy as a function of (x,y)

% Calling sequence: % norm2D(mu, R, W)

% Create individual thermals
nd1 = norm2D([-0.2 -.3], 0.8, 0.1);
nd2 = norm2D([1.6 0.8], 0.8, 0.1);
nd3 = norm2D([-0.5 0.8], 0.3, 0.1);

% Sum the thermals
windField = @(x,y) nd1(x,y) + nd2(x,y) ;

end

