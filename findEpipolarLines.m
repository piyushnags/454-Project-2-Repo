function [EpipolarLines1,EpipolarLines2] = findEpipolarLines(worldCoord3DPoints, cam1, cam1PixelCoords, cam2, cam2PixelCoords)

% 2D Projected pixel coords
X1 = cam1PixelCoords(1,:);
Y1 = cam1PixelCoords(2,:);
X2 = cam2PixelCoords(1,:);
Y2 = cam2PixelCoords(2,:);

% Determine number of epipolar lines required
[~,N] = size(cam1PixelCoords);

cam2_position = cam1.position';
cam4_position = cam2.position';

% Get camera position in each other's coordinate system
% In other words, determine epipole location
cam4in2 = project3DTo2D(cam1,cam4_position);
cam2in4 = project3DTo2D(cam2,cam2_position);

% First, plot epipolar lines for image seen by camera 2
% Plot a line between 2 points. One point is the epipole, and the 
% other point is one of N joints from dataset
for i = 1:N
    x1 = X1(i);
    x2 = cam4in2(1,1);
    y1 = Y1(i);
    y2 = cam4in2(2,1);
    
    A = y2-y1;
    B = x1-x2;
    C = y1*(x2-x1) - (y2-y1)*(x1);
    
    EpipolarLines1(:,i) = [A B C]';
end

% Then, plot epipolar lines for image seen by camera 4 using above
% procedure. Epipole will be camera 2 as seen by camera 4.
% Results stored as a column vector [A B C]' where Ax + By + C = 0
for i = 1:N
    x1 = X2(i);
    x2 = cam2in4(1,1);
    y1 = Y2(i);
    y2 = cam2in4(2,1);
    
    A = y2-y1;
    B = x1-x2;
    C = y1*(x2-x1) - (y2-y1)*(x1);
    
    EpipolarLines2(:,i) = [A B C]';
end