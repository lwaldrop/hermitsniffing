% multihairflick.m
%
% This is the most modern version of the multiflick/sniff functions.  This 
% script takes velocity vector fields from urapaverage.m for flick
% and return runs and simulates particles of fluid moving through the array
% during a flick and return cycle.
%
% Returns the positions of the particles after each of n steps during flick
% and return.  Also returns a test matrix of whether or not each particle
% falls outside the array, from inpolygon. 
%
%
% Inputs: flick event number, user defined
%         return event number, user defined
%         flick event, Event##_flickdata.mat
%         return event, Event##_flickdata.mat
%         return duration
%         flick duration
%         flick and return correction factor
%         
%  Output: outputsnuff
%        
% This has been updated to work with Matlab v7.10.0 (R2010a) through Matlab v8.3 (R2014a).
%
% Lindsay Waldrop, 2007-2015
% Special thanks to Dennis Evangelista for help with the code.
%
%
%%%%%%%%%%%%%%%%%%%%%%    

% Initialize parameters for this run

in_multihairflick

disp('Starting main sniff loop...')
disp('    ')


%%%%%%%%%%%%%%%%%%%%%%
%
% Start main.  This feeds data into the sniff3 function, which will
% then output the data from one flick/return cycle, or sniff.  

%disp(['Calculating points for sniff #',num2str(mm),'...'])

[XX_data,YY_data,captured.flick] = sniffmultihairs2(1,T,flicktime,D,U_flick,V_flick,...
    XX_data,YY_data,hairsflick,maskeflick);
disp('   ')

%disp('Assigning points for the return...')


% The return XX and YY will be the final flick points.  Adjusts these
% points so they line up and defines the input for .
% 
%XX_data = minus(XX_data,xfactor);
%YY_data = minus(YY_data,yfactor);


%[XX_data,YY_data,captured.return] = sniffmultihairs2(2,T,returntime,D,U_return,...
%    V_return,XX_data,YY_data,hairsreturn,maskereturn);

disp('done!')
disp('   ')

%%%%%%%%%%%%%%%%%%%%%%%%
% Calculating final percentages.

dlmwrite('captured_flick.csv',captured.flick) ;
%dlmwrite('captured_return.csv',captured.return) ;

Np = size(XX_data);
Np1 = Np(1);
Np2 = Np(2);

final_flick = sum(captured.flick)
perc_final_flick = final_flick/(Np1*Np2)
%final_return = sum(captured.return)
%perc_final_return = final_return/(Np1*Np2)

disp('done!')
disp('    ')
disp('    ')



disp('-------------------')
disp('Thank you for using multihairflick. Please come again.')
disp('-------------------')
disp('     ')
