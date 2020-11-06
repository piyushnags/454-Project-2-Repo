function [out] = project3DTo2D(cam, worldCoord3DPoints)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

% % Option 1 is for vue2 camera
% if camera == 1
%     Pmat = vue2.Pmat;
%     Kmat = vue2.Kmat;
% % Option 2 (or any other) is for vue4 camera
% else
%     Pmat = vue4.Pmat;
%     Kmat = vue4.Kmat;
% end

Pmat = cam.Pmat;
Kmat = cam.Kmat;

X = worldCoord3DPoints(1,:);
Y = worldCoord3DPoints(2,:);
Z = worldCoord3DPoints(3,:);

[~,N] = size(X);

% For all 12 joints, apply world coordinates to pixel value equation
for i = 1:N
    W = [X(i) Y(i) Z(i) 1]';
    % Transfrmation equation to convert world coordinates to camera
    % cordinates
    Pl = Kmat*Pmat*W;
    out(1,i) = Pl(1,1)/Pl(3,1);
    out(2,i) = Pl(2,1)/Pl(3,1);
end
out(3,:) = 1;
