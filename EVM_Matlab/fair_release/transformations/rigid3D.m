% function [y,dy] = rigid3D(w,x,varargin)
% (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
% computes y = Q*f(w) and the derivative wrt. w.
% x = reshape(x,[],3); 
% Q = [x(:,1),x(:,2),x(:,3),1, 0      0        0      0  0      0        0
%      0      0      0,     0, x(:,1),x(:,2,1),x(:,3),1, 0      0        0  
%      0      0      0,     0, 0      0        0      0, x(:,1),x(:,2,1),x(:,3),1]
% f(w) = combination of Euler angles and translation,
% dy = Q:
% if no argumanets are given, the parameters for the identity map are returned.

function [y,dy] = rigid3D(w,x,varargin)

persistent Q
y  = []; dy = [];
% if no input is given or ischar(w), y=[function name] and 
% dy=[parameterization of the identity map] are returned
if nargin == 0 || ischar(w), 
  y = mfilename('fullfile'); 
  dy = zeros(6,1);
  if nargin>0 && ischar(w), Q = []; end;
  return; 
end;
if isempty(w) || (size(Q,1) ~= numel(x)),
  x = reshape(x,[],3);
  Q = sparse(kron(speye(3),[x,ones(size(x,1),1)]));
  if nargout == 0, return; end;
end;

c  = cos(w(1:3)); s  = sin(w(1:3));

R3 = [ c(1),-s(1),    0; s(1), c(1),    0;    0,    0,    1];
R2 = [ c(2),    0, s(2);    0,    1,    0;-s(2),    0, c(2)];
R1 = [    1,    0,    0;    0, c(3),-s(3);    0, s(3), c(3)];
dR3 = [-s(1),-c(1),    0; c(1),-s(1),   0;    0,    0,    0];
dR2 = [-s(2),    0, c(2);    0,    0,   0;-c(2),    0,-s(2)];
dR1 = [    0,    0,    0;    0,-s(3),-c(3);   0, c(3),-s(3)];
f = [R3*R2*R1;reshape(w(4:6),1,3)]; f = f(:);

df = zeros(12,6);
df([1:3,5:7,9:11],:) = [reshape(dR3*R2*R1,9,1),reshape(R3*dR2*R1,9,1),...
  reshape(R3*R2*dR1,9,1),zeros(9,3)];
df([4,8,12],4:6) = eye(3);

y  = Q*f;
if nargout<2,   return;  end; % no derivative needed     
dy = Q*df;

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

