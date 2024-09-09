clear all
clc;

% Define rectangles
rect1 = [3, 4, -4, -4, 4, 4, 0, 0.5, 0.5, 0];
rect2 = [3, 4, -4, -4, 4, 4, 0.5, 1, 1, 0.5];
rect3 = [3, 4, -4, -4, 4, 4, 1, 1.5, 1.5, 1];
rect4 = [3, 4, -4, -4, 4, 4, 1.5, 2, 2, 1.5];
rect5 = [3, 4, -4, -4, 4, 4, 2, 2.5, 2.5, 2];

% Combine rectangles into one matrix
gd = [rect1', rect2', rect3', rect4', rect5'];

% Set names for each rectangle
ns = {'rect1', 'rect2', 'rect3', 'rect4', 'rect5'};

% Set the formula to combine the rectangles
sf = 'rect1 + rect2 + rect3 + rect4 + rect5';

% Create the geometry object from the rectangles
[dl, bt] = decsg(gd, sf, ns);

% Create the PDE model
model = createpde;
geometryFromEdges(model, dl);

% Plot the geometry
figure
pdegplot(model, 'EdgeLabels', 'on', 'FaceLabels', 'on');
axis equal

% removes face boundaries
[dl2,bt2] = csgdel(dl,bt); % removes face boundaries
figure (2)
pdegplot(dl2,'EdgeLabels','on','FaceLabels','on')
xlim([-5,5])
axis equal

% Gemometry buiding above was  DONE!!
thermalmodelS = createpde('thermal')%,'steadystate');
geometryFromEdges(thermalmodelS,dl);
figure (3)
pdegplot(thermalmodelS,'EdgeLabels','on'); 
%axis([-6 6]);
axis equal
title 'Block Geometry With Edge Labels Displayed'
%thermalBC(thermalmodelS,'Edge',3,'Temperature',100);
T1= 10 % Temperature of LED die
T2= 25 % Temperature of invironment
T3= 60 % temperature deviation compare to room/ambient temperature at normal operation
T4= 100 % temperature deviation compare to room/ambient temperature at abnormal operation
T5=120
%  First layer
thermalBC(thermalmodelS,'Edge',1,'Temperature',T1);
thermalBC(thermalmodelS,'Edge',3,'Temperature',T1);
thermalBC(thermalmodelS,'Edge',11,'Temperature',T1);
thermalBC(thermalmodelS,'Edge',6,'Temperature',T1);
%  Second layer
thermalBC(thermalmodelS,'Edge',7,'Temperature',T2);
thermalBC(thermalmodelS,'Edge',4,'Temperature',T2);
thermalBC(thermalmodelS,'Edge',12,'Temperature',T2);

%  thirt layer
thermalBC(thermalmodelS,'Edge',8,'Temperature',T3);
thermalBC(thermalmodelS,'Edge',5,'Temperature',T3);
thermalBC(thermalmodelS,'Edge',13,'Temperature',T3);
%  Four layer
thermalBC(thermalmodelS,'Edge',9,'Temperature',T4);
thermalBC(thermalmodelS,'Edge',16,'Temperature',T4);
thermalBC(thermalmodelS,'Edge',14,'Temperature',T4);
%  Five layer
thermalBC(thermalmodelS,'Edge',2,'Temperature',T5);
thermalBC(thermalmodelS,'Edge',10,'Temperature',T5);
thermalBC(thermalmodelS,'Edge',15,'Temperature',T5);

% Thermal property for material
M1=0.2 % thermal conductivity of material of first layer
M2=400 % thermal conductivity of material of second layer
M3=130 %  thermal conductivity of material of thirt layer
M4=100  %  thermal conductivity of material of four layer
M5=500 %  thermal conductivity of material of five layer
thermalProperties(thermalmodelS,'Face',1, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',2, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',3, 'ThermalConductivity',M3);
thermalProperties(thermalmodelS,'Face',4, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',5, 'ThermalConductivity',M2);
%
generateMesh(thermalmodelS,'Hmax',0.2);
figure (4)
pdeplot(thermalmodelS); 
axis equal
title 'Block With Finite Element Mesh Displayed'

R = solve(thermalmodelS);
T = R.Temperature;

figure (5)
pdeplot(thermalmodelS,'XYData',T,'Contour','on','ColorMap','hot'); 
axis( [-1 3 -1 3])
axis equal
title 'Temperature, Steady State Solution'
%%%%%%%%%%%%%%%%%%%%%%
% Temperature interpolation
v = linspace(0,5,500); % hai chi so dau la toa do x va y trong cau truc LED
[X,Y] = meshgrid(v);

Tintrp = interpolateTemperature(R,X,Y);
Tintrp = reshape(Tintrp,size(X));

figure (6)
contourf(X,Y,Tintrp)
colormap(hot)
colorbar

%querypoints = [X(1:2),Y(2:3)]';
%Tintrp = interpolateTemperature(R,querypoints);