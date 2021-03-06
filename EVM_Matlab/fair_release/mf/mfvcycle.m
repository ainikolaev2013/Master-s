% function [u,res,r] = mfvcycle(para,u,rhs,tol,level,out)
%(C) 2008/07/31, Jan Modersitzki, see FAIR and FAIRcopyright.m.
%
% !! Multigrid, handle with care

function [u,res,r] = mfvcycle(para,u,rhs,tol,level,out)

omega = para.omega; m = para.m; h = (omega(2:2:end)-omega(1:2:end))./m;
MGcycle        = para.MGcycle;
para.MGcycle   = 1;
dimstr  = @(m) sprintf('[%s]',sprintf(' %d',m));

if ~isfield(para,'M'), para.M = 0;       end;

if level == para.MGlevel & out==1,
  fprintf('MG: ');
end;
if (level>1) & (min(m)==1)
  %if out, fprintf('grid %s --> coarse grid',dimstr(m)); end;
  level = 1;
end;

if out==1,
  fprintf('%d>',level);
end;

% -----------------------------------------------------------------------------
if level > 1,
  % ---------------------------------------------------------------------------
  % NOT on COARSE grid
  str = sprintf('  - grid %s',dimstr(m));
  
  % initialize
  r = rhs - mfAy(u,para);

  % -------------------------------------------------------------
  for i = 1:MGcycle, % loop over the V/W cycles
  % -------------------------------------------------------------
    n = length(r);
    if out>1,
      norm_r_in = norm(r)/n;
      fprintf('%20s |r-in|   = %e\n',str,norm_r_in);
    end;

    % pre-smoothing, exp: [u,r] Richardson(x,b,para,MGcycle)
    ur = feval(para.MGsmoother,0*r,r,para,para.MGpresmooth);
    u = u + ur; r = rhs - mfAy(u,para);

    if out>1,
      norm_r_pre = norm(r)/n;
      fprintf('%20s |r-pre|  = %e\n','',norm_r_pre);
    end;
    
    % PREPARE FOR COARSER GRID ------------------------------------------------
    M = para.M; 
    if ~(isempty(m) || all(size(M)==[1,1]) && M==0 )
      dm = full(diag(M));
      dm = mfPu(dm,para.omega,para.m,'PTu')/4;
      para.M = spdiags(dm,0,length(dm),length(dm));
    end;
    rc = mfPu(r,para.omega,para.m,'PTu')/4;
    para.m = m/2;

    % RECUSSIVE CALL -------------------------------------------------
    % Solve the coarse grid system
    uc = mfvcycle(para,0*rc,rc,1e-16,level-1,out);

    % prolongate, back to fine grid
    ur = mfPu(uc,para.omega,para.m,'Pu');
    
    
    para.m = m;
    para.h = h;        
    para.M = M;
    % ----------------------------------------------------------------
    
    % update
    u = u + ur;  r = rhs - mfAy(u,para);

    if out>0,
      norm_r_app = norm(r)/n;
    end;
    
    % post-smoothing 
    ur = feval(para.MGsmoother,0*r,r,para,para.MGpostsmooth);
    u = u + ur;  r = rhs - mfAy(u,para);
    
    if out==1,
      fprintf('<%d',level);
    elseif out>1,
      norm_r_post = norm(r)/n;
      
      fprintf('%20s |r-in|   = %e\n',str,norm_r_in);
      fprintf('%20s |r-pre|  = %e\n','',norm_r_pre);
      fprintf('%20s |r-app|  = %e\n','',norm_r_app);
      fprintf('%20s |r-post| = %e\n','',norm_r_post);
    end;
    
    if para.MGcycle > 2,
      fprintf('iter = %d,  |res| = %e\n',i,norm(r))
    end;
    res(i) = norm(r);
    if res(i) < tol, 
      resi = res(i);
      return; 
    end;
    
    if level == para.MGlevel && out  ~= 0,
      fprintf('>');
    end;
  end;

  % FINE GRID DONE
  % ---------------------------------------------------------------------------
else
  % ---------------------------------------------------------------------------  
  % COARSE grid
  str = sprintf('  - coarse grid %s',dimstr(m));
  norm_r_in = norm(rhs);

  if length(rhs)>100, error('rhs too big');  end;
  
  B = getElasticMatrixStg(para.omega,para.m,para.mu,para.lambda);

  A = para.M + para.alpha*prod(h)*B'*B;  
  u = pinv(full(A))*rhs;
  r = rhs - A*u;

  norm_r_out = norm(r);
  res = norm_r_out;
  if out==1,
    fprintf('coarse(%s)',dimstr(m));
  elseif out>1,
    fprintf('%20s |r-in|   = %e\n',str,norm_r_in);
    fprintf('%20s |r-out|  = %e\n',str,norm_r_out);
  end;
end;
% -----------------------------------------------------------------------------

if level == para.MGlevel & out>0,
  if out==1,
    fprintf('.\n');
  end;
 
  %testMG = norm(rhs - mfAy(u,para));
  %fprintf('MG:|rhs-Au(u)|=%12.4e\n',testMG)
end;

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
