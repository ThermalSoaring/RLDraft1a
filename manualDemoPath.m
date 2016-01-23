function [ output_args ] = manualDemoPath( )
%manualDemoPath Shows how we can set a path and draw it.
%   Detailed explanation goes here

% Here are the points on the path, in the order visited
pathPoints = [
  %x    %y
  0     0
  -0.2  0.2
  0.5   1
  1     1
  1     0.5
  0.5   0.7
];

% Plots the lines
xPath = pathPoints(:,1);
yPath = pathPoints(:,2);
plot(xPath, yPath,'k','LineWidth',4);

end

