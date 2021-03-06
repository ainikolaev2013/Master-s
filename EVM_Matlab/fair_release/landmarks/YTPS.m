% =======================================================================================
% function [Y,Z,c] = YTPS(LM,X,varargin);
% (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
% Landmark Based Thin-Plate-Spline Transformation
% minimizes sum_{i} { ||Y^i(r_j)-t^i_j|| + theta*S(Y^i) } != min
% where t and r denote the landmarks in template and reference
%
% the solution is explicitly known:
%   y = sum_{j} lambda_j rho(|x-r_j|) + p1(x),
% where rho is the dimension dependent radial basis function and the coefficients 
% a of p1 and the lambda satisfy (A(j,k)=rho(|r_j,r_k|), C = [1,r])
% | A  C | * |lambda| = |t|
% | C' 0 |   |a     |   |0|
% =======================================================================================

function [Y,Z,c] = YTPS(LM,X,varargin);

% initialize parameters
theta = 0;                         
for k=1:2:length(varargin), % overwrite default parameter
  eval([varargin{k},'=varargin{',int2str(k+1),'};']);
end;

L   = size(LM,1);           % number of landmarks
dim = size(LM,2)/2;         % spacial dimension
t   = LM(:,1:dim);          % LM in template
r   = LM(:,dim+1:2*dim);    % LM in reference

% dimension dependent radial basis function
switch dim,
  case 2,  rho = @(r) r.^2.*log(r+(r==0));
  case 3,  rho = @(r) r;
end;

% set-up KKT system and solve it 
A = zeros(L);
for j=1:L, for k=1:j-1,
    A(j,k) = rho(norm(r(j,:)-r(k,:)));
end;       end;
A = A+A';
B = [ones(L,1),r];
KKT = [A+theta*eye(L),B;B',zeros(dim+1)];
c = KKT\[t;zeros(dim+1,dim)];

% evalute Y = y(X)=sum c(k)*rho(|X-r_k|)+p1(X), on grid
% evalute Z = y(r)=sum c(k)*rho(|r-r_k|)+p1(r), on landmarks
% allocate memory
X = reshape(X,[],dim); Y = zeros(size(X)); Z = zeros(L,dim);

% evaluate polynomial part
for i=1:dim,
  Y(:,i) = c(L+1,i)+X*c(L+2:end,i);
  Z(:,i) = c(L+1,i)+r*c(L+2:end,i);
end;

% norm(X-r_j) in compact vectorized version
rad = @(X,j) sqrt(sum((X-ones(size(X))*diag(r(j,:))).^2,2));

% adding radial basis functions one-by-one
for j=1:L,
  for i=1:dim,
    Y(:,i) = Y(:,i) + c(j,i)*rho(rad(X,j));
    Z(:,i) = Z(:,i) + c(j,i)*rho(rad(r,j));
  end;    
end;

% re-organize output
Y = Y(:);
Z = Z(:);

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
