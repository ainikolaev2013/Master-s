
function [Jc,para,dJ,H] = LagPIRobjFctn(Tc,R,omega,m,beta,M,wRef,xc,wc)

% if wc is not an input argument, reports status
if ~exist('wc','var') || isempty(wc),
  % report current settings
  if nargout == 1, Jc = 'PIR';  return; end;
  dimstr  = @(m) sprintf('[%s]',sprintf(' %d',m));
  wc      = trafo('w0');
  fprintf('Parametric Image Registration:');
  fprintf('    J(wc)=D(T,R(y(wc))) + (wc-wRef)''*M*(wc-wRef) != min\n');
  fprintf('  %20s : %s\n','m',dimstr(m));
  fprintf('  %20s : %s\n','omega',dimstr(omega));
  fprintf('  %20s : %s\n','INTERPOLATION',inter);
  fprintf('  %20s : %s\n','DISTANCE',distance);
  fprintf('  %20s : %s\n','TRAFO',trafo);
  fprintf('  %20s : %s\n','length(wc)',num2str(length(wc)));
%   if ~isempty(M),
    fprintf('  %20s : %s\n','M',sprintf('is %d-by-%d',size(M)));
%   end;
  fprintf('  %20s : %s\n','beta',num2str(beta)); 
  Jc = wc; % return starting guess
  return;
end;

% do the work ------------------------------------------------------------
doDerivative = (nargout>2);            % flag for necessity of derivatives

% compute transformation, distance, and regularization and combine these
[yc,dy] = trafo(wc,xc,'doDerivative',doDerivative);
[Rc,dR] = inter(R,omega,yc,'doDerivative',doDerivative);
[Dc,rc,dD,dr,d2psi] = distance(Tc,Rc,omega,m,'doDerivative',doDerivative);

% add regularization
if isempty(M) || (all(size(M)==1) && (M==0)),
  Sc  = 0;
  dS  = 0;
  M   = 0;
else
  dS  = (wc-wRef)'*M;
  Sc  = 0.5*dS*(wc-wRef);
end;


Jc = Dc + Sc;                           

% collect variables for plots
para = struct('Tc',Tc,'Rc',Rc,'omega',omega,'m',m,'yc',yc,'Jc',Jc);

if ~doDerivative, return; end;
dD = -dD * dR; dr = -dr*dR;      % multiply outer and inner derivatives
if size(dD,2) == size(dy,1),     % generic case, dy comes complete
  dJ = dD*dy + dS; dr = dr*dy;   
else                             % tricky case,  dy comes sparse
  n  = size(dy{1},1);
  dJ = reshape(dy{1}'*reshape(dD*dT,n,[]),1,[]) + dS;
  dr = [dr(:,1:n)*dy{1},dr(:,n+1:2*n)*dy{1},dr(:,2*n+1:3*n)*dy{1}];
end;
if nargout<4, return; end;

% approximation to Hessian
H   = dr'*d2psi*dr + M + beta*speye(length(wc));    

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

