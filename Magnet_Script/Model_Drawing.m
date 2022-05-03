%% Draw Model

%% Winding
k = 2;
l = 2;
primA = primT*primC;
primH = windowH - k*coreI;
primW = primA/primH;
secA = secT*secC;
% secH = primH - l*coreI;
secH = primH - l*prim2secI;
secW = secA/secH;
% Primary Drawing
Line_Drawing(View,coreW/2+coreI,coreW+(k/2)*coreI,coreW/2+coreI+primW,coreW+(k/2)*coreI);
Line_Drawing(View,coreW/2+coreI+primW,coreW+(k/2)*coreI,coreW/2+coreI+primW,coreW+(k/2)*coreI+primH);
Line_Drawing(View,coreW/2+coreI+primW,coreW+(k/2)*coreI+primH,coreW/2+coreI,coreW+(k/2)*coreI+primH);
Line_Drawing(View,coreW/2+coreI,coreW+(k/2)*coreI+primH,coreW/2+coreI,coreW+(k/2)*coreI);
% Secondary Drawing
% Line_Drawing(View,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*coreI,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*coreI);
% Line_Drawing(View,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*coreI,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*coreI+secH);
% Line_Drawing(View,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*coreI+secH,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*coreI+secH);
% Line_Drawing(View,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*coreI+secH,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*coreI);
Line_Drawing(View,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*prim2secI,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*prim2secI);
Line_Drawing(View,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*prim2secI,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*prim2secI+secH);
Line_Drawing(View,coreW/2+coreI+primW+prim2secI+secW,coreW+(k/2)*coreI+(l/2)*prim2secI+secH,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*prim2secI+secH);
Line_Drawing(View,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*prim2secI+secH,coreW/2+coreI+primW+prim2secI,coreW+(k/2)*coreI+(l/2)*prim2secI);
% Creating Return Path
invoke(View,'selectAll',get(Consts,'infoSetSelection'));
% Mirroring the drawing along the slot axes
invoke(View,'mirrorSelectedEdges',0,0,0,1,'True');
% Creating Other Phases
invoke(View,'selectAll',get(Consts,'infoSetSelection'));
invoke(View,'shiftSelectedEdges',windowW+coreW,0,'True');
invoke(View,'shiftSelectedEdges',-(windowW+coreW),0,'True');

%% Window Right
Line_Drawing(View,coreW/2,coreW,windowW+coreW/2,coreW);
Line_Drawing(View,windowW+coreW/2,coreW,windowW+coreW/2,windowH+coreW);
Line_Drawing(View,windowW+coreW/2,windowH+coreW,coreW/2,windowH+coreW);
Line_Drawing(View,coreW/2,windowH+coreW,coreW/2,coreW);
%% Window Left
Line_Drawing(View,-coreW/2,coreW,-(windowW+coreW/2),coreW);
Line_Drawing(View,-(windowW+coreW/2),coreW,-(windowW+coreW/2),windowH+coreW);
Line_Drawing(View,-(windowW+coreW/2),windowH+coreW,-coreW/2,windowH+coreW);
Line_Drawing(View,-coreW/2,windowH+coreW,-coreW/2,coreW);
%% Core
Line_Drawing(View,3*coreW/2+windowW,0,3*coreW/2+windowW,windowH+2*coreW);
Line_Drawing(View,3*coreW/2+windowW,windowH+2*coreW,-(3*coreW/2+windowW),windowH+2*coreW);
Line_Drawing(View,-(3*coreW/2+windowW),windowH+2*coreW,-(3*coreW/2+windowW),0);
Line_Drawing(View,-(3*coreW/2+windowW),0,3*coreW/2+windowW,0);
%% Airbox
% Line_Drawing(View,(1+airbox/100)*(3*coreW/2+windowW),-(1+airbox/100)*0,(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW));
% Line_Drawing(View,(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW),-(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW));
% Line_Drawing(View,-(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW),-(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*0);
% Line_Drawing(View,-(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*0,(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*0);
% Line_Drawing(View,(1+airbox/100)*(3*coreW/2+windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)),(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW));
% Line_Drawing(View,(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW),-(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW));
% Line_Drawing(View,-(1+airbox/100)*(3*coreW/2+windowW),(1+airbox/100)*(windowH+2*coreW),-(1+airbox/100)*(3*coreW/2+windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)));
% Line_Drawing(View,-(1+airbox/100)*(3*coreW/2+windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)),(1+airbox/100)*(3*coreW/2+windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)));
Line_Drawing(View,(1+airbox/100)*(2*windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)),(1+airbox/100)*(2*windowW),(1+airbox/100)*(windowH+2*coreW));
Line_Drawing(View,(1+airbox/100)*(2*windowW),(1+airbox/100)*(windowH+2*coreW),-(1+airbox/100)*(2*windowW),(1+airbox/100)*(windowH+2*coreW));
Line_Drawing(View,-(1+airbox/100)*(2*windowW),(1+airbox/100)*(windowH+2*coreW),-(1+airbox/100)*(2*windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)));
Line_Drawing(View,-(1+airbox/100)*(2*windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)),(1+airbox/100)*(2*windowW),((windowH+2*coreW)-(1+airbox/100)*(windowH+2*coreW)));

