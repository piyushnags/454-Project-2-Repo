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
cam4in2 = convert3Dto2D(camera4_position(1,1),camera4_position(2,1),camera4_position(3,1),1);

vue2video.CurrentTime = (mocapFnum - 1)*(50/100)/vue2video.FrameRate;
vid2Frame = readFrame(vue2video);

figure(4); image(vid2Frame);

axis([0 1920 0 1088])
figure(4)
hold on
% Plot the joints in cyan
plot(X1,Y1,'c.','MarkerSize',25)

% Plot epipolar lines for all N joints in coordinate set. For mocap dataset
% the number is 12. To plot epipolar lines (or any line), we need 2 points
% Here, we need the epipole i.e. cam4in2 and the joint (in X1,Y1 or X2,Y2)
% We use xlim so that we are able to plot lines that extend throughout the
% axis instead of plotting a line segment.
xlim = get(gca,'XLim');

color_array_1 = ['b-' 'g-' 'r-' 'c-' 'm-' 'y-' 'k-'];

for i = 1:N
    A = [X1(i) cam4in2(1,1)];
    B = [Y1(i) cam4in2(2,1)];
    m = (B(2)-B(1))/(A(2)-A(1));
    n = B(2) - A(2)*m;
    % Code to extend the line throughout the plot limits
    y1 = m*xlim(1) + n;
    y2 = m*xlim(2) + n;
    hold on
    
    plot([xlim(1) xlim(2)],[y1 y2],color_array_1(mod(i,7)+1),'LineWidth',2)
    hold off
end

% Plot epipolar lines from view of camera 4
cam2in4 = convert3Dto2D(camera2_position(1,1),camera2_position(2,1),camera2_position(3,1),2);

vue4video.CurrentTime = (mocapFnum - 1)*(50/100)/vue4video.FrameRate;
vid4Frame = readFrame(vue4video);

figure(5); image(vid4Frame);

figure(5)
hold on
% Plot joints
plot(X2,Y2,'c.','MarkerSize',25)
axis([0 1920 0 1088])

% Plot epipolar lines for all N joints in coordinate set. For mocap dataset
% the number is 12. To plot epipolar lines (or any line), we need 2 points
% Here, we need the epipole i.e. cam4in2 and the joint (in X1,Y1 or X2,Y2)
% We use xlim so that we are able to plot lines that extend throughout the
% axis instead of plotting a line segment.

xlim = get(gca,'XLim');

for i = 1:N
    A = [X2(i) cam2in4(1,1)];
    B = [Y2(i) cam2in4(2,1)];
    m = (B(2)-B(1))/(A(2)-A(1));
    n = B(2) - A(2)*m;
    % Code to extend the line throughout the plot limits
    y1 = m*xlim(1) + n;
    y2 = m*xlim(2) + n;
    hold on
    
    plot([xlim(1) xlim(2)],[y1 y2],color_array_1(mod(i,7)+1),'LineWidth',2)
    hold off
end
