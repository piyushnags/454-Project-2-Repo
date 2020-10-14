function [out] = convert3Dto2D(X,Y,Z,camera)

load 'vue2CalibInfo.mat'
load 'vue4CalibInfo.mat'

if camera == 1
    Pmat = vue2.Pmat;
    Kmat = vue2.Kmat;
else
    Pmat = vue4.Pmat;
    Kmat = vue4.Kmat;
end

for i = 1:12
    W = [X(i) Y(i) Z(i) 1]';
    Pl = Kmat*Pmat*W;
    out(1,i) = Pl(1,1)/Pl(3,1);
    out(2,i) = Pl(2,1)/Pl(3,1);
end

