% ===============================================================================
% Tutorial for FAIR: MLPIR, MultiLevel Parametric Image Registration, regularized
% (c) Jan Modersitzki 2009/04/07, see FAIR.2 and FAIRcopyright.m.
% \url{http://www.cas.mcmaster.ca/~fair/index.shtml}
% 
%   - data                 HNSP, Omega=(0,2)x(0,1), level=3:7, m=[256,128]
%   - viewer               viewImage2D
%   - interpolation        splineInter2D
%   - distance             SSD
%   - pre-registration     splineTransformation2D, p=[8,8], alpha=8e6, M=eye
%   - optimization         Gauss-Newton
% ===============================================================================

clear, close all, help(mfilename);

% load data, set viewer, interpolator, distance
setupHNSPData; 
inter('reset','inter','splineInter2D','regularizer','none','theta',0);
distance('reset','distance','SSD');

% set-up transformation, regularization 
p = [8,8]; % using a p-spline grid
trafo('reset','trafo','splineTransformation2D','omega',omega,'m',m,'p',p);
w0 = trafo('w0'); wStop = w0;             % get starting point and stopping

M = 8e6*speye(length(w0)); wRef = w0;     % initilize the regularization

% run MLPIR
optn = {'M',M,'wRef',wRef,'Plots',@FAIRplots,'plotIter',0,'plotMLiter',0};
wc = MLPIR(MLdata,optn{:});
