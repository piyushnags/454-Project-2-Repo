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
out1 = convert3Dto2D(X,Y,Z,1);
out2 = convert3Dto2D(X,Y,Z,2);

out3 = convert2Dto3D(out1(1,:),out1(2,:),out2(1,:),out2(2,:));
