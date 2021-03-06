    function Tc = splineInterpolation2D(T,omega,X);
%$  function Tc = splineInterpolation2D(T,omega,X);
%$ (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
%$ note: '%$' is used so hide comments in the book                              

% get dimensions m, cell size h, and number n of interpolation points
m  = size(T); h = omega./m; d = length(omega); n = length(X)/d;                          % 
X  = reshape(X,n,d)*diag(1./h) + 0.5;     % map X from [h/2,omega-h/2] -> [1,m],
Tc = zeros(n,1);                          % initialize output
Valid = @(j) (0<X(:,j) & X(:,j)<m(j)+1);  % determine indices of valid points
valid = find( Valid(1) & Valid(2) );                
if isempty(valid), return; end;
                                          % pad data to reduce cases
pad = 3; TP = zeros(m+2*pad); TP(pad+(1:m(1)),pad+(1:m(2))) = T;
P = floor(X); X = X-P;                    % split X into integer/remainder
p = @(j) P(valid,j); xi = @(j) X(valid,j);
i1 = 1; i2 = size(TP,1);                  % increments for linearized ordering
p  = (pad + p(1)) + i2*(pad + p(2) - 1);


for j1=-1:2,                              % Tc as weighted sum
  for j2=-1:2,
    Tc(valid) = Tc(valid) + TP(p+j1*i1+j2*i2).*b0(j1,xi(1)).*b0(j2,xi(2));
  end;
end;

function b = b0(j,xi)
switch j,
  case -1, b = (1-xi).^3;
  case 0,  b = -2*(1-xi).^3+xi.^3+6*(1-xi);
  case 1,  b = (1-xi).^3-2*xi.^3+6*xi;
  case 2,  b =  xi.^3;
end;

function b = db0(j,xi)
switch j,
  case -1, b = -3*(1-xi).^2;
  case 0,  b =  6*(1-xi).^2+3*xi.^2-6;
  case 1,  b = -3*(1-xi).^2-6*xi.^2+6;
  case 2,  b =  3*xi.^2;
end;
