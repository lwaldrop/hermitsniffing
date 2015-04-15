function [XX_data,YY_data] = sniffadonly(n,t_step,flickdata,U_flick,V_flick)

% sniffmultihairs2.m
%
% Function for use with multihairflick.m. Interpolates velocity field over hair
% array during one flick and return, but takes input from multiflick3 to
% allow for multiple flicks in a row.
% For just one event!
%
% This has been updated to work with Matlab v7.10.0 (R2010a). Updated:
% 2/17/2013!
%
% Dennis Evangelista and Lindsay Waldrop, 2007-2013
% We're too sexy!
%
% Defines the time step length t_flick and t_return based on the number of
% steps.

XX_data = flickdata.Xdots;
YY_data = flickdata.Ydots;

Uhairs = U_flick(flickdata.Xdots,flickdata.Ydots); 
Vhairs = V_flick(flickdata.Xdots,flickdata.Ydots);

flickdata.D = 0;

%%%%%%%%%%%%%%%%
%
% Start "flick" loop.  This moves points according to the velocities
% specificed in Uhairs and Vhairs, then samples velocities for the new points.
%

disp('Flicking...')


for k = 2:n
    
    %disp(num2str(k))
    %toc
    
    % Advection.
    XX_data = Uhairs.*t_step + XX_data;
    YY_data = Vhairs.*t_step + YY_data;

    % Tests each position to see if the new position falls outside of the hair array
    % range.  Returns 1 for true (stays within), 0 for false (travels
    % outside).
    
    %[testdots1,testdots2] = testdots(Np,XX_data,YY_data,flickdata.hairs_x,flickdata.hairs_y,flickdata.maske);
    
    %eval(['test.flick',num2str(k),'= testdots1;']);
    
    
    % Resamples velocities at new position points. 

    Uhairs = U_flick(XX_data,YY_data);
    Vhairs = V_flick(XX_data,YY_data);
    
end


%
%
% End "flick" loop. 
%
%%%%%%%%%%%%%%%%
disp('Done!')


disp('     ') 
disp('-------------------')
disp('This sniff is done.')
disp('-------------------')
disp('     ')

