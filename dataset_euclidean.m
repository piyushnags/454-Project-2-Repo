function dataset_euclidean(dataset)

[max_frame,joint_total,~] = size(dataset);

row = 1;

for frame = 1:max_frame
    conf_values = dataset(frame,:,4);
    a = min(conf_values,[],'all');
    if (a ~= 1)
        continue;
    end
    
    X = dataset(frame,:,1);
    Y = dataset(frame,:,2);
    Z = dataset(frame,:,3);
    
    vue2_2D = convert3Dto2D(X,Y,Z,1);
    vue4_2D = convert3Dto2D(X,Y,Z,2);
    
    out3D = convert2Dto3D(vue2_2D(1,:), vue2_2D(2,:), vue4_2D(1,:), vue4_2D(2,:));
    
    for i = 1:joint_total
        list(row,i) = sqrt((X(i)-out3D(i,1))^2 + (Y(i)-out3D(i,2))^2 + (Z(i)-out3D(i,3))^2);
    end
    row = row + 1;
end

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


