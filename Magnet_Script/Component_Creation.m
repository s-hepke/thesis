% Function Description: This function create a component given:  
% 1 - Coordinate of the point inside the surface of the component(xt,yt);
% 2 - Component axial lenght (L); 
% 3 - Component name (NameComponent); 
% 4 - Component material (NameMaterial);

function Component_Creation(MN,xt,yt,L,NameComponent,NameMaterial)

Doc = invoke(MN, 'getDocument');
View = invoke(Doc, 'getCurrentView');
Consts = invoke(MN, 'getConstants');

% Component surface selection

invoke(View,'selectAt',xt,yt,get(Consts,'infoSetSelection'),get(Consts,'infoSliceSurface'));

% Component name creation
invoke(MN, 'processCommand', 'ReDim ComponentName(0)');

% Naming the component
invoke(MN, 'processCommand',['ComponentName(0) = "' num2str(NameComponent) ,'"']);

% Component creation

invoke(MN, 'processCommand',['CALL getDocument().getView().makeComponentInALine(' num2str(L) ',ComponentName,"Name=' num2str(NameMaterial) ,'")']);

    