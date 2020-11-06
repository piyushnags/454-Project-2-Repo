clear;

% Turn on profiler to test performance
profile ON

% Call demo functions

% demo1 shows the functionality of the 3dto2D projection and 3d
% reconstruction functions by plotting 2D skeletons and 3D skeletons
% overlayed on inputs. 
demo1();

% demo2 shows the functionality of the epipolar lines functions. It
% displays the plot of epipolar lines over frames of videos taken from both
% cameras
demo2();

% demo3 shows the error associated with the reconstruction process and
% calculates statistics for the dataset
demo3();

profile OFF
profile viewer