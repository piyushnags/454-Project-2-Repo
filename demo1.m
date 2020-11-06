function demo1()
% This demo rotines shows that the convert2Dto3D and convert3Dto2D 
% functions perform correctly. We show the intermediate results of 2D and 
% 3D skeletons.

load 'Subject4-Session3-Take4_mocapJoints.mat'

[max_frame,~,~] = size(mocapJoints);

% Select a frame where the confidence value is 1 for all joints
for x = 5:max_frame
    conf_values = mocapJoints(x,:,4);
    a = min(conf_values,[],'all');
    if a == 1
        mocapFnum = x;
        break;
    end
end

% Call plot skeleton to demonstrate functionality of project3DTo2D and
% reconstruct3DFrom2D
plot_skeleton(mocapFnum);
