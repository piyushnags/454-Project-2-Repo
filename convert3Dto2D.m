function [out] = convert3Dto2D(X,Y,Z)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

Pmat = vue2.Pmat;
Kmat = vue2.Kmat;

for i = 1:12
    W = [X(i) Y(i) Z(i) 1]';
    Pl = Kmat*Pmat*W;
    out(1,i) = Pl(1,1)/Pl(3,1);
    out(2,i) = Pl(2,1)/Pl(3,1);
end

