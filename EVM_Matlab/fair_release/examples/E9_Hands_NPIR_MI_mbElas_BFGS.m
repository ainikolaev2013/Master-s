% ===============================================================================
% Example for Non-Parametric Image Registration with lBFGS scheme
% (c) Jan Modersitzki 2009/04/06, see FAIR.2 and FAIRcopyright.m.
% \url{http://www.cas.mcmaster.ca/~fair/index.shtml}
% 
%   - data                 Hand, Omega=(0,20)x(0,25), level=7, m=[128,128]
%   - viewer               viewImage2D
%   - interpolation        splineInter2D
%   - distance             MI
%   - regularizer          mbElastic
%   - optimizer            lBFGS
% ===============================================================================

% set-up data and initialize image viewer
setupHandData; FAIRdiary; level = 7; omega = MLdata{level}.omega; m = MLdata{level}.m; 

% initialize the interpolation scheme and coefficients
inter('reset','inter','splineInter2D'); 
[T,R] = inter('coefficients',MLdata{level}.T,MLdata{level}.R,omega,'out',0);
xc    = getCenteredGrid(omega,m); 
Rc    = inter(R,omega,xc);

% initialize distance measure
distance('set','distance','MI','nT',8,'nR',8);       

% initialize regularization, note: yc-yRef is regularized, elastic is staggered 
regularizer('reset','regularizer','mbElastic','alpha',1e-2,'mu',1,'lambda',0);
y0   = getStaggeredGrid(omega,m); yRef = y0; yStop = y0;


% set-up and initialize plots 
FAIRplots('set','mode','NPIR-Gauss-Newton','omega',omega,'m',m,'fig',1,'plots',1);
FAIRplots('init',struct('Tc',T,'Rc',R,'omega',omega,'m',m)); 


% build objective function, note: T coefficients of template, Rc sampled reference
fctn = @(yc) NPIRBFGSobjFctn(T,Rc,omega,m,yRef,yc); fctn([]); % report status

% -- solve the optimization problem -------------------------------------------
[yc,his] = lBFGS(fctn,y0,'maxIter',500,'Plots',@FAIRplots,'yStop',yStop);
% report results
% iter = size(his.his,1)-2; reduction = 100*fctn(yc)/fctn(getStaggeredGrid(omega,m)); yOpt = yc;
% fprintf('reduction = %s%% after %d iterations\n',num2str(reduction),iter);
diary off