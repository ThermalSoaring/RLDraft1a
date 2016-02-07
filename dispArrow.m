function [ ] = dispArrow(startPoint,endPoint)
% Draws on arrow the current plot from the startPoint to the endPoint

    % A reference on this arrow drawing code:
    % http://stackoverflow.com/questions/25729784/how-to-draw-an-arrow-in-matlab
    x = [startPoint(1) endPoint(1)]; y = [startPoint(2) endPoint(2)];
    [xf, yf]=ds2nfu(x,y);
    annotation(gcf,'arrow', xf,yf)

end

