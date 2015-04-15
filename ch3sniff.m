% ch3sniff.m
%
% This is a specialized version of the multiflick/sniff functions for the
% data in Ch 3 paper. More details to come...
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
%
% Lindsay Waldrop and Dennis Evangelista, 2007-2014
% We're too sexy!
%
%

clear all
close all

global Np n t_step; 
global U_flick V_flick;

    
% Initialize parameters for this run

tic 

in_ch3sniff

toc

disp('Starting main sniff loop...')
disp('    ')

%%% Now run the advection code:
tic
  
  [final.Xdots,final.Ydots] = sniffadonly(n,t_step,newdata,U_flick,V_flick);


time = toc

XR = [newdata.Xbox(1,1) newdata.Xbox(1,2) newdata.Xbox(2,2) newdata.Xbox(2,1)]; %changed 5/9/14 to be full Xbox and Ybox, not just XRbox and YRbox
YR = [newdata.Ybox(1,1) newdata.Ybox(1,2) newdata.Ybox(2,2) newdata.Ybox(2,1)]; %changed 5/9/14 to be full Xbox and Ybox, not just XRbox and YRbox

final.testdots = inpolygon(final.Xdots,final.Ydots,XR,YR);
final.percent = sum(sum(final.testdots))/(newdata.Npx*newdata.Npy);

final

disp(['Number of steps per sniff: ',num2str(n)])
disp('    ')
disp('All done!')
disp('    ')


disp('Saving data...')
%Saves Everything.
save(['ch3sniff_',num2str(n),'steps.mat'],'final','newdata'); %,'XX_data1','YY_data1','test1');


disp('done!')
disp('    ')
disp('    ')



disp('-------------------')
disp('Thank you for using multihairflick. Please come again.')
disp('-------------------')
disp('     ')