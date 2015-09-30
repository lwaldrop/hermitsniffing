function [XX_data,YY_data] = flicknow(T,XX_data,YY_data,U,V,D)

% Diffusion
%
% Creates matrix of 1's and -1's based on pseudo-random number
% generator.

% Sets random number generator to start at a different position for every instance of 
% Matlab opened.
rng('shuffle') 

Np = size(XX_data);
Np1 = Np(1);
Np2 = Np(2);

x_rand = rand(Np1,Np2);
x_rand(x_rand<(1/3)) = -1;
x_rand(x_rand>=(2/3)) = 1;
x_rand(x_rand<1 & x_rand>0) = 0;

y_rand = rand(Np1,Np2);
y_rand(y_rand<(1/3)) = -1;
y_rand(y_rand>=(2/3)) = 1;
y_rand(y_rand<1 & y_rand>0) = 0;

% Diffusion half-step.
% Moves points according to root mean squared distance.
XX_data = XX_data + x_rand.*sqrt(D*T);  % former coefficient: .*2.1067e2
YY_data = YY_data + y_rand.*sqrt(D*T);  % former coefficient: .*2.0555e2

% Resamples velocities at new positions.
Uhairs = U(XX_data,YY_data);
Vhairs = V(XX_data,YY_data);


% Advection half-step.
XX_data = Uhairs.*(T) + XX_data;
YY_data = Vhairs.*(T) + YY_data;

