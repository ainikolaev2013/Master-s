%$ driver for (Multi Level)  Regularized Parametric Image Registration
%$ HNSP example, spline transformation
%$ (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
%$ note: '%$' is used so hide comments in the book                              

setupHNSPData; 
level = 5; 
omega = MLdata{level}.omega; m = MLdata{level}.m; 
clc; close all
p = [8,8];
inter('reset','inter','splineInter2D','regularizer','none','theta',0);
[T,R] = inter('coefficients',MLdata{level}.T,MLdata{level}.R,omega);
distance('reset','distance','SSD');
trafo('reset','trafo','splineTransformation2D','omega',omega,'m',m,'p',p);
w0 = trafo('w0');                        % get starting guess and stopping

% update the regularizer for parametric image registration
hd = prod((omega(2:2:end)-omega(1:2:end))./m);
Mi = @(i) 1e2*toeplitz([96,-54,0,6,zeros(1,p(i)-4)]);
Qi = @(i) toeplitz([120.8,59.55,6,0.05,zeros(1,p(i)-4)])/7;
M1 = kron(speye(p(2)),sparse(Mi(1)));
M2 = kron(sparse(Mi(2)),speye(p(1)));
M  = hd*sparse(kron(speye(2),...
  kron(Qi(2),Mi(1))+2*kron(Mi(2),Mi(1))+kron(Mi(2),Qi(1))));

% M = speye(length(w0));
alpha = 100;
beta  = 0;
wRef  = w0;

% initialize objective function
fctn  = @(wc) PIRobjFctn(T,Rc,omega,m,beta,alpha*M,wRef,xc,wc);
fctn([]);

% initialize plots
FAIRplots('set','mode','PIR-regularized','omega',omega,'m',m,'fig',1,'plots',1);
FAIRplots('init',struct('Tc',T,'Rc',R,'omega',omega,'m',m)); 

xc = getCenteredGrid(omega,m); 
Rc = inter(R,omega,xc);

% ----- call Gaus-Newton ------------------------------------
GNoptn = {'maxIter',50,'tolY',1e-4,'tolJ',1e-4,'tolG',1};
[wOpt,his] = GaussNewtonArmijo(fctn,w0,GNoptn{:},'Plots',@FAIRplots);

% plot iteration history
his.str{1} = sprintf('iteration history PIR: distance=%s, y=%s',distance,trafo);
[ph,th] = plotIterationHistory(his,'J',1:4);
