function [out] = project3DTo2D(cam, worldCoord3DPoints)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

% Load Intrinsic and Extrinsic parameters
Pmat = cam.Pmat;
Kmat = cam.Kmat;

% Store 3D world coordinates in X,Y,and Z
X = worldCoord3DPoints(1,:);
Y = worldCoord3DPoints(2,:);
Z = worldCoord3DPoints(3,:);

[~,N] = size(X);

% For all 12 joints, apply world coordinates to pixel value equation
for i = 1:N
    W = [X(i) Y(i) Z(i) 1]';
    % Transformation equation to convert world coordinates to camera
    % cordinates
    Pl = Kmat*Pmat*W;
    out(1,i) = Pl(1,1)/Pl(3,1);
    out(2,i) = Pl(2,1)/Pl(3,1);
end
% Make result homogenous
out(3,:) = 1;
