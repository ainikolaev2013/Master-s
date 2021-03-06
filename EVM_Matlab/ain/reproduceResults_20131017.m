% Generates all the results for the SIGGRAPH paper at:
% http://people.csail.mit.edu/mrub/vidmag
%
% Copyright (c) 2011-2012 Massachusetts Institute of Technology, 
% Quanta Research Cambridge, Inc.
%
% Authors: Hao-yu Wu, Michael Rubinstein, Eugene Shih
% License: Please refer to the LICENCE file
% Date: June 2012
%

clear;
global cur_file;
dataDir = './data';
resultsDir = 'ain_results-20131017';

addpath(genpath('./ain'));

mkdir(resultsDir);

filename = {'stabilized_4068', 'stabilized_4518', 'stabilized_4519'};

%% vanilla
for i=1:3 
inFile = fullfile(dataDir, [filename{i} '.avi']);
cur_file=filename{i};
fprintf('Processing %s\n', inFile);
ain_pick_a_square(inFile, resultsDir, 144, 159, 144, 159);
end;
