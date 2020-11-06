function demo2()

load 'Subject4-Session3-Take4_mocapJoints.mat'
load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

[max_frame,~,~] = size(mocapJoints);

% Choose another frame for displaying epipolar lines
for i = 500:max_frame
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

% Pass coordinate array to project3DTo2D function to convert the 12 3-D
% joint coordinates to 2-D pixel coordinates (for both cameras).
world3Dcoords(1,:) = X;
world3Dcoords(2,:) = Y;
world3Dcoords(3,:) = Z;

vue2_2D = project3DTo2D(vue2, world3Dcoords);
vue4_2D = project3DTo2D(vue4, world3Dcoords);

% Plot epipolar lines using pairs of coordinates
plotEpipolar(vue2_2D(1,:),vue2_2D(2,:),vue4_2D(1,:),vue4_2D(2,:),mocapFnum2);

