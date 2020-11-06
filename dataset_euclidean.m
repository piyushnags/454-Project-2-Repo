function dataset_euclidean(dataset)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

[max_frame,joint_total,~] = size(dataset);

row = 1;

% Iterate through all frames of the video
for frame = 1:max_frame
    conf_values = dataset(frame,:,4);
    a = min(conf_values,[],'all');
%   Skip frames that do nothave confidence value equal to 1 for all joints
    if (a ~= 1)
        continue;
    end

%   Read 3D data for current frame
    X = dataset(frame,:,1);
    Y = dataset(frame,:,2);
    Z = dataset(frame,:,3);
   
%   Calculate pairs of corresponding 2D coordinates
    world3Dcoords(1,:) = X;
    world3Dcoords(2,:) = Y;
    world3Dcoords(3,:) = Z;
    
%   Reconstruct 3D coordinates using vue2_2D and vue4_2D
    vue2_2D = project3DTo2D(vue2, world3Dcoords);
    vue4_2D = project3DTo2D(vue4, world3Dcoords);
    
    out3D = reconstruct3DFrom2D(vue2,vue2_2D,vue4,vue4_2D);
    
%   Store euclidean disances (error in reconstruction) in list
    for i = 1:joint_total
        list(row,i) = sqrt((X(i)-out3D(1,i))^2 + (Y(i)-out3D(2,i))^2 + (Z(i)-out3D(3,i))^2);
    end
    row = row + 1;
end

% Calculate error statistics and output them
for i = 1:joint_total
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

% Print statistics calculated above
fprintf("The following are the L^2 statistics for each of the joint pairs over the entire time sequence (x 10^(-12))\n");
fprintf("Mean      Std. Deviation      Minimum           Median        Max\n");
for i = 1:12
    fprintf("%f\t%f\t%f\t%f\t%f\n", (10^(12))*joint_mean(i), (10^(12))*joint_std_dev(i), (10^(12))*joint_minimum(i), (10^(12))*joint_median(i), (10^(12))*joint_max(i));
end

fprintf("The following are the L^2 statistics for ALL joint pairs over the entire time sequence (x 10^(-12))\n");
fprintf("Mean      Std. Deviation      Minimum           Median        Max\n");
fprintf("%f\t%f\t%f\t%f\t%f\n", (10^(12))*mean_all, (10^(12))*std_dev_all, (10^(12))*min_all, (10^(12))*median_all, (10^(12))*max_all);




