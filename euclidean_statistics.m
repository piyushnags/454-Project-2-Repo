function [L2list] = euclidean_statistics(max_frame)

load 'Subject4-Session3-Take4_mocapJoints.mat'
load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

row = 1;

% Iterate through all frames of the video
for mocapFrame = 1:max_frame
    conf_values = mocapJoints(mocapFrame,:,4);
    a = min(conf_values,[],'all');
%   Skip frames that do nothave confidence value equal to 1 for all joints
    if a ~= 1
        continue;
    end
    
%   Read 3D data for current frame
    X = mocapJoints(mocapFrame,:,1);
    Y = mocapJoints(mocapFrame,:,2);
    Z = mocapJoints(mocapFrame,:,3);
    
%   Calculate pairs of corresponding 2D coordinates
    world3Dcoords(1,:) = X;
    world3Dcoords(2,:) = Y;
    world3Dcoords(3,:) = Z;
    
    vue2_2D = project3DTo2D(vue2, world3Dcoords);
    vue4_2D = project3DTo2D(vue4, world3Dcoords);
    
%   Reconstruct 3D coordinates using vue2_2D and vue4_2D
    out3D = reconstruct3DFrom2D(vue2,vue2_2D,vue4,vue4_2D);
    
%   Store euclidean disances (error in reconstruction) in L2list and return
    for i = 1:12
        L2list(row,i) = sqrt((X(i)-out3D(1,i))^2 + (Y(i)-out3D(2,i))^2 + (Z(i)-out3D(3,i))^2);
    end
    row = row + 1;
end

