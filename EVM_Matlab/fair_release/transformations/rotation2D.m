% function [y,dy] = rotation2D(w,x,varargin)
% (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
% computes y = Q*f(w) and the derivative wrt. w.
% x = reshape(x,[],3); 
% Q = [x(:,1),x(:,2),1, 0      0        0
%      0      0      0, x(:,1),x(:,2,1),1]
% f(w) = codes a rotation around c
% dy = Q:
% if no argumanets are given, the parameters for the identity map are returned.

function [y,dy] = rotation2D(w,x,varargin)

persistent Q 
y  = []; dy = [];
if nargin == 0 || ischar(w), 
  y = mfilename('fullfile'); dy = 0;
  if nargin>0 && ischar(w), Q = []; end;
  return;
end;
% if no input is given or ischar(w), y=[function name] and 
% dy=[parameterization of the identity map] are returned
if isempty(w) || (size(Q,1) ~= numel(x)),
  n = length(x)/2; x = reshape(x,n,2);
  Q = [x,ones(n,1),sparse(n,3);sparse(n,3),x,ones(n,1)];
end;
c = zeros(2,1);
for k=1:2:length(varargin), % overwrites default parameter
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

if isempty(Q), feval(mfilename,w,x);  end;
R  = [ cos(w(1)),-sin(w(1));sin(w(1)),cos(w(1))];
g  = (eye(2)-R)*reshape(c,2,1);
f  = [R(1,1);R(1,2);g(1);R(2,1);R(2,2);g(2)];
y  = Q*f;
if nargout<2,   return;  end; % no derivative needed     
dR = [-sin(w(1)),-cos(w(1));cos(w(1)),-sin(w(1))];
dg = -dR*reshape(c,[],1);
df = [dR(1,1);dR(1,2);dg(1);dR(2,1);dR(2,2);dg(2)];
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

