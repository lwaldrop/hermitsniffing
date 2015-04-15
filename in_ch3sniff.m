% in_ch3sniff.m
%
% Define event number of the run of interest.  Prompt user for input.


% % Initializing by hand.
% flick_event = input('Condition of Flick?','s');
% return_event = input('Condition of Return?','s');
% 
% 
% 
% % Loads return data first.
% 
% disp(['Loading data for return event ',return_event,'...'])
% load(['Event',return_event,'_flickdata.mat']);
% returndata = flickdata; 
% clear flickdata
% disp('done!')
% 
% % returndata.time = 0.025; % Duration of return, in seconds.
% 
% 
% % Loads flick data.
% disp(['Loading data for flick event ',flick_event,'...'])
% load(['Event',flick_event,'_flickdata.mat']);
% disp('done!')
% disp('   ')
% disp('   ')



load('Event618_newdata.mat');

load('TriInter_sniff.mat');


n = 5000;  % number of steps: 5000
t_step = newdata.returntime/n;
% For flick:
n = round(newdata.flicktime/t_step);

disp('   ')
disp(['Flick or return will be divided into ',num2str(n),' steps.'])
disp('   ')




disp('Setting up interpolated data points...')
% Sets up the ranges that all interpolated data points will sit in to be
% perfectly comparable between two different shapes.

disp('Assigning start data...')

ptspermm_x = 5e4;
ptspermm_y = 5e4;


% number of points spread; changed 5/9/14 to be full Xbox and Ybox, not just XRbox and YRbox
newdata.Npx = ptspermm_x*(max(max(newdata.Xbox))-min(min(newdata.Xbox))); 
newdata.Npy = ptspermm_y*(max(max(newdata.Ybox))-min(min(newdata.Ybox)));

S = [0 1; 0 1];
T = [0 0; 1 1];
s = linspace(0,1,newdata.Npx);
t = linspace(0,1,newdata.Npy);
[SS,TT] = meshgrid(s,t);

% Points are all over the field not including antennule and hair regions:

% stripe.X = [240 480; 240 480]; %Good for hermit and blue: closeup cross-section
% stripe.Y = [0 0; 420 420];
% 
newdata.Xdots = interp2(S,T,newdata.Xbox,SS,TT); %changed 5/9/14 to be full Xbox and Ybox, not just XRbox and YRbox
newdata.Ydots = interp2(S,T,newdata.Ybox,SS,TT); %changed 5/9/14 to be full Xbox and Ybox, not just XRbox and YRbox

disp('done!')
	disp('   ')
    
% Uncomment to plot a test of the initial conditions.
% figure
% hold on
% plot(newdata.Xbox,newdata.Ybox,'b-')
% xplot = [newdata.Xbox(1,1) newdata.Xbox(2,1);newdata.Xbox(1,2) newdata.Xbox(2,2)];
% yplot = [newdata.Ybox(1,1) newdata.Ybox(2,1);newdata.Ybox(1,2) newdata.Ybox(2,2)];
% plot(xplot,yplot,'b-')
% 
% % % Red bowtie.
% plot(newdata.XRbox,newdata.YRbox,'r-')
% 
% plot(newdata.Xdots(1:50:end,1:50:end),newdata.Ydots(1:50:end,1:50:end),'r.')
% 
% hold off
%     
    
    
% Uncomment this to recalculate the functions!!
%

% disp('Calculating function to interpolate velocities using TriScatteredInterp:')
% disp('...')
% 
% si = size(newdata.x);
% si = si(1,1);
% 
% for ii = 1:si
%     
%     x_flick_tri(1+(ii-1)*1000:ii*1000,1) = newdata.x(ii,:);
%     y_flick_tri(1+(ii-1)*1000:ii*1000,1) = newdata.y(ii,:);
%     u_flick_tri(1+(ii-1)*1000:ii*1000,1) = newdata.fu(ii,:);
%     v_flick_tri(1+(ii-1)*1000:ii*1000,1) = newdata.fv(ii,:);
%     
%     
% end
% 
% U_flick = TriScatteredInterp(x_flick_tri,y_flick_tri,u_flick_tri);
% V_flick = TriScatteredInterp(x_flick_tri,y_flick_tri,v_flick_tri);
% 
% save('TriInter_sniff.mat','U_flick','V_flick');

disp('...Done!')
    