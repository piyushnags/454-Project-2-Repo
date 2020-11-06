function plotEpipolar(X1,Y1,X2,Y2,mocapFnum)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2_updated.mp4';
filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4_updated.mp4';
vue2video = VideoReader(filenamevue2mp4);
vue4video = VideoReader(filenamevue4mp4);

[~,N] = size(X1);

camera2_position = vue2.position';
camera4_position = vue4.position';

Pmat1 = vue2.Pmat;
Pmat2 = vue4.Pmat;

% Plot epipolar lines from view of camera 2
% Get position of camera vue4 in camera vue2 system

cam4in2 = project3DTo2D(vue2, camera4_position);

vue2video.CurrentTime = (mocapFnum - 1)*(50/100)/vue2video.FrameRate;
vid2Frame = readFrame(vue2video);

figure(4); image(vid2Frame);

axis([0 1920 0 1088])
figure(4)
hold on
% Plot the joints in cyan
plot(X1,Y1,'c.','MarkerSize',25)

% Call findEpipolarLines to get equations for epipolar lines passing
% through all joints. Then iterate and plot all epipolar lines. Need to
% convert standard form equations to slope-intercept for plotting.
xlim = get(gca,'XLim');

color_array_1 = ['b-' 'g-' 'r-' 'c-' 'm-' 'y-' 'k-'];

[Ep1,Ep2] = findEpipolarLines(0,vue2,[X1;Y1],vue4,[X2;Y2]);

for i = 1:N
    
%   A,B,C are for standard form of line: Ax + By + C = 0
    A = Ep1(1,i);
    B = Ep1(2,i);
    C = Ep1(3,i);
%   Get equation in slope-intercept form to plot line
    m = -A/B;
    n = C/(cam4in2(1,1) - X1(i));
    y1 = m*xlim(1) + n;
    y2 = m*xlim(2) + n;
    hold on
    
    plot([xlim(1) xlim(2)],[y1 y2],color_array_1(mod(i,7)+1),'LineWidth',2)
    hold off
end

% Plot epipolar lines from view of camera 4
cam2in4 = project3DTo2D(vue4,camera2_position);

vue4video.CurrentTime = (mocapFnum - 1)*(50/100)/vue4video.FrameRate;
vid4Frame = readFrame(vue4video);

figure(5); image(vid4Frame);

figure(5)
hold on
% Plot joints
plot(X2,Y2,'c.','MarkerSize',25)
axis([0 1920 0 1088])

% Call findEpipolarLines to get equations for epipolar lines passing
% through all joints. Then iterate and plot all epipolar lines. Need to
% convert standard form equations to slope-intercept for plotting.

xlim = get(gca,'XLim');

for i = 1:N
    
%   A,B,C are for standard form of line: Ax + By + C = 0
    A = Ep2(1,i);
    B = Ep2(2,i);
    C = Ep2(3,i);
%   Get equation in slope-intercept form to plot line
    m = -A/B;
    n = C/(cam2in4(1,1) - X2(i));
    y1 = m*xlim(1) + n;
    y2 = m*xlim(2) + n;
    hold on
    
    plot([xlim(1) xlim(2)],[y1 y2],color_array_1(mod(i,7)+1),'LineWidth',2)
    hold off
end