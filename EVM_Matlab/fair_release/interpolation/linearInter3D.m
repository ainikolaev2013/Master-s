% function [Tc,dT] = linearInter3D(T,omega,x,varargin);
% (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
% linear interpolator for the data T given on a cell-centered grid 
% on (omega(1),omega(2)) x (omega(3),omega(4)) x (omega(5),omega(6)), to be evaluated at x

function [Tc,dT] = linearInter2D(T,omega,x,varargin);
         
% if nargin == 0, return filename
if nargin == 0, Tc = mfilename('fullpath'); dT = []; return; end;

% flag for computing the derivative
doDerivative = (nargout>1);
for k=1:2:length(varargin), % overwrite default parameter
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

% get data size m, cell size h, dimension d, and number n of interpolation points
m  = size(T); 
h  = (omega(2:2:end)-omega(1:2:end))./m; 
d  = length(omega)/2; 
n  = length(x)/d;    
x  = reshape(x,n,d);
% map x from [h/2,omega-h/2] -> [1,m],
for i=1:d, x(:,i) = (x(:,i)-omega(2*i-1))/h(i) + 0.5; end;

Tc = zeros(n,1); dT = [];                   % initialize output
if doDerivative, dT = zeros(n,d);  end;     % allocate memory in column format
Valid = @(j) (0<x(:,j) & x(:,j)<m(j)+1);    % determine indices of valid points
valid = find( Valid(1) & Valid(2) & Valid(3) );                
if isempty(valid),                        
  if doDerivative, dT = sparse(n,d*n); end; % allocate memory incolumn format
  return; 
end;
                                          % pad data to reduce cases
pad = 1; TP = zeros(m+2*pad); TP(pad+(1:m(1)),pad+(1:m(2)),pad+(1:m(3))) = T;
clear T;
P = floor(x); x = x-P;                    % split x into integer/remainder
p = @(j) P(valid,j); xi = @(j) x(valid,j);
i1 = 1; i2 = size(TP,1); i3 = size(TP,1)*size(TP,2);
p  = (pad + p(1)) + i2*(pad + p(2) - 1) + i3*(pad + p(3) -1);

                                          % compute Tc as weighted sum                                        
Tc(valid) = ((TP(p).*(1-xi(1))+TP(p+i1).*xi(1)).*(1-xi(2))...
  +(TP(p+i2).*(1-xi(1))+TP(p+i1+i2).*xi(1)).*(xi(2))).*(1-xi(3)) ...
  +((TP(p+i3).*(1-xi(1))+TP(p+i1+i3).*xi(1)).*(1-xi(2)) ...
  +(TP(p+i2+i3).*(1-xi(1))+TP(p+i1+i2+i3).*xi(1)).*(xi(2))).*(xi(3));

if ~doDerivative, return;  end;
dT(valid,1) = ((TP(p+i1)-TP(p)).*(1-xi(2))+(TP(p+i1+i2)-TP(p+i2)).*xi(2)).*(1-xi(3)) ...
  +((TP(p+i1+i3)-TP(p+i3)).*(1-xi(2))+(TP(p+i1+i2+i3)-TP(p+i2+i3)).*xi(2)).*(xi(3));
dT(valid,2) = ((TP(p+i2)-TP(p)).*(1-xi(1))+(TP(p+i1+i2)-TP(p+i1)).*xi(1)).*(1-xi(3)) ...
  +((TP(p+i2+i3)-TP(p+i3)).*(1-xi(1))+(TP(p+i1+i2+i3)-TP(p+i1+i3)).*xi(1)).*(xi(3));
dT(valid,3) = ((TP(p+i3).*(1-xi(1))+TP(p+i1+i3).*xi(1)).*(1-xi(2)) ...
  +(TP(p+i2+i3).*(1-xi(1))+TP(p+i1+i2+i3).*xi(1)).*(xi(2))) ....
  -((TP(p).*(1-xi(1))+TP(p+i1).*xi(1)).*(1-xi(2)) ...
  +(TP(p+i2).*(1-xi(1))+TP(p+i1+i2).*xi(1)).*(xi(2)));
dT(:,1) = dT(:,1)/h(1);  dT(:,2) = dT(:,2)/h(2);  dT(:,3) = dT(:,3)/h(3);               
dT = spdiags(dT,[0,n,2*n],n,3*n);

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
