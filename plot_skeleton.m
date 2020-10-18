function plot_skeleton(mocapFnum)

load 'Subject4-Session3-Take4_mocapJoints.mat'

X = mocapJoints(mocapFnum,:,1);
Y = mocapJoints(mocapFnum,:,2);
Z = mocapJoints(mocapFnum,:,3);

filenamevue2mp4 = 'Subject4-Session3-24form-Full-Take4-Vue2_updated.mp4';
filenamevue4mp4 = 'Subject4-Session3-24form-Full-Take4-Vue4_updated.mp4';
vue2video = VideoReader(filenamevue2mp4);
vue4video = VideoReader(filenamevue4mp4);

cam2_points = convert3Dto2D(X,Y,Z,1);
cam4_points = convert3Dto2D(X,Y,Z,2);

X1 = cam2_points(1,:);
Y1 = cam2_points(2,:);
X2 = cam4_points(1,:);
Y2 = cam4_points(2,:);

vue2video.CurrentTime = (mocapFnum - 1)*(50/100)/vue2video.FrameRate;
vid2Frame = readFrame(vue2video);

figure(4); image(vid2Frame);

axis([0 1920 0 1088])
figure(4)
hold on
plot(X1,Y1,'c.','MarkerSize',25)
plot([X1(1) X1(2)],[Y1(1) Y1(2)],'c-','LineWidth',2);
plot([X1(2) X1(3)],[Y1(2) Y1(3)],'c-','LineWidth',2);
plot([X1(4) X1(5)],[Y1(4) Y1(5)],'c-','LineWidth',2);
plot([X1(5) X1(6)],[Y1(5) Y1(6)],'c-','LineWidth',2);
plot([X1(7) X1(8)],[Y1(7) Y1(8)],'c-','LineWidth',2);
plot([X1(8) X1(9)],[Y1(8) Y1(9)],'c-','LineWidth',2);
plot([X1(10) X1(11)],[Y1(10) Y1(11)],'c-','LineWidth',2);
plot([X1(11) X1(12)],[Y1(11) Y1(12)],'c-','LineWidth',2);
plot([X1(1) X1(4)],[Y1(1) Y1(4)],'c-','LineWidth',2);
plot([X1(7) X1(10)],[Y1(7) Y1(10)],'c-','LineWidth',2);

spine_top = [(X1(1)+X1(4)) (Y1(1)+Y1(4))]/2;
spine_bottom = [(X1(7)+X1(10)) (Y1(7)+Y1(10))]/2;

plot([spine_top(1) spine_bottom(1)],[spine_top(2) spine_bottom(2)],'c-','LineWidth',2);

hold off

vue4video.CurrentTime = (mocapFnum - 1)*(50/100)/vue4video.FrameRate;
vid4Frame = readFrame(vue4video);

figure(5); image(vid4Frame);

axis([0 1920 0 1088])
figure(5)
hold on
plot(X2,Y2,'c.','MarkerSize',25)
plot([X2(1) X2(2)],[Y2(1) Y2(2)],'c-','LineWidth',1.5);
plot([X2(2) X2(3)],[Y2(2) Y2(3)],'c-','LineWidth',1.5);
plot([X2(4) X2(5)],[Y2(4) Y2(5)],'c-','LineWidth',1.5);
plot([X2(5) X2(6)],[Y2(5) Y2(6)],'c-','LineWidth',1.5);
plot([X2(7) X2(8)],[Y2(7) Y2(8)],'c-','LineWidth',1.5);
plot([X2(8) X2(9)],[Y2(8) Y2(9)],'c-','LineWidth',1.5);
plot([X2(10) X2(11)],[Y2(10) Y2(11)],'c-','LineWidth',1.5);
plot([X2(11) X2(12)],[Y2(11) Y2(12)],'c-','LineWidth',1.5);
plot([X2(1) X2(4)],[Y2(1) Y2(4)],'c-','LineWidth',1.5);
plot([X2(7) X2(10)],[Y2(7) Y2(10)],'c-','LineWidth',1.5);

spine_top_2 = [(X2(1)+X2(4)) (Y2(1)+Y2(4))]/2;
spine_bottom_2 = [(X2(7)+X2(10)) (Y2(7)+Y2(10))]/2;

