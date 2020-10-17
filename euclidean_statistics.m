function [L2list] = euclidean_statistics(max_frame)

load 'Subject4-Session3-Take4_mocapJoints.mat'

row = 1;

for mocapFrame = 1:max_frame
    conf_values = mocapJoints(mocapFrame,:,4);
    a = min(conf_values,[],'all');
    if a ~= 1
        continue;
    end
    
    X = mocapJoints(mocapFrame,:,1);
    Y = mocapJoints(mocapFrame,:,2);
    Z = mocapJoints(mocapFrame,:,3);
    
    vue2_2D = convert3Dto2D(X,Y,Z,1);
    vue4_2D = convert3Dto2D(X,Y,Z,2);
    
    out3D = convert2Dto3D(vue2_2D(1,:),vue2_2D(2,:),vue4_2D(1,:),vue4_2D(2,:));
    
    for i = 1:12
        L2list(row,i) = sqrt((X(i)-out3D(i,1))^2 + (Y(i)-out3D(i,2))^2 + (Z(i)-out3D(i,3))^2);
    end
    row = row + 1;
end

