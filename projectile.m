function position = projectile(xo, yo, vo, thetao, r, m, to)

% We can define some constants for the projectile motion of the problem

rho = 1.2; % kg/m^3
Cd = 0.47; % for a sphere
A = 0.5*pi*r^2 % area of the sphere in contact with drag force
g = 9.81; % m/s

% Now we define our initial velocity in the x and y directions
vxo = vo*cos(thetao);
vyo = vo*sin(thetao);

% We also define the initial positions and the time that the ball begins
% its phase of projectile motion
x(1,1) = xo;
y(1,1) = yo;
vx(1) = vxo;
vy(1) = vyo;
tadd(1,1) = to;

tstep = 0.001;
t = 1;

% We use a while loop to execute our calculations of the acceleration,
% velocity, and position in the x and y directions
while(y(t) >= 0)
    
    % Acceleration due to gravity and
    ax(t) = (-1/(2*m))*rho*A*Cd*vx(t)^2;
    ay(t) = (-1/(2*m))*rho*A*Cd*vy(t)^2 - g;

    vx(t + 1) = vx(t) + ax(t)*tstep;
    vy(t + 1) = vy(t) + ay(t)*tstep;

    x(t + 1,1) = x(t) + vx(t)*tstep;
    y(t + 1,1) = y(t) + vy(t)*tstep;
    
    tadd(t + 1,1) = tadd(t) + tstep;
    
    t = t + 1;
end

position = [x, y, tadd];
end