% We will use the sample code that Bruce provided to us, however optimizing
% it for our system
function dLdt = lagrange_248
%% First we will develop our expression for the Lagrangian

% First we define the basic symbolic variables to be used in our Lagrangian

syms t q1 q1dot q2 q2dot m M l r k d g Fo xo

% We can develop an expression for the rotational kinetic energy
Iarm = (1/12)*M*(l^2) + M*(d^2);
Iball = m*(q2^2 + r^2);
kRot = 0.5*(Iarm + Iball)*q1dot^2 + 0.4*(m*r^2)*(q2dot/r)^2;

% We can develop an expression for the linear kinetic energy of the ball
kLin = 0.5*m*((q1dot*q2)^2 + q2dot^2);

% We can develop an expression for the GPE of the arm and the ball
uG = M*g*(0.44 + d*sin(q1)) + m*g*(0.44 + q2*sind(q1));

% We can develop an expression for the Spring Potential Energy
x = sqrt((0.2 + 0.13*cos(q1))^2 + (0.44 - 0.13*sin(q1))^2);
uS = Fo*(x - xo) + 0.5*k*(x - xo)^2;

% Now we construct our Lagrangian
L = kRot + kLin - uG - uS;



%% First we handle the Lagrangian condition for q1

% take partials of L with L in terms of q1 and q1dot
dL_dq1dot = [diff(L,q1dot)];
dL_dq1 = [diff(L,q1)];

% now replace q1 and q1dot with functions of time
syms q1f(t) q1dotf(t) q2f(t) q2dotf(t);
dL_dq1dotf = subs(dL_dq1dot,{q1dot, q1, q2dot, q2}, {q1dotf, q1f, q2dotf, q2f});
dL_dq1f = subs(dL_dq1,{q1dot, q1, q2dot, q2}, {q1dotf, q1f, q2dotf, q2f});

% now take d/dt of dL_dq1dot Matlab will apply the chain rule because it 
% knows q1 and q1dot are functions of t
eqn1 = diff(dL_dq1dotf, t) - dL_dq1f;

% now replace the diff operations on q1, q1dot, q2, and q2dot with q1dot,
% q1ddot, q2dot, q2ddot
% syms q1ddotf(t) q2ddotf(t)
eqn1 = subs(eqn1,{diff(q1f,t), diff(q2f,t)},{q1dotf, q2dotf});
% eqn1 = subs(eqn1,{diff(q1dotf,t), diff(q2dotf,t)},{q1ddotf, q2ddotf});


%% First we handle the Lagrangian condition for q2

% take partials of L with L in terms of q2 and q2dot
dL_dq2dot = [diff(L,q2dot)];
dL_dq2 = [diff(L,q2)];

% now replace q2 and q2dot with functions of time
syms q1f(t) q1dotf(t) q2f(t) q2dotf(t);
dL_dq2dotf = subs(dL_dq2dot,{q1dot, q1, q2dot, q2}, {q1dotf, q1f, q2dotf, q2f});
dL_dq2f = subs(dL_dq2,{q1dot, q1, q2dot, q2}, {q1dotf, q1f, q2dotf, q2f});

% now take d/dt of dL_dq2dot Matlab will apply the chain rule because it 
% knows q2 and q2dot are functions of t
eqn2 = diff(dL_dq2dotf, t) - dL_dq2f;

% now replace the diff operations on q1, q1dot, q2, and q2dot with q1dot,
% q1ddot, q2dot, q2ddot
% syms q1ddotf(t) q2ddotf(t)
eqn2 = subs(eqn2,{diff(q1f,t), diff(q2f,t)},{q1dotf, q2dotf});
% eqn2 = subs(eqn2,{diff(q1dotf,t), diff(q2dotf,t)},{q1ddotf, q2ddotf});


%% Now we define q2dot and q1dot as the derivatives of q1 and q2

eqn3 = q1dotf(t) == diff(q1f(t),t);
eqn4 = q2dotf(t) == diff(q2f(t),t);

%% Finally we combine for our output vector

dLdt = [eqn3; eqn1; eqn4; eqn2];
end