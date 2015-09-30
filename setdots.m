function [XX_data,YY_data] = setdots(Np,flickdata,h,w)
% Function for creating the initial positions of simulated odor molecules. 
% Called by in_multihairflick.m
%
disp('Setting up interpolated data points...')
% Sets up the ranges that all interpolated data points will sit in to be
% perfectly comparable between two different shapes.

disp('Assigning start data...')

% Placement parameters
factorx = 0.99;
factory = 0.6;
x_shift = 2e-3;
y_shift = 0;%1.0e-3;

if h == 1
    % For linearly space points:
    S = [0 1; 0 1];
    T = [0 0; 1 1];
    s = linspace(0,1,Np);
    t = linspace(0,1,Np);
    [SS,TT] = meshgrid(s,t);
    
    % For evenly distributed molecules:
    stripe_X = [max(max(flickdata.xx))*factorx-x_shift max(max(flickdata.xx)-x_shift); max(max(flickdata.xx))*factorx-x_shift max(max(flickdata.xx))-x_shift]; % Good for hermit diffusion only testing.
    stripe_Y = [min(min(flickdata.yy))*factory-y_shift min(min(flickdata.yy))*factory-y_shift; max(max(flickdata.yy))-y_shift max(max(flickdata.yy))-y_shift];
    XX_data = interp2(S,T,stripe_X,SS,TT);
    YY_data = interp2(S,T,stripe_Y,SS,TT);
    
    m = (max(max(stripe_X))-min(min(stripe_X)))*(max(max(stripe_Y))-min(min(stripe_Y)))/100^2
    conc_molecules = Np^2/m
    avag = 6.0221415e+23;
    conc_mol = (Np^2/avag)/m
    g_mol = 116.16;
    conc_kg_perL = (Np^2/avag*g_mol)/m/1000
    ppm = conc_kg_perL/1.2*1000000
    ppb = conc_kg_perL/1.2*1000000000
    

else
    %For log-distribution across x:
    S = [1 10];
    T = [1 10];
    s1 = logspace(0,1,(Np/2));
    s2 = s1.*-1 + 11;

    t = linspace(1,10,Np);


    [SS1,TT1] = meshgrid(s1,t);
    [SS2,TT2] = meshgrid(s2,t);
    % For log-distributed molecules:
    stripe_X1 = [max(max(flickdata.xx))/(3/2) max(max(flickdata.xx)/(6/5)); max(max(flickdata.xx))/(3/2) max(max(flickdata.xx))/(6/5)]; % Good for hermit diffusion only testing.
    stripe_X2 = [max(max(flickdata.xx))/(6/5) max(max(flickdata.xx)); max(max(flickdata.xx))/(6/5) max(max(flickdata.xx))]; % Good for hermit diffusion only testing.
    stripe_Y = [min(min(flickdata.yy)) min(min(flickdata.yy)); max(max(flickdata.yy)) max(max(flickdata.yy))];

    XX_data(1:Np,1:(Np/2)) = interp2(S,T,stripe_X2,SS1,TT1);
    XX_data(1:Np,(Np/2+1):Np) = interp2(S,T,stripe_X1,SS2,TT2);

    YY_data(1:Np,1:(Np/2)) = interp2(S,T,stripe_Y,SS2,TT2);
    YY_data(1:Np,(Np/2+1):Np) = interp2(S,T,stripe_Y,SS1,TT1);
end

% Finds points within antennule region and turns them into NaN's.

p = length(flickdata.hairs);

for i = 1:p
    
    test1 = inpolygon(XX_data,YY_data,flickdata.hairs(1,i).x,flickdata.hairs(1,i).y);
    XX_data(test1) = NaN;
    YY_data(test1) = NaN;
    
end


% Finds points within antennule region and turns them into NaN's.
test2 = inpolygon(XX_data,YY_data,flickdata.maske.idxw,flickdata.maske.idyw);
XX_data(test2) = NaN;
YY_data(test2) = NaN;

if w == 1
    
    % Plot initial point positions:
    w2 = magnitude(flickdata.xx,flickdata.yy,flickdata.U,flickdata.V);
    figure
    pcolor(flickdata.xx,flickdata.yy,w2),shading flat
    hold on
    %plot(flickdata.hairs(1,i).x,flickdata.hairs(1,i).y,'b-')
    for i = 1:length(flickdata.hairs)
        plot(flickdata.hairs(1,i).x,flickdata.hairs(1,i).y,'w-')
    end
    plot(XX_data(1:100:Np,1:100:Np),YY_data(1:100:Np,1:100:Np),'k.')
    hold off
    
else 
    
end

disp('done!')
disp('   ')
