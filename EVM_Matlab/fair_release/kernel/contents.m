function contents
% (c) Jan Modersitzki 2009/04/02, see FAIR.2 and FAIRcopyright.m.
% FAIR kernel, contents.m: this file
%
% Armijo                  -> OPTIMIZATION    
% FAIRclear               -> ADMINISTRATIVE
% GaussNewtonArmijo       -> OPTIMIZATION
% LagPIRobjFctn           -> OPTIMIZATION
% MLIR                    -> MULTILEVEL
% MLPIR                   -> MULTILEVEL
% NPIRBFGSobjFctn         -> OPTIMIZATION
% NPIRobjFctn             -> OPTIMIZATION
% PIRBFGSobjFctn          -> OPTIMIZATION
% PIRobjFctn              -> OPTIMIZATION
% SteepestDescent         -> OPTIMIZATION
% TrustRegion             -> OPTIMIZATION
% center                  -> GRIDS
% checkDerivative         -> OPTIMIZATION
% getCenteredGrid         -> GRIDS
% getMultilevel           -> MULTILEVEL
% getNodalGrid            -> GRIDS
% getStaggeredGrid        -> GRIDS
% grid2grid               -> GRIDS
% lBFGS                   -> OPTIMIZATION
% nodal2center            -> GRIDS
% options                 -> ADMINISTRATIVE
% plotIterationHistory   -> OPTIMIZATION
% plotMLIterationHistory -> OPTIMIZATION
% reportStatus            -> ADMINISTRATIVE
% stg2array               -> GRIDS
% stg2center              -> GRIDS
% 
% ADMINISTRATIVE
%   options            handles options as used e.g. in inter, distances, ...
%   reportStatus       display the current configuration
%   FAIRclear          closes figures, clears shell and modules
% GRIDS (c=cell-centers, s=staggered, n=nodal)
%   center				transfers grids (c,s,n) to cell-centers (c)
%   getCenteredGrid		creates cell-centered grid
%   getNodalGrid        creates nodal grid
%   getStaggeredGrid    creates staggered grid
%   grid2grid           interpolates grid-in to grid-out 
%   nodal2center        transforms a nodal to cell-centered grid
%   stg2array           decomposed a staggered grid Y (n-by-1) into components
%   stg2center          supplies staggered to cell-centered grid operation
%
% MULTILEVEL:
%   MLIR				the MultiLevel Image Registration
%   MLPIR				the MultiLevel Parametric Image Registration
%   getMultilevel   	generates multilevel data struct for given data
%
% OPTIMIZATION
%   NPIRobjFctn         objective function for non-parametric image registration (Gauss-Newton style)
%   NPIRBFGSobjFctn     objective function for non-parametric image registration (BFGS style)
%   PIRobjFctn          objective function for     parametric image registration (Gauss-Newton style)
%   PIRBFGSobjFctn      objective function for     parametric image registration (BFGS style)
%   LagPIRobjFctn       objective function for     parametric image registration (Lagrangian style)
%   Armijo				Armijo Line Search
%   GaussNewtonArmijo   Gauss Newton Method with Armijo Line Search
%   lBFGS               limited memory BFGS with Armijo Line Search
%   SteepestDescent     Steepest Descent    with Armijo Line Search
%   TrustRegion         Trust Region methos
%   checkDerivative     checks the implementation of a derivative
%
% PLOTS:
% 	plotIterationHistory   plots iteration history (one level)
% 	plotMLIterationHistory plots iteration history (multi-level)
%
% see also BigTutorial2D and BigTutorial3D.
