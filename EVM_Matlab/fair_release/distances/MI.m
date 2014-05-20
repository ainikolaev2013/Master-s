function [Dc,rho,dD,drho,d2psi] = MI(Tc,Rc,omega,m,varargin);
% This is a link to MIcc, the most efficient implementation of Mutual Information
[Dc,rho,dD,drho,d2psi] = MIcc(Tc,Rc,omega,m,varargin{:});