plot([spine_top_2(1) spine_bottom_2(1)],[spine_top_2(2) spine_bottom_2(2)],'c-','LineWidth',1.5);

hold off

out3D = convert2Dto3D(X1,Y1,X2,Y2);

figure(6);
figure(6)
view(3)
hold on
plot3(X,Y,Z,'k.','MarkerSize',25)
plot3([X(1) X(2)],[Y(1) Y(2)],[Z(1) Z(2)],'k-','LineWidth',2);
plot3([X(2) X(3)],[Y(2) Y(3)],[Z(2) Z(3)],'k-','LineWidth',2);
plot3([X(4) X(5)],[Y(4) Y(5)],[Z(4) Z(5)],'k-','LineWidth',2);
plot3([X(5) X(6)],[Y(5) Y(6)],[Z(5) Z(6)],'k-','LineWidth',2);
plot3([X(7) X(8)],[Y(7) Y(8)],[Z(7) Z(8)],'k-','LineWidth',2);
plot3([X(8) X(9)],[Y(8) Y(9)],[Z(8) Z(9)],'k-','LineWidth',2);
plot3([X(10) X(11)],[Y(10) Y(11)],[Z(10) Z(11)],'k-','LineWidth',2);
plot3([X(11) X(12)],[Y(11) Y(12)],[Z(11) Z(12)],'k-','LineWidth',2);
plot3([X(1) X(4)],[Y(1) Y(4)],[Z(1) Z(4)],'k-','LineWidth',2);
plot3([X(7) X(10)],[Y(7) Y(10)],[Z(7) Z(10)],'k-','LineWidth',2);

spine_top_3 = [(X(1)+X(4)) (Y(1)+Y(4)) (Z(1)+Z(4))]/2;
spine_bottom_3 = [(X(7)+X(10)) (Y(7)+Y(10)) (Z(7)+Z(10))]/2;

plot3([spine_top_3(1) spine_bottom_3(1)],[spine_top_3(2) spine_bottom_3(2)],[spine_top_3(3) spine_bottom_3(3)],'k-','LineWidth',2);

hold off

figure(7);
figure(7)
view(3)
X3 = out3D(:,1);
Y3 = out3D(:,2);
Z3 = out3D(:,3);
hold on
plot3(X3,Y3,Z3,'r.','MarkerSize',25)
plot3([X3(1) X3(2)],[Y3(1) Y3(2)],[Z3(1) Z3(2)],'r-','LineWidth',2);
plot3([X3(2) X3(3)],[Y3(2) Y3(3)],[Z3(2) Z3(3)],'r-','LineWidth',2);
plot3([X3(4) X3(5)],[Y3(4) Y3(5)],[Z3(4) Z3(5)],'r-','LineWidth',2);
plot3([X3(5) X3(6)],[Y3(5) Y3(6)],[Z3(5) Z3(6)],'r-','LineWidth',2);
plot3([X3(7) X3(8)],[Y3(7) Y3(8)],[Z3(7) Z3(8)],'r-','LineWidth',2);
plot3([X3(8) X3(9)],[Y3(8) Y3(9)],[Z3(8) Z3(9)],'r-','LineWidth',2);
plot3([X3(10) X3(11)],[Y3(10) Y3(11)],[Z3(10) Z3(11)],'r-','LineWidth',2);
plot3([X3(11) X3(12)],[Y3(11) Y3(12)],[Z3(11) Z3(12)],'r-','LineWidth',2);
plot3([X3(1) X3(4)],[Y3(1) Y3(4)],[Z3(1) Z3(4)],'r-','LineWidth',2);
plot3([X3(7) X3(10)],[Y3(7) Y3(10)],[Z3(7) Z3(10)],'r-','LineWidth',2);

spine_top_3 = [(X3(1)+X3(4)) (Y3(1)+Y3(4)) (Z3(1)+Z3(4))]/2;
spine_bottom_3 = [(X3(7)+X3(10)) (Y3(7)+Y3(10)) (Z3(7)+Z3(10))]/2;

plot3([spine_top_3(1) spine_bottom_3(1)],[spine_top_3(2) spine_bottom_3(2)],[spine_top_3(3) spine_bottom_3(3)],'r-','LineWidth',2);
hold off