%% Create Components

%% Winding
% Phase A
NomeComp = 'primA1';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,1.001*(coreW/2+coreI),1.001*(coreW+coreI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'primA2';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,-1.001*(coreW/2+coreI),1.001*(coreW+coreI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'secA1';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,1.001*(coreW/2+coreI+primW+prim2secI),1.001*(coreW+l*prim2secI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'secA2';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,-1.001*(coreW/2+coreI+primW+prim2secI),1.001*(coreW+l*prim2secI),stackL,NomeComp,NomeMaterFerr);
% Phase B
NomeComp = 'primB1';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,1.001*(3*coreW/2+coreI+windowW),1.001*(coreW+coreI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'primB2';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,(coreW/2+windowW)-1.001*coreI,1.001*(coreW+coreI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'secB1';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,1.001*(3*coreW/2+coreI+windowW+primW+prim2secI),1.001*(coreW+l*prim2secI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'secB2';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,(coreW/2+windowW)-1.001*(coreI+primW+prim2secI),1.001*(coreW+l*prim2secI),stackL,NomeComp,NomeMaterFerr);
% Phase C
NomeComp = 'primC1';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,-((coreW/2+windowW)-1.001*coreI),1.001*(coreW+coreI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'primC2';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,-(1.001*(3*coreW/2+coreI+windowW)),1.001*(coreW+coreI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'secC1';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,-((coreW/2+windowW)-1.001*(coreI+primW+prim2secI)),1.001*(coreW+l*prim2secI),stackL,NomeComp,NomeMaterFerr);
NomeComp = 'secC2';
NomeMaterFerr = geoMat.NameWinding;
Component_Creation(MN6,-(1.001*(3*coreW/2+coreI+windowW+primW+prim2secI)),1.001*(coreW+l*prim2secI),stackL,NomeComp,NomeMaterFerr);
%% Wiondow
NomeComp = 'Window_1';
NomeMaterFerr = geoMat.NameWindow;
Component_Creation(MN6,1.001*coreW/2,1.001*coreW,stackL,NomeComp,NomeMaterFerr);
NomeComp = 'Window_2';
NomeMaterFerr = geoMat.NameWindow;
Component_Creation(MN6,-1.001*coreW/2,1.001*coreW,stackL,NomeComp,NomeMaterFerr);
%% Core
NomeComp = 'Core';
NomeMaterFerr = geoMat.NameCore;
Component_Creation(MN6,0,0.001*coreW,stackL,NomeComp,NomeMaterFerr);
%% Airbox
NomeComp = 'Airbox';
NomeMaterFerr = geoMat.NameAirbox;
Component_Creation(MN6,0,-0.001*coreW,stackL,NomeComp,NomeMaterFerr);