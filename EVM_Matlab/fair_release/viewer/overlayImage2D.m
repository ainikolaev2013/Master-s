% =======================================================================================
% function ih = [i1,i2] = overlayImage2D(T,R,omega,m,varargin);
% (c) Jan Modersitzki 2008/07/29, see FAIR and FAIRcopyright.m.
%
% A 2D image viewer for overlaying images R and T
%
% Input:
%   T           discretized image
%   R           discretized image
%   omega		describing the domain
%	m 			number of discretization points
%   varargin    optional parameters like {'colorT','r'}
%
% Output:
%  i1,i2        image handles for T and R
% =======================================================================================

function [i1,i2] = overlayImage2D(T,R,omega,m,varargin);

colorT = [1,0,0];
colorR = [0,1,1];
scale  = 1;
alphadata = 0.5;

for k=1:2:length(varargin), % overwrites defaults
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

h  = (omega(2:2:end)-omega(1:2:end))./m;
xi = @(i) (omega(2*i-1)+h(i)/2:h(i):omega(2*i)-h(i)/2)';

if scale == 1,
  T = 255/max(T(:))*T;
  R = 255/max(R(:))*R;
end;

T = permute(reshape(uint8(T*colorT),[m,3]),[2,1,3]);
R = permute(reshape(uint8(R*colorR),[m,3]),[2,1,3]);

cla;
i1  = image(xi(1),xi(2),R); axis xy image; hold on;
i2  = image(xi(1),xi(2),T); axis xy image; hold off;
set(i2,'alphaData',alphadata);

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
