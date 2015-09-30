% in_multihairflick.m


load('no_vel_flick.mat');
flickdata = newdata;
clear newdata

load('no_vel_flick.mat');
returndata = newdata;
clear newdata

load('TriInter_hairs0.mat');

Np = 1000; % number of points spread
n = 10000;  % number of steps %water: 1000, air: ????
h = 1;      % Type of odor stipe. 1 for even distribution, 0 for log distribution
plo = 0;    % 1 = plots initial positions of points, 0 = does not plot points.

flicktime = flickdata.flicktime;
returntime = returndata.returntime;
T = flicktime/n; %Length of time for each step


% Defines diffusivity coefficent. 
D = 6.02e-2; % cm^2s^-1 Caproic acid, air
% D = 7.84e-6; % cm^2s^-1 Caproic acid, water
% D = 1e-8; % Made up

% This lines up the flick box points with the return box points.

disp('Calculating translation factor for return data...')


if flickdata.hairs(1,1).x(1,1) == returndata.hairs(1,1).x(1,1);
    
    xfactor = 0;
    
else 
    
    xfactor = minus(flickdata.hairs(1,1).x(1,1),returndata.hairs(1,1).x(1,1));
    xfactor = xfactor(1,1);
    
end    

if flickdata.hairs(1,1).y(1,1) == returndata.hairs(1,1).y(1,1);
    
    yfactor = 0;
    
else
    
    yfactor = minus(flickdata.hairs(1,1).y(1,1),returndata.hairs(1,1).y(1,1));
    yfactor = yfactor(1,1);
    
end


disp('done!')
disp('   ')

%Sets up initial positions of dots.
[XX_data,YY_data] = setdots(Np,flickdata,h,plo);

hairsflick = flickdata.hairs;
hairsreturn = returndata.hairs;

maskeflick = flickdata.maske;
maskereturn = returndata.maske;
    

% Uncomment this to recalculate the TriScatteredInterp functions!!
% 

% disp('Calculating function to interpolate velocities uding TriScatteredInterp:')
% disp('...')
% 
% si = length(flickdata.xx);
% 
% for ii = 1:si
%     
%     x_flick_tri(1+(ii-1)*1000:ii*1000,1) = flickdata.xx(ii,:);
%     y_flick_tri(1+(ii-1)*1000:ii*1000,1) = flickdata.yy(ii,:);
%     u_flick_tri(1+(ii-1)*1000:ii*1000,1) = flickdata.U(ii,:);
%     v_flick_tri(1+(ii-1)*1000:ii*1000,1) = flickdata.V(ii,:);
%     
%     x_return_tri(1+(ii-1)*1000:ii*1000,1) = returndata.xx(ii,:);
%     y_return_tri(1+(ii-1)*1000:ii*1000,1) = returndata.yy(ii,:);
%     u_return_tri(1+(ii-1)*1000:ii*1000,1) = returndata.U(ii,:);
%     v_return_tri(1+(ii-1)*1000:ii*1000,1) = returndata.V(ii,:);
%     
% end
% 
% U_flick = TriScatteredInterp(x_flick_tri,y_flick_tri,u_flick_tri);
% V_flick = TriScatteredInterp(x_flick_tri,y_flick_tri,v_flick_tri);
% 
% U_return = TriScatteredInterp(x_return_tri,y_return_tri,u_return_tri);
% V_return = TriScatteredInterp(x_return_tri,y_return_tri,v_return_tri);
%  
% clear si ii 
% clear x_flick_tri y_flick_tri u_flick_tri v_flick_tri
% clear x_return_tri y_return_tri u_return_tri v_return_tri

% Experimentally smoothing velocity field

%Vsf = smoothn({flickdata.U,flickdata.V},'robust');
%Vsr = smoothn({returndata.U,returndata.V},'robust');
% Uncomment this to recalculate the TriScatteredInterp functions!!
% 
%% Doesn't work very well, makes a bigger file. 

% % disp('Calculating function to interpolate velocities uding TriScatteredInterp:')
% % disp('...')
% % 
% % si = length(flickdata.xx);
% % 
% % for ii = 1:si
% %     
% %     x_flick_tri(1+(ii-1)*1000:ii*1000,1) = flickdata.xx(ii,:);
% %     y_flick_tri(1+(ii-1)*1000:ii*1000,1) = flickdata.yy(ii,:);
% %     u_flick_tri(1+(ii-1)*1000:ii*1000,1) = Vsf{1,1}(ii,:);
% %     v_flick_tri(1+(ii-1)*1000:ii*1000,1) = Vsf{1,2}(ii,:);
% %     
% %     x_return_tri(1+(ii-1)*1000:ii*1000,1) = returndata.xx(ii,:);
% %     y_return_tri(1+(ii-1)*1000:ii*1000,1) = returndata.yy(ii,:);
% %     u_return_tri(1+(ii-1)*1000:ii*1000,1) = Vsr{1,1}(ii,:);
% %     v_return_tri(1+(ii-1)*1000:ii*1000,1) = Vsr{1,2}(ii,:);
% %     
% % end
% % 
% % U_flick = TriScatteredInterp(x_flick_tri,y_flick_tri,u_flick_tri);
% % V_flick = TriScatteredInterp(x_flick_tri,y_flick_tri,v_flick_tri);
% % 
% % U_return = TriScatteredInterp(x_return_tri,y_return_tri,u_return_tri);
% % V_return = TriScatteredInterp(x_return_tri,y_return_tri,v_return_tri);
% %  
% % clear si ii 
% % clear x_flick_tri y_flick_tri u_flick_tri v_flick_tri
% % clear x_return_tri y_return_tri u_return_tri v_return_tri
% % 
% save('TriInter_hairs0.mat','U_flick','V_flick','U_return','V_return');
% % 
% % clear flickdata returndata Np h n Vsr Vsf

n=0;
r=0;
dlmwrite(['XX_data_',num2str(n),'_',num2str(r),'.csv'], XX_data) ;
dlmwrite(['YY_data_',num2str(n),'_',num2str(r),'.csv'], YY_data) ;

clear n r ans

disp('...Done!')
    
