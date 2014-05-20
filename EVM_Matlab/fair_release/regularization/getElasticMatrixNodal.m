function B = getElasticMatrixNodal(omega,m,mu,lambda)
% (C) 2007/08/21, Jan Modersitzki, see FAIR.
% function B = getElasticMatrixNodal(omega,m,mu,lambda)
% Builds the elasticity matrix B for a domain defined by omega
% and a nodal grid discretization defined by m:
%     | a\nabla 0 0 | 
% B = | 0 a\nabla 0 |
%     | 0 0 a\nabla |
%     |   b \div    |,
% where \nabla and \div are weighted by a=\sqrt(mu) and b=\sqrt(\lambda+\mu),
% respectively; defaults: \mu = 1, \lambda = 0.
% Note: the matrices are simple, it is size that matters.

                                        % set defautls
if ~exist('mu','var'),     mu     = [];  end;
if ~exist('lambda','var'), lambda = [];  end;
if isempty(mu),     
  warning('mu has not yet been set! set mu=1');  
  mu = 1;  
end;
if isempty(lambda), 
  warning('lambda has not yet been set! lambda=0');  
  lambda = 0;  
end;

dim = length(omega)/2; 
h   = (omega(2:2:end)-omega(1:2:end))./m; % voxel size for integration
a   = sqrt(mu); 
b   = sqrt(mu+lambda);

% build the 2D elasticity operator
%
%      | a\nabla 0      |   |a D11  0     |
%  B = |                | = |a D12  0     |
%      | 0      a\nabla |   |0      a D21 |
%      |                |   |0      a D22 |
%      | b Div1 b Div2  |   |b D11  b D22 |

% Note: since the grid is nodal, dx(1) := D11 (= D21) and dx(2) := D12 (= D22)

dx = @(k) spdiags(ones(m(k),1)*[-1,1],0:1,m(k),m(k)+1)/h(k);
av = @(k) spdiags(ones(m(k),2)/2,0:1,m(k),m(k)+1);
  
D1   = kron(speye(m(2)+1),dx(1));  
D2   = kron(dx(2),speye(m(1)+1));
A1   = kron( av(2) , speye(m(1)));
A2   = kron( speye(m(2)),  av(1));

[p1,p2] = size(D1);

B = [  a*D1,sparse(p1,p2);
       a*D2,sparse(p1,p2);
       sparse(p1,p2),a*D1;
       sparse(p1,p2),a*D2;
       b*A1*D1,b*A2*D2    ];

     