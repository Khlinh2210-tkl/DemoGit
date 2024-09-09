clc;

% polygon 1 AlN substrate
rect1=[3
    4
    -4 
    -4
    4 
    4
    0 
    1
    1
    0]
% polygon 2 LED chip
rect2=[3
    4
    -0.5 
    -0.5
    0.5 
    0.5
    1 
    1.5
    1.5
    1]
% lens r=3 mm
C=[1
    0
    1
    3]
rect3=[3
    4
    -3 
    -3
    3 
    3
    -2
    1
    1
    -2]
 


% Append extra zeros to the circles
% so they have the same number of rows as the rectangle
C = [C;zeros(length(rect1) - length(C),1)];
% Combine 3 part into one matrix
gd = [rect1,rect2,C,rect3]
% Setname for each part
ns = char('rect1','rect2','C','rect3');
ns = ns';
%Set formular
sf='rect1+(C-rect3 + rect2)';
%
[dl,bt] = decsg(gd,sf,ns)
%
dl = decsg(gd,sf,ns);

pdem = createpde;
geometryFromEdges(pdem,dl);

figure(1);
pdegplot(pdem,'EdgeLabels','on','FaceLabels','on');

% removes face boundaries
[dl2,bt2] = csgdel(dl,bt); % removes face boundaries
%figure (2);
pdegplot(dl2,'EdgeLabels','on','FaceLabels','on')
xlim([-5,5])
axis equal
% Gemometry buiding above was  DONE!!

thermalmodelS = createpde('thermal')%,'steadystate');
geometryFromEdges(thermalmodelS,dl);
%figure (3);
pdegplot(thermalmodelS,'EdgeLabels','on'); 
%axis([-6 6]);
axis equal
title 'Block Geometry With Edge Labels Displayed'

%thermalBC(thermalmodelS,'Edge',3,'Temperature',100);
T1= 130 % Temperature of LED die
T2= 25 % Temperature of invironment
T3=10 % temperature deviation compare to room/ambient temperature at normal operation
T4= 0 % temperature deviation compare to room/ambient temperature at abnormal operation

% LED region Temp
thermalBC(thermalmodelS,'Edge',3,'Temperature',T1);
thermalBC(thermalmodelS,'Edge',4,'Temperature',T1);
thermalBC(thermalmodelS,'Edge',5,'Temperature',T1);
thermalBC(thermalmodelS,'Edge',8,'Temperature',T1);
%Lens Region Temp
thermalBC(thermalmodelS,'Edge',20,'Temperature',T2+T3+T4);
thermalBC(thermalmodelS,'Edge',21,'Temperature',T2+T3+T4);
thermalBC(thermalmodelS,'Edge',7,'Temperature',T2+T3);
thermalBC(thermalmodelS,'Edge',9,'Temperature',T2+T3);
thermalBC(thermalmodelS,'Edge',6,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',10,'Temperature',T1-20);

%AlN submount
thermalBC(thermalmodelS,'Edge',1,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',2,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',11,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',12,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',13,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',14,'Temperature',T1-20);
thermalBC(thermalmodelS,'Edge',15,'Temperature',T1-20)

% Thermal property for material
M1=4.0% thermal conductivity of lens or silicone mixed phosphor lens
M2=400 % thermal conductivity of AlN submount
M3=130 % W/(m.K)thermal conductivity of LED chip
thermalProperties(thermalmodelS,'Face',1, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',2, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',3, 'ThermalConductivity',M3);
thermalProperties(thermalmodelS,'Face',4, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',5, 'ThermalConductivity',M2);
thermalProperties(thermalmodelS,'Face',6, 'ThermalConductivity',M1);
thermalProperties(thermalmodelS,'Face',7, 'ThermalConductivity',M1);

%thermalProperties(thermalmodelS,'ThermalConductivity',0.2,...
         %                      'MassDensity',1000000,...
         %                      'SpecificHeat',1050,...
          %                     'Face',7);
                       
%thermalProperties(thermalmodelS,'ThermalConductivity',130,...
                     %          'MassDensity',615000000,...
                      %         'SpecificHeat',490,...
                       %        'Face',3);
                         
%thermalProperties(thermalmodelS,'ThermalConductivity',60,...
       %                        'MassDensity',3260,...
        %                       'SpecificHeat',780,...
         %                      'Face',4);

%
generateMesh(thermalmodelS,'Hmax',0.05);
figure (4)
pdeplot(thermalmodelS); 
axis equal
title 'Block With Finite Element Mesh Displayed'

R = solve(thermalmodelS);
T = R.Temperature;

figure (5)
pdeplot(thermalmodelS,'XYData',T,'Contour','on','ColorMap','hot'); 
caxis([20 200])
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
