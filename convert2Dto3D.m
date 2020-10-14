function [out] = convert2Dto3D(X1,Y1,X2,Y2)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

c1 = vue2.position';
c2 = vue4.position';

R1 = vue2.Rmat;
R2 = vue4.Rmat;

K1 = vue2.Kmat;
K2 = vue4.Kmat;

for i = 1:12
    u1 = R1'*(inv(K1))*[X1(i) Y1(i) 1]';
    u2 = R2'*(inv(K2))*[X2(i) Y2(i) 1]';
    
    u1 = u1/norm(u1);
    u2 = u2/norm(u2);
    
    u3 = cross(u1,u2);
    u3 = u3/norm(u3);
    
    A = [u1 -u2 u3];
    B = c2 - c1;
    X = linsolve(A,B);
    
    P1 = c1 + X(1,1)*u1;
    P2 = c2 + X(2,1)*u2;
    
    P = (P1+P2)/2;
    
    out(i,:) = P';
end