function plotWindfield( windField, threeD, meF )
%plotWindfield Creates a 2D contour plot of the input windField

%% Plotting parameters
%meF = 0.005; % mesh fineness
meL = -2; % mesh lower bound
meU = 2.5; % mesh upper bound

%% Creating plot
[X , Y] = meshgrid(meL:meF:meU, meL:meF:meU);
z = windField(X,Y);
if (threeD == 0)
    contourf(X,Y,z)
else
    surf(X,Y,z)
end

% Title and axes labels
title('Windfield')
xlabel('x')
ylabel('y')

end

