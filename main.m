clear;

load 'Subject4-Session3-Take4_mocapJoints.mat'

%filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2.mp4';
%vue2video = VideoReader(filenamevue2mp4);

% Select a frame where the confidence value is 1 for all joints
for x = 5:30000
    conf_values = mocapJoints(x,:,4);
    a = min(conf_values,[],'all');
    if a == 1
        mocapFnum = x;
        break;
    end
end

%vue2video.CurrentTime = (mocapFnum - 1)*(50/100)/vue2video.FrameRate;
%vid2Frame = readFrame(vue2video);

%image(vid2Frame);

% Convert 3-D World coordinates of mocapFnum to 2-D Pixel values
% First, get x,y,z coordinates of all 12 joints
X = mocapJoints(mocapFnum,:,1);
Y = mocapJoints(mocapFnum,:,2);
Z = mocapJoints(mocapFnum,:,3);

% Pass coordinate array to convert3Dto2D function to convert the 12 3-D
% joint coordinates to 2-D pixel coordinates (for both cameras).
vue2_2D = convert3Dto2D(X,Y,Z,1);
vue4_2D = convert3Dto2D(X,Y,Z,2);

% Use pairs of 2-D coordinates to generate 3-D coordinates
out3D = convert2Dto3D(vue2_2D(1,:),vue2_2D(2,:),vue4_2D(1,:),vue4_2D(2,:));

% List of euclidean distances between original and generated points
for i = 1:12
    L2list(i) = sqrt((X(i)-out3D(i,1))^2 + (Y(i)-out3D(i,2))^2 + (Z(i)-out3D(i,3))^2);
end

% Choose another frame for displaying epipolar lines
for i = 500:30000
    conf_values = mocapJoints(i,:,4);
    a = min(conf_values,[],'all');
    if a == 1
        mocapFnum2 = i;
        break;
    end
end

% Convert 3-D World coordinates of mocapFnum to 2-D Pixel values
% First, get x,y,z coordinates of all 12 joints
X = mocapJoints(mocapFnum2,:,1);
Y = mocapJoints(mocapFnum2,:,2);
Z = mocapJoints(mocapFnum2,:,3);

% Pass coordinate array to convert3Dto2D function to convert the 12 3-D
% joint coordinates to 2-D pixel coordinates (for both cameras).
vue2_2D = convert3Dto2D(X,Y,Z,1);
vue4_2D = convert3Dto2D(X,Y,Z,2);

% Plot epipolar lines using pairs of coordinates
plotEpipolar(vue2_2D(1,:),vue2_2D(2,:),vue4_2D(1,:),vue4_2D(2,:));

%vue2video.CurrentTime = (mocapFnum2 - 1)*(50/100)/vue2video.FrameRate;
%vid2Frame = readFrame(vue2video);

%image(vid2Frame);
