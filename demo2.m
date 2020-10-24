function demo2()

load 'Subject4-Session3-Take4_mocapJoints.mat'

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

% Pass coordinate array to convert3Dto2D function to convert the 12 3-D
% joint coordinates to 2-D pixel coordinates (for both cameras).
vue2_2D = convert3Dto2D(X,Y,Z,1);
vue4_2D = convert3Dto2D(X,Y,Z,2);

% Plot epipolar lines using pairs of coordinates
plotEpipolar(vue2_2D(1,:),vue2_2D(2,:),vue4_2D(1,:),vue4_2D(2,:),mocapFnum2);

