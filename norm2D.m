function [norm2D] = norm2D(mu, R, W)
%norm2D Returns a 2D Gaussian distribution (for modelling a thermal) 
% mu is the center of the thermal [xcenter, ycenter]
% R is the characteristic thermal radius
% W is the characteristic thermal strength

% Following Edwards p. 18
% This thermal is of Gaussian shape
% The covariance matrix is a multiple of the identity
% A next step would be generalize this shape to any 2D Gaussian
% distribution

% Distance from center of thermal
D = @(x,y) sqrt((x-mu(1)).^2 + (y - mu(2)).^2);  

% Gaussian distribution
norm2D = @(x,y) W* exp(-(D(x,y)/R).^2);

end

