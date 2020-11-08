function [recovered3DPoints] = reconstruct3DFrom2D(cam1, cam1PixelCoords, cam2, cam2PixelCoords)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

X1 = cam1PixelCoords(1,:);
Y1 = cam1PixelCoords(2,:);
X2 = cam2PixelCoords(1,:);
Y2 = cam2PixelCoords(2,:);

% Get size, X1,Y1,etc. should be 1xN size
[~,N] = size(X1);

% Camera position in world coordinates
c1 = cam1.position';
c2 = cam2.position';

% Read extrinsic and intrinsic parameters
R1 = cam1.Rmat;
R2 = cam2.Rmat;

K1 = cam1.Kmat;
K2 = cam2.Kmat;

% Write X into 1st row and Y into 2nd row
for i = 1:N
    
    % Get u1, u2, u3 unit vectors using equation given in slides
    u1 = R1'*(inv(K1))*[X1(i) Y1(i) 1]';
    u2 = R2'*(inv(K2))*[X2(i) Y2(i) 1]';
    
    u1 = u1/norm(u1);
    u2 = u2/norm(u2);
    
    u3 = cross(u1,u2);
    u3 = u3/norm(u3);
    
    % Use linsolve to linear equation in 3 variables for the coefficients
    % a,b, and d.
    A = [u1 -u2 u3];
    B = c2 - c1;
    X = linsolve(A,B);
    
    P1 = c1 + X(1,1)*u1;
    P2 = c2 + X(2,1)*u2;
    
    % Final point is midpoint
    P = (P1+P2)/2;
    
    recovered3DPoints(:,i) = P;
end