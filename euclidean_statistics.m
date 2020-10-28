function [L2list] = euclidean_statistics(max_frame)

load 'Subject4-Session3-Take4_mocapJoints.mat'

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
    vue2_2D = convert3Dto2D(X,Y,Z,1);
    vue4_2D = convert3Dto2D(X,Y,Z,2);
    
%   Reconstruct 3D coordinates using vue2_2D and vue4_2D
    out3D = convert2Dto3D(vue2_2D(1,:),vue2_2D(2,:),vue4_2D(1,:),vue4_2D(2,:));
    
%   Store euclidean disances (error in reconstruction) in L2list and return
    for i = 1:12
        L2list(row,i) = sqrt((X(i)-out3D(i,1))^2 + (Y(i)-out3D(i,2))^2 + (Z(i)-out3D(i,3))^2);
    end
    row = row + 1;
end

