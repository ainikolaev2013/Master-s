% =======================================================================================
% function varargout = inter(varargin)
% (c) Jan Modersitzki 2009/03/25, see FAIR.2 and FAIRcopyright.m.
% 
% Main function for interpolation, possiple calls:
%
% interpolate:
%  [Tc,dT] = inter(dataT,omega,yc);
%  evaluates the interpolant of the data dataT given on an m=size(dataT) 
%  cell-centered grid for the points collected in 
%  y = [Y(:,1);Y(:,2),...,Y(:,d)] using the options specified
%  in the persistent variable OPTN
%
% administration, parameter setting:
%  for resetting, intitializing, setting, updating, clearing, displaying,
%  see options.m
%
% additional option 'coefficients':
%  [coefT,coefR] = inter('coefficients',dataT,dataR,omega);
%  returns the coefficients for the bassis functions
%  (coefT=dataT for linear, coefT=getSplineCoefficients for spline)
%
% specific optn:
%  [Tc,dT] = inter(dataT,omega,yc,specific{:}), uses specific for this call
% =======================================================================================

function varargout = inter(varargin)

% handle options
persistent OPTN 


% check for reset, set, clear, disp, see options.m
[method,OPTN,task,stop] = options(OPTN,varargin{:});
if stop,  varargout = {method,OPTN};  return; end

% update spline coefficients, if neccessary
if strcmp(task,'coefficients'),
  T   = varargin{2};  R   = varargin{3};  dim = length(varargin{4})/2;
  if ~isempty(findstr(method,'spline')),
    T = getSplineCoefficients(T,'dim',dim,OPTN{:},varargin{5:end});
    R = getSplineCoefficients(R,'dim',dim,OPTN{:},varargin{5:end});
  end;
  varargout = {T,R};
  return;
end;

% do the work
[method,optn] = options(OPTN,'set','doDerivative',(nargout>1),varargin{4:end});
T         = varargin{1};
omega     = varargin{2};
x         = varargin{3}(:); 
[T,dT]    = feval(method,T,omega,x,optn{:});
varargout = {T,dT};
% =======================================================================================

%$=======================================================================================
%$  FAIR: Flexible Algorithms for Image Registration
%$  Copyright (c): Jan Modersitzki
%$  1280 Main Street West, Hamilton, ON, Canada, L8S 4K1
%$  Email: modersitzki@mcmaster.ca
%$  URL:   http://www.cas.mcmaster.ca/~modersit/index.shtml
%$=======================================================================================
%$  No part of this code may be reproduced, stored in a retrieval system,
%$  translated, transcribed, transmitted, or distributed in any form
%$  or by any means, means, manual, electric, electronic, electro-magnetic,
%$  mechanical, chemical, optical, photocopying, recording, or otherwise,
%$  without the prior explicit written permission of the authors or their 
%$  designated proxies. In no event shall the above copyright notice be 
%$  removed or altered in any way.
%$ 
%$  This code is provided "as is", without any warranty of any kind, either
%$  expressed or implied, including but not limited to, any implied warranty
%$  of merchantibility or fitness for any purpose. In no event will any party
%$  who distributed the code be liable for damages or for any claim(s) by 
%$  any other party, including but not limited to, any lost profits, lost
%$  monies, lost data or data rendered inaccurate, losses sustained by
%$  third parties, or any other special, incidental or consequential damages
%$  arrising out of the use or inability to use the program, even if the 
%$  possibility of such damages has been advised against. The entire risk
%$  as to the quality, the performace, and the fitness of the program for any 
%$  particular purpose lies with the party using the code.
%$=======================================================================================
%$  Any use of this code constitutes acceptance of the terms of the above
%$                              statements
%$=======================================================================================
