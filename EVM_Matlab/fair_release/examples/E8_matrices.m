% Tutorial for regularization
% (c) Jan Modersitzki 2009/04/07, see FAIR.2 and FAIRcopyright.m.
%
% illustrates the tools for L2-norm based regularization
%
%  S(y) = alpha/2 * norm(B*(y-yRef)^2,
%
% where
%  alpha regularization parameter, weights regularization versus 
%        distance in the joint objective function, alpha = 1 here
%  yRef  is a reference configuration, e.g. yRef = x or a 
%        pre-registration result
%  B     a discrete partial differential operator either in explicit
%        matrix form or as a structure containing the necessary
%        parameters to compute B*y, see also mfBy.m
%
% - set parameters


                    % 2D example
omega  = [0,1,0,1]; % physical domin
m      = [16,12];   % number of discretization points
mu     = 1;         % Lame constants, control elasticity properties
lambda = 0;         % Youngs modulus and Poisson ratio
n      = prod(m);   % number of cells, and staggered dimensions
ns     = [(m(1)+1)*m(2),m(1)*(m(2)+1)];

% build elasticity operator on a staggered grid and visualize
B = getElasticMatrixStg(omega,m,mu,lambda);

% prepare the matrix free code
para = struct('regularizer','mfElastic',...
  'omega',omega,'m',m,'mu',mu,'lambda',lambda)

% note: B*y can also be computed without storing B
%       the following loop computes A(:,j) + mfBy(e(j)),
%       where mfBy is the matrix free operation B*y
%       and e(j) is the j-th unit vector;
%       hence A == B, (neither A nor B need to be stored)
e = @(j) ((1:size(B,2))' == j); % j-th unit vector
A = sparse(size(B,1),size(B,2));
for j=1:size(B,2), A(:,j) = mfBy(e(j),para); end;

% now the transpose
e = @(j) ((1:size(B,1))' == j); % j-th unit vector
C = sparse(size(B,2),size(B,1));
for j=1:size(B,1), C(:,j) = mfBy(e(j),para,'BTy'); end;

FAIRfigure(1); clf; 
subplot(2,3,1); spy(B);    title('B =elastic operator on staggered grid')
subplot(2,3,2); spy(A);    title('B from mfBy');
subplot(2,3,3); spy(B-A);  title('difference |B-mfBy()|');
subplot(2,3,4); spy(B');   title('B''')
subplot(2,3,5); spy(C);    title('B'' from mfBy');
subplot(2,3,6); spy(B'-C); title('difference |B''-mfBy(...,''BTy'')|');
