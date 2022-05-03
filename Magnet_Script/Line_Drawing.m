% Function Description: This function draws the line once starting and ending coordinates are provided.
% 1 - Starting point (xs,ys);
% 2 - Ending Point (xe,ye).

function Line_Drawing(View,xs,ys,xe,ye)
invoke(View,'NewLine',xs,ys,xe,ye);