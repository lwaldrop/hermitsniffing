function [XX_data,YY_data,captured] = sniffmultihairs2(r,T,t,D,U,V,XX_data,YY_data,hairs,maske)

% sniffmultihairs2.m
%
% Function for use with multihairflick.m. Interpolates velocity field over hair
% array during one flick and return, but takes input from multiflick3 to
% allow for multiple flicks in a row.
% For just one event!
% Called by: multihairflick.m. Calls: flicknow.m, testdotshermit.m
%
% This has been updated to work with Matlab v7.10.0 (R2010a) through Matlab v8.3 (R2014a). 
% Updated: 12/12/2014! Documentation updated on 9/30/2015!
%
% Lindsay Waldrop, 2007-2015
%

% Setting initial velocities
Uhairs = U(XX_data,YY_data); 
Vhairs = V(XX_data,YY_data);

%n = round(t/T);
n = 2000; % for testing purposes
% Np = length(XX_data);
p = 500;  %Number of steps between printing data. 

%%%%%%%%%%%%%%%%
%
% Start "flick" loop.  This moves points according to the velocities
% specificed in Uhairs and Vhairs, then samples velocities for the new points.
%

disp('Calculating position and velocity data for flick step:')


% Advection half-time step.

XX_data = Uhairs.*(T/2) + XX_data;
YY_data = Vhairs.*(T/2) + YY_data;

captured = zeros(n,1);

for k = 2:n
    
    %Flick (advection and diffusion code).
    
    [XX_data,YY_data] = flicknow(T,XX_data,YY_data,U,V,D);
    
    % Tests each position to see if the new position falls outside of the hair array
    % range.  Returns 1 for true (stays within), 0 for false (travels
    % outside).
    
    [testdots1,testdots2] = testdotshermit(XX_data,YY_data,hairs,maske);
    
    % Uses test data to replace points inside hairs and maske with NaN.
    XX_data(testdots1) = NaN;
    YY_data(testdots1) = NaN;
    
    XX_data(testdots2) = NaN;
    YY_data(testdots2) = NaN;
    
    captured(k,1) = sum(sum(testdots1));
    
    % Plots data every p number of steps
    if mod(k,p)==0 && k<2000
        disp(num2str(k))
        dlmwrite(['XX_data_',num2str(k),'_',num2str(r),'.csv'], XX_data) ;
        dlmwrite(['YY_data_',num2str(k),'_',num2str(r),'.csv'], YY_data) ;

        
    else
       
    end
    
end

% Final advection half step.

XX_data = Uhairs.*(T/2) + XX_data;
YY_data = Vhairs.*(T/2) + YY_data;

[testdots1,testdots2] = testdotshermit(XX_data,YY_data,hairs,maske);

% Uses test data to replace points inside hairs and maske with NaN.
XX_data(testdots1) = NaN;
YY_data(testdots1) = NaN;

XX_data(testdots2) = NaN;
YY_data(testdots2) = NaN;

% Writes final data set to files.
dlmwrite(['XX_data_',num2str(n),'_',num2str(r),'.csv'], XX_data) ;
dlmwrite(['YY_data_',num2str(n),'_',num2str(r),'.csv'], YY_data) ;
            


disp('done!')
disp('    ')

%
%
% End "flick" loop. 
%
%%%%%%%%%%%%%%%%



disp('     ') 
disp('-------------------')
disp('This flick is done.')
disp('-------------------')
disp('     ')

