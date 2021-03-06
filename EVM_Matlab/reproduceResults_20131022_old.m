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
dataDir = './data';
resultsDir = 'ain_results-20131022_old';

addpath(genpath('./ain'));

mkdir(resultsDir);

filename = {'stabilized_4068', 'stabilized_4518', 'stabilized_4519', '1', 'drawing'};

%% vanilla
for i=size(filename,1):size(filename,2)
inFile = fullfile(dataDir, [filename{i} '.avi']);
fprintf('Processing %s\n', inFile);
amplify_spatial_Gdown_temporal_ideal_ain(inFile,resultsDir,50,4, ...
                     50/60,60/60,30, 1);
end;

%% noblur the way I do it
for i=size(filename,1):size(filename,2)
inFile = fullfile(dataDir, [filename{i} '.avi']);
fprintf('Processing %s\n', inFile);
amplify_spatial_Gdown_temporal_ideal_noblur(inFile,resultsDir,50,4, ...
                     50/60,60/60,30, 1);
end;

%% no IB the way I do it
for i=size(filename,1):size(filename,2)
inFile = fullfile(dataDir, [filename{i} '.avi']);
fprintf('Processing %s\n', inFile);
amplify_spatial_Gdown_temporal_ideal_noIB(inFile,resultsDir,50,4, ...
                     50/60,60/60,30, 1);
end;

%% no IB no blur the way I do it
for i=size(filename,1):size(filename,2)
inFile = fullfile(dataDir, [filename{i} '.avi']);
fprintf('Processing %s\n', inFile);
amplify_spatial_Gdown_temporal_ideal_noIB_noblur(inFile,resultsDir,50,4, ...
                     50/60,60/60,30, 1);
end;