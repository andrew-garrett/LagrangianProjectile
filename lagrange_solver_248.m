% Now we write some basic code to solve the Lagrangian we have developed
clear all;
clc;
% We can define some of the constants to simplify the ODEs
g = 9.81; % m/s^2
M = 0.78; % kg
m = 0.147; % kg
d = 0.025; % m
l = 0.45; % m
k = 2000; % N/m
Fo = 90; % N
xo = 0.35; % m
r = 0.036; % m

% Now we produce the lagrangian ODEs and substitute our constants
lagrangian(:,1) = lagrange_248;
lagrangian = subs(lagrangian);

% Next we create our system of equations

eqn2 = lagrangian(2) == 0;
eqn2o = isolate(eqn2, 'diff(q1dotf(t), t)');
eqn4 = lagrangian(4) == 0;
eqn4o = isolate(eqn4, 'diff(q2dotf(t), t)');

eqn1 = lagrangian(1);
eqn3 = lagrangian(3);

eqns = [eqn1;
        eqn2;
        eqn3;
        eqn4];

% Now we are able to convert the system of equations to a vector field, and
% in turn a matlab function that we can solve numerically using ODE45
[V1] = odeToVectorField(eqns);
Mat = matlabFunction(V1, 'vars', {'t','Y'});

tspan = 0 : 0.001 : 3;
y0 = [0, -0.1047, 0.2162, 0];
[t, y] = ode45(Mat, tspan, y0);

% Now we calculate when the ball leaves the arm
tsplit = 1000*t(find(y(:,3) >= 0.38, 1, 'first'))

% We now know the initial position of the ball, its angle of launch, and
% the velocity of its launch, which we will use to calculate the path of
% the ball while in the air
xi = (39-(100*y(tsplit,3))*cos(y(tsplit,2))+3.5)/100;
yi = (44 + (100*y(tsplit,3))*sin(y(tsplit,2))+3.5)/100;
proj = projectile(xi, yi, y(tsplit,4)+y(tsplit,1)*y(tsplit,3)/100, y(tsplit,2), r, m, t(tsplit));

% Here, we use a similar visualization tool to what Daphnie Friedman used
% to generate the dynamics simulation of the system
figure(1);
hold on
xlim([0 1250]);
ylim([0 1250]);
line([0,39+7],[1,1],'Color','Blue','LineWidth',1);
line([11,39+7],[1,1],'Color','Blue','LineWidth',2);
line([39,39],[0,44],'Color','Blue','LineWidth',2);
for i = 1:length(t)+tsplit-1
    
    if i<=tsplit
        h1 = line([25,39+13*cos(y(i,2))],[0,44-13*sin(y(i,2))],'Color',[0.5 0.5 0.5],'LineWidth',7/5);
        h2 = line([39-32*cos(y(i,2)),39+13*cos(y(i,2))],[44+32*sin(y(i,2)),44-13*sin(y(i,2))],'Color','Blue','LineWidth',7/5);
        b = plot(39-(100*y(i,3))*cos(y(i,2))+3.5, 44 + (100*y(i,3))*sin(y(i,2))+3.5,'.','MarkerSize',20,'Color','Red');
        tracker = plot(39-(100*y(i,3))*cos(y(i,2))+3.5, 44 + (100*y(i,3))*sin(y(i,2))+3.5,'.','MarkerSize',5,'Color','Black');
    elseif i<length(t)-(tsplit-1)
        h1 = line([25,39+14*cos(y(i,2))],[0,44-13*sin(y(i,2))],'Color',[0.5 0.5 0.5],'LineWidth',7/5);
        h2 = line([39-32*cos(y(i,2)),39+13*cos(y(i,2))],[44+32*sin(y(i,2)),44-13*sin(y(i,2))],'Color','Blue','LineWidth',7/5);
        b = plot(100*proj(i-(tsplit-1),1),100*proj(i-(tsplit-1),2),'.','MarkerSize',20,'Color','Red');
        tracker = plot(100*proj(i-(tsplit-1),1),100*proj(i-(tsplit-1),2),'.','MarkerSize',5,'Color','Black');
    else
        b = plot(100*proj(i-(tsplit-1),1),100*proj(i-(tsplit-1),2),'.','MarkerSize',20,'Color','Red');
        tracker = plot(100*proj(i-(tsplit-1),1),100*proj(i-(tsplit-1),2),'.','MarkerSize',5,'Color','Black');
    end
    pause(0.0001);
    delete(h1);
    delete(h2);
    delete(b);
end
