function demo3()

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

% Get euclidean distance for all joint pairs in all frames with valid
% confidence values and store in list
list = euclidean_statistics(max_frame);

% Calculate mean, standard deviation, median, minimum, and maximum of
% euclidean distances for joints
for i = 1:12
    joint_mean(i) = mean(list(:,i));
    joint_std_dev(i) = std(list(:,i),1);
    joint_minimum(i) = min(list(:,i));
    joint_median(i) = median(list(:,i));
    joint_max(i) = max(list(:,i));
end

mean_all = mean(list,'all');
std_dev_all = std(list,1,'all');
min_all = min(list,[],'all');
median_all = median(list,'all');
max_all = max(list,[],'all');

% Plot sum of error for each frame
figure(7); 
figure(7)
[list_len,~] = size(list);
for i = 1:list_len
    hold on
    plot(i,sum(list(i,:)),'k.');
    hold off
end

