function wc=SRKazan
clearFAIR;
outfile = [mfilename('fullpath'),'.mat'];

% set view options and interpolation options
viewOptn = {'viewImage','viewImage2D','colormap','gray(256)'};
viewImage('reset',viewOptn{:});

message = @(str) fprintf('%% %s  [ %s ]  % s\n',...
  char(ones(1,10)*'-'),str,char(ones(1,60-length(str))*'-'));
message(mfilename)

MLdata=get2DdataM(outfile,'/media/6A0031200030F4A3/business/cameras/эксперименты/faceFrames_1/1.bmp','/media/6A0031200030F4A3/business/cameras/эксперименты/faceFrames_1/2.bmp','omega',[0,2,0,1],'m',[80,80]);
 level = 7; omega = [0,2,0,1]; m = [80,80];
 [T,R] = inter('coefficients',MLdata{level}.T,MLdata{level}.R,omega);
 xc = getCenteredGrid(omega,m); 
 Rc = inter(R,omega,xc);
% 
% % initialize distance measure
 distance('set','distance','SSD');       
% 
% % initialize the transformation and a starting guess
 trafo('reset','trafo','affine2D');
 w0 = trafo('w0'); 
% 
% % set-up plots and initialize
 FAIRplots('set','mode','PIR-Gauss-Newton','omega',omega,'m',m,'fig',1,'plots',1);
 FAIRplots('init',struct('Tc',T,'Rc',R,'omega',omega,'m',m)); 
% 
% % build objective function
% % note: T  is template image
% %       Rc is sampled reference
% %       optional Tichonov-regularization is disabled by setting m = [], wRef = []
% %       beta = 0 disables regularization of Hessian approximation
 beta = 0; M = []; wRef = [];
 fctn = @(wc) PIRobjFctn(T,Rc,omega,m,beta,M,wRef,xc,wc); 
 fctn([]);   % report status
% 
% % -- solve the optimization problem -------------------------------------------
 [wc,his] = GaussNewtonArmijo(fctn,w0,'Plots',@FAIRplots,'solver',[],'maxIter',100);
 plotIterationHistory(his,'J',[1,2,5],'fig',20+level); 
end

