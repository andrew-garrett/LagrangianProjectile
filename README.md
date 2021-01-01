# LagrangianProjectile
Lagrangian approach to modeling a catapault

This is the final project for MEAM248, a lab course for Mechanical Engineering sophomores at Penn.  For this project, I implemented Lagrangian Mechanics to determine the trajectory and path of a ball being launched by a catapault.  By accounting for drag, I was also able to model the general flight path of the projectile while in the air.  Parameterization is fairly rigorous, because the code uses vector-maps and differentiation to model the system from a very generalized standpoint.  This code is unique because I use a vector map input to create my own matlab function to be integrated and solved, rather than the traditional numerical solution produced by running say ode45 or ode23.  By running the solver file, one can view the path of the projectile, from the loaded state, all the way to its landing on the ground (or exitting the MATLAB figure).

Although the equations are parameterized, the visualizer uses measurements from a real model of a spring loaded catapault, so if you are interested in making changes to the file the visualizer may require further work.
