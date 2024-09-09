clc;
thermalmodel = createpde('thermal','transient');
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
    1.2 
    1.5
    1.5
    1.2]
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
%gd = [rect2,C]
% Setname for each part
ns = char('rect1','rect2','C','rect3');
%ns = char('rect2','C');
%ns = ns';
%Set formular
sf='rect1+(C-rect3 + rect2)';
%sf='(C + rect2)';
%
ns = ns';
dl = decsg(gd,sf,ns);
geometryFromEdges(thermalmodel,dl);
figure (1)
pdegplot(thermalmodel,'EdgeLabels','on','FaceLabels','on')
xlim([-5 5])
ylim([-5 5])
axis equal
% Gemometry buiding above was  DONE!!
%%%
%thermalmodelS = createpde('thermal')%,'steadystate');
%geometryFromEdges(thermalmodel,dl);

%pdegplot(thermalmodel,'EdgeLabels','on'); 
%axis([-6 6]);
axis equal
title 'Block Geometry With Edge Labels Displayed'


% For the silicone lens region, assign these thermal properties:

thermalProperties(thermalmodel,'ThermalConductivity',0.18, ...
                               'MassDensity',1100, ...
                               'SpecificHeat',1175, ...
                               'Face',5);
%ForLED chip
thermalProperties(thermalmodel,'ThermalConductivity',130, ...
                               'MassDensity',6150, ...
                               'SpecificHeat',490, ...
                               'Face',2);
%For the AlN
thermalProperties(thermalmodel,'ThermalConductivity',400, ...
                               'MassDensity',8700, ...
                               'SpecificHeat',385, ...
                               'Face',3);
 %Face4
thermalProperties(thermalmodel,'ThermalConductivity',400, ...
                               'MassDensity',8700, ...
                               'SpecificHeat',385, ...
                               'Face',4);
%Face5
thermalProperties(thermalmodel,'ThermalConductivity',400, ...
                               'MassDensity',8700, ...
                               'SpecificHeat',385, ...
                               'Face',1);
%Face6
thermalProperties(thermalmodel,'ThermalConductivity',400, ...
                               'MassDensity',8700, ...
                               'SpecificHeat',385, ...
                               'Face',6);
%Face7
thermalProperties(thermalmodel,'ThermalConductivity',400, ...
                               'MassDensity',8700, ...
                               'SpecificHeat',385, ...
                               'Face',7);
                                                                                                             
                                            
%Assume that the LED region is a heat source with a density of 4?W/m2
internalHeatSource(thermalmodel,7000,'Face',2);
%Apply a constant temperature of 0 ? C to the sides of the square plate.
thermalBC(thermalmodel,'Temperature',0,'Edge',[1 2 7 8]);
%Set the initial temperature to 0 °C.
thermalIC(thermalmodel,125);
%Generate the mesh.
generateMesh(thermalmodel);
% The dynamics for this problem are very fast. 
%The temperature reaches a steady state in about 0.1 seconds.
%To capture the interesting part of the dynamics, set the solution time to logspace(-2,-1,10). 
%This command returns 10 logarithmically spaced solution times between 0.01 and 0.1.
tlist = logspace(-2,-1,10);
%Solve the equation.
thermalresults = solve(thermalmodel,tlist)
%Plot the solution with isothermal lines by using a contour plot.
T = thermalresults.Temperature;
figure (2)
pdeplot(thermalmodel,'XYData',T(:,10),'Contour','on','ColorMap','hot')



%querypoints = [X(1:2),Y(2:3)]';
%Tintrp = interpolateTemperature(R,querypoints);


% Temperature interpolation
generateMesh(thermalmodel);
tlist = 0:1000:2000000;
thermalresults = solve(thermalmodel,tlist)
X = -5:0.1:5;
Y = ones(size(X));

Tintrp = interpolateTemperature(thermalresults,X,Y,1:length(tlist));
figure(5)
t = [51:50:201];
for i = t
  p(i) = plot(X,Tintrp(:,i),'DisplayName', strcat('t=', num2str(tlist(i))));
  hold on
end
legend(p(t))
xlabel('x')
ylabel('Tintrp')



%Compute the transient solution for solution times from t = 0 to t = 50000 seconds.

tfinal = 500000;
tlist = 0:100:tfinal;
result = solve(thermalmodel,tlist)
%Plot the temperature distribution at t = 50000 seconds.

T = result.Temperature;

figure (4)
pdeplot(thermalmodel,'XYData',T(:,end),'Contour','on')
axis equal
title(sprintf('Transient Temperature at Final Time (%g seconds)',tfinal))
colormap(jet)
colorbar