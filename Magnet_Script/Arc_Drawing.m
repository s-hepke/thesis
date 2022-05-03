% Function Description: This function draws an arc once 3 point coordinate are given:  
% 1 - Center of the arc (xc,yc);
% 2 - Starting point (xs,ys); 
% 3 - Ending point (xe,ye). 

function Arc_Drawing(View,xc,yc,xs,ys,xe,ye)
invoke(View,'NewArc',xc,yc,xs,ys,xe,ye);