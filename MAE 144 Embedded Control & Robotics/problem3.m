ys=20*[1 1]; xs=[1 10 10]; h=0.01; Ds=RR_tf(ys,xs); omegac=sqrt(10); 

[Dz] = OS_C2D_matched(Ds,h,omegac);

disp('Corresponding Matlab solution:')
opt = c2dOptions('Method','tustin','PrewarpFrequency',omegac); c2d(tf(ys,xs),h,opt)

function [Dz]=OS_C2D_matched(Ds,h,omegac)
        % function [Dz]=RR_C2D_tustin(Ds,h,omegac)
        % Convert Ds(s) to Dz(z) using Tustin's method.  If omegac is specified, prewarping is applied
        % such that the dynamics of Ds(s) in the vicinity of this critical frequency are mapped correctly.    
% if nargin==2, f=1; else, f=omegac; end

m=Ds.num.n;b=RR_poly(0); a=b; n=Ds.den.n; b=RR_poly(0); a=b;
fac1=RR_poly([1 1]); fac2=RR_poly([1 -1]);
as=exp(Ds.num.poly*h)*fac1;
bs=exp(Ds.den.poly*h)*fac2;
disp(as.poly)
disp(bs.poly)
%     for j=0:m
%         disp("j= ")
%         disp(j)
%         disp("b= ")
%         disp(b)
%         b=exp(Ds.num.poly(m+1-j)*h)*fac1^(m-j)*fac2^j;
%     end
%     for j=0:n 
%         a=exp(Ds.den.poly(n+1-j)*h)*fac1^(n-j)*fac2^j;
%     end 
Dz=RR_tf(bs,as); Dz.h=h;

end