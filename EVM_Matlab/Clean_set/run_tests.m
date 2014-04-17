%This whole process takes a number of files that represent cuts from
%various videos in various formats and runs a number of algorithms through
%them. The process is timed and records the results locally and into a
%global file.

%Assign a run_id.
%This should probably be something like YYYYMMDDHHMM since I doubt this
%could run for less than a minute. 


%TO DO
run_id=get_run_id;

%Define the data directory.
%This is where the source data should be located as .mat
%files of different noise levels and RGB/BW.
dataDir = './data';


%Define the results directory.
%The results of this particular run would be stored here in a file with 
%run_id as its prefix.
%The results are also appended to the overall results file which is stored
%in the root folder.
resultsDir = './results';
%TO DO proper string concantenation
resultsFile= './results/run_id_result.mat';
overallResultsFile= 'Results.mat';


%Get the list of files in the data folder.
%Make sure that all the necessecary files are present.
%Throw an exception if they are not!
%Get a list of filenames.
%Get a list of videos that those files reference.
%A video in this context is the name of the particular cut plus the noise
%level.  
%TO DO


data_count=count_filenames;
check_files;
videos_count=data_count/3; % the number depends on the number of files per video
videos=struct(zeros, videos_count);
videos=get_videos;


%Loop for every video (not every file)!
%TO DO
for video = 1:n
  %Run MIT algorithm.
  %TO DO
  MIT_result=run_MIT(video);
  
  %Append the MIT results to the resulsts file, create it if empty.
  %Results should contain the run_in, algorthm name, video, noise level
  %(parced out separately) and the actual results.
  %TO DO

  savefile(MIT_result, resultsFile, append);
  
  %Run OMP algorithm.
  %TO DO
  OMP_result=run_OMP(video);
  
  %Append the OMP results to the resulsts file, create it if empty.
  %Results should contain the run_in, algorthm name, video, noise level
  %(parced out separately) and the actual results.
  %TO DO

  savefile(OMP_result, resultsFile, append);

  %Run JADE algorithm.
  %TO DO
  JADE_result=run_JADE(video);
  
  %Append the JADE results to the resulsts file, create it if empty.
  %Results should contain the run_in, algorthm name, video, noise level
  %(parced out separately) and the actual results.
  %TO DO

  savefile(JADE_result, resultsFile, append);
  
  %Run threshold algorithm.
  %TO DO
  threshold_result=run_threshold(video);
  
  %Append the threshold results to the resulsts file, create it if empty.
  %Results should contain the run_in, algorthm name, video, noise level
  %(parced out separately) and the actual results.
  %TO DO

  savefile(threshold_result, resultsFile, append);
end;

%The end results should be saved to the general results file for the
%simpler analysis.
%TO DO
savefile(MIT_result, overallResultsFile, append);
savefile(OMP_result, overallResultsFile, append);
savefile(JADE_result, overallResultsFile, append);
savefile(threshold_result, overallResultsFile, append);

