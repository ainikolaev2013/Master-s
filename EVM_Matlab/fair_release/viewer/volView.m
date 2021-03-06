% =======================================================================================
% function ih = volView(I,omega,m,varargin)
% (c) Jan Modersitzki 2008/07/29, see FAIR and FAIRcopyright.m.
%
% 3D image viewer, basically calls patch.m with the approprixate x1,x2,x3
%
% Input:
%   T           discretized image
%   omega		describing the domain
%	m 			number of discretization points
%   varargin    optional parameters like {'isovalue',100}
%
% Output:
%  ih			image handle
% =======================================================================================

function p = volView(I,omega,m,varargin)

% set default parameter
isovalue    = 0;
view        = [-37.5,30];
facecolor   = .75*[1,1,1];
facealpha   = .8;

for k=1:2:length(varargin), % overwrite default parameter
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

if nargin < 3, m     = size(I);         end;
if nargin < 2, omega = ones(size(m));   end;

% reshape I
I = reshape(I,m);

% threshold I
I(I<isovalue) = 0;

% prepare geometry
h  = (omega(2:2:end)-omega(1:2:end))./m;
xi = @(i) (omega(2*i-1)+h(i)/2:h(i):omega(2*i)-h(i)/2)';
[x1,x2,x3] = ndgrid(xi(1),xi(2),xi(3));

cla; 
p(1) = patch(isosurface(x1,x2,x3,I,isovalue));
p(2) = patch(isocaps(x1,x2,x3,I,isovalue),'FaceColor','interp');

set(p(1),...
  'FaceColor',facecolor,...
  'EdgeColor','none',...
  'FaceAlpha',facealpha);

set(p(2),...
  'EdgeColor','none',...
  'FaceAlpha',facealpha);

isonormals(I,p(1));

% make view nice
changeView(view);
axis equal vis3d xy
axis(omega);
camlight(40, 40);
camlight(-20,-10);
lighting gouraud
drawnow

function changeView(v); view(v);

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
