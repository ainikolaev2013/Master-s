%$ Example for midpoint quadrature rule for 2D Gaussian
%$ (c) Jan Modersitzki 2009/03/24, see FAIR.2 and FAIRcopyright.m.
%$ note: '%$' is used so hide comments in the book                              
 
omega = [0,20,0,20]; h = zeros(10,1); Q = zeros(size(h));
I   = 1; % Note that I=1 is just an approximation to the integral!
psi = @(x1,x2) (1/(2*pi))*exp(-0.5*((x1-10).^2+(x2-10).^2));
for j=1:length(h),
  m    = 2^j*[1,1]; 
  h(j) = prod((omega(2:2:end)-omega(1:2:end))./m); 
  xc   = reshape(getCenteredGrid(omega,m),[m,2]); 
  Q(j) = h(j)*sum(sum(psi(xc(:,:,1),xc(:,:,2))));
end;
figure(1); clf; p1=semilogx(h/h(1),Q+eps,'kx',h/h(1),Q,'k-');
figure(2); clf; p2=loglog(h/h(1),abs(I-Q)+eps,'kx',h/h(1),abs(I-Q)+eps,'k-');
