% =======================================================================================
% function [Dc,rc,dD,drc,d2psi] = NGFdot(Tc,Rc,omega,m,varargin);
% (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
% Normalized Gradient Fields based distance measure 
% for usage in a general Gauss-Newton type framework
% computes D(T,R) = psi(r(T)), dD  = dpsi*dr, d2D = dr'*d2Phi*dr + higher order terms
% here, psi(r) = 0.5*hd*(1-r'*r), dpsi = -hd*r, d2psi = hd = prod(omega./m)
% r(Y) = (|gradT x gradR|_{tol}/(|gradT|_{edge}*|gradR|_{edge}), 
% |x|_edge = sqrt(x'*x+edge^2), and dr = lengthy formula, edge = edge parameter
%
% Input: 
%  T, R			template and reference
%  omega, m 	represents domain and discretization
%  varargin		optional parameters, e.g. doDerivative=0
%
% Output:
%  Dc           NGF(T,R)
%  rc           (GT'*GR)/(|GT|*|GR|)
%  dD           dpsi*dr
%  dr           lengthy, see below
%  d2psi        2*hd
%
%  persistent discrete gradients supplied by getGrad are used
% =======================================================================================

function [Dc,rc,dD,drc,d2psi] = NGFdot(Tc,Rc,omega,m,varargin);

persistent G1 G2 G3                       % the gradient operators
                                          % initialize output variables
Dc  = []; dD = []; rc  = []; drc = []; d2psi = [];

edge         = 100;                       % the edge parameter
doDerivative = (nargout > 3);             % compute derivatives only on demand

for k=1:2:length(varargin),               % overwrites default parameter
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

h   = (omega(2:2:end)-omega(1:2:end))./m; % voxel size for integration
hd  = prod(h); n = prod(m);
dim = length(omega)/2;

if size(G1,2) ~= n,                       % set up gradient if necessary
  for j=1:dim,                            % compute discrete 1D derivatives
    d{j} = spdiags(ones(m(j),1)*[-1,1],[-1,1],m(j),m(j))/(2*h(j));
    d{j}([1,end]) = d{j}([2,end-1]);
  end;
  if dim == 2, 
    G1 = sparse(kron(speye(m(2)),d{1}));
    G2 = sparse(kron(d{2},speye(m(1))));
    G3 = 0;
  else
    G1 = sparse(kron(kron(speye(m(3)),speye(m(2))),d{1}));
    G2 = sparse(kron(kron(speye(m(3)),d{2}),speye(m(1))));
    G3 = sparse(kron(kron(d{3},speye(m(2))),speye(m(1))));
  end;  
end;

gradT  = [G1*Tc,G2*Tc,G3*Tc];              % compute gradients of T[y] and R
gradR  = [G1*Rc,G2*Rc,G3*Rc];              %   note: dim == 2 => G3 = 0
lengthGT = sqrt(sum(gradT.^2,2) + edge^2); % compute regularized length of dT[y] 
lengthGR = sqrt(sum(gradR.^2,2) + edge^2); % compute regularized length of dR
      
r1  = sum(gradR.*gradT,2);                 % nominator
r2  = 1./(lengthGT.*lengthGR);             %  ... and denominator
rc  = r1 .* r2;                            % combine things and finalize
Dc  = prod([omega(2:2:end)-omega(1:2:end)]) - hd * rc'*rc;

if ~doDerivative, return; end;

sdiag = @(a) spdiags(reshape(a,[],1),0,length(a),length(a));

dr1 = sdiag(gradR(:,1))*G1 + sdiag(gradR(:,2))*G2 + sdiag(gradR(:,3))*G3;
dr2 = -sdiag(1./(lengthGR.*lengthGT.^3)) * ...
     ( sdiag(gradT(:,1))*G1 + sdiag(gradT(:,2))*G2 + sdiag(gradT(:,3))*G3);
drc = (sdiag(r2)*dr1 + sdiag(r1)*dr2);
dD  = -2*hd*rc'*drc;
d2psi = 2*hd; % note the missing minus sign is not a bug!

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

