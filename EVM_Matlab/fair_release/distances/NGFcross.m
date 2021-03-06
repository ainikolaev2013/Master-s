% =======================================================================================
% function [Dc,rc,dD,drc,d2psi] = NGFcross(Tc,Rc,omega,m,varargin);
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
%  Dc           NGFcross(T,R)
%  rc           |GTxGR|, note this leads to minima, if GTxGR=0! 
%  dD           dpsi*dr
%  dr           lengthy, see below
%  d2psi        2*hd
%
%  persistent discrete gradients supplied by getGrad are used
% =======================================================================================

function [Dc,rc,dD,dr,d2psi] = NGFcross(Tc,Rc,omega,m,Y,varargin);

persistent G1 G2 G3                     % the gradient operators
                                        % initialize output variables

edge         = 10;                      % the edage parameter
tol          = 1e-3;                    % tolerance makes |.| differentiable
doDerivative = (nargout > 3);           % compute derivatives only on demand
mask         = [];

for k=1:2:length(varargin),           % overwrites default parameter
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

h = (omega(2:2:end)-omega(1:2:end))./m; % voxel size for integration
hd = prod(h); n = prod(m);

if size(G1,2) ~= n,                     % set up gradient if necessary
  for j=1:length(omega),                % compute discrete 1D derivatives
    d{j} = spdiags(ones(m(j),1)*[-1,1],[-1,1],m(j),m(j))/(2*h(j));
    d{j}([1,end]) = d{j}([2,end-1]);
  end;
  if length(omega) == 2, 
    G1 = sparse(kron(speye(m(2)),d{1}));
    G2 = sparse(kron(d{2},speye(m(1))));
    G3 = 0;
  else
    G1 = sparse(kron(kron(speye(m(3)),speye(m(2))),d{1}));
    G2 = sparse(kron(kron(speye(m(3)),d{2}),speye(m(1))));
    G3 = sparse(kron(kron(d{3},speye(m(2))),speye(m(1))));
  end;  
end;

gradT  = [G1*Tc,G2*Tc,G3*Tc];           % compute gradients of T[y] and R
gradR  = [G1*Rc,G2*Rc,G3*Rc];           %   note: dim == 2 => G3 = 0
lT = sqrt(sum(gradT.^2,2) + edge^2);    % compute regularized length of dT[y] 
lR = sqrt(sum(gradR.^2,2) + edge^2);    % compute regularized length of dR
% compute vector product, dim == 2 => gradT(:,3) == 0 & gradR(:,3) == 0
cross = [ (gradT(:,2).*gradR(:,3) - gradT(:,3).*gradR(:,2)), ...
          (gradT(:,3).*gradR(:,1) - gradT(:,1).*gradR(:,3)), ...
          (gradT(:,1).*gradR(:,2) - gradT(:,2).*gradR(:,1))      ];        
r1 = sqrt( sum(cross.^2,2) + tol^2 );   % compute numerator ...
r2 = 1./(lT.*lR);                       %  ... and denominator
rc = r1 .* r2;                          % combine things and finalize

% figure(1); viewImage2Dsc(rc,omega,m)
if ~isempty(mask),
  rc = mask(:).*rc; 
end;

Dc = hd/2 * rc' * rc;                    

if ~doDerivative, return; end;
                                              
                                        % short cut for diagonal matrices
sdiag = @(a) spdiags(reshape(a,[],1),0,length(a),length(a));

dr1 = sdiag(1./r1) * ( ...
    sdiag(cross(:,1))*( sdiag(gradR(:,3))*G2 - sdiag(gradR(:,2))*G3 ) ...
  + sdiag(cross(:,2))*( sdiag(gradR(:,1))*G3 - sdiag(gradR(:,3))*G1 ) ...
  + sdiag(cross(:,3))*( sdiag(gradR(:,2))*G1 - sdiag(gradR(:,1))*G2 )     );      
dr2 = -sdiag(1./(lR.*lT.^3)) * ...
     ( sdiag(gradT(:,1))*G1 + sdiag(gradT(:,2))*G2 + sdiag(gradT(:,3))*G3 );

dr    = (sdiag(r2)*dr1 + sdiag(r1)*dr2)*dT;
if ~isempty(mask),
  dr    = sdiag(mask(:))*dr;
end;

dD    = hd * rc' * dr;
d2psi = hd; 


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

