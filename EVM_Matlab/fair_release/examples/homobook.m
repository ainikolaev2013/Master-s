function [yc,dy] = homobook(wc,xc)
xc = reshape(xc,[],2);
yc=zeros(2*size(xc,1),1);
dy=zeros(2*size(xc,1),9);
for i=1:size(xc,1)
    yc(i) = (wc(1)*xc(i,1) +wc(2)*xc(i,2) + wc(3))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
end
for i=1:size(xc,1)
    yc(size(xc,1)+i)=(wc(4)*xc(i,1) +wc(5)*xc(i,2) + wc(6))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
end
%(f'g-g'f)/(g')^2
for i=1:size(xc,1)    
        dy(i,1) = xc(i,1)/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
        dy(i,2) = xc(i,2)/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
        dy(i,3) = 1/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
        dy(i,4) = 0;
        dy(i,5) = 0;
        dy(i,6) = 0;
        dy(i,7) = -(wc(1)*xc(i,1) +wc(2)*xc(i,2) + wc(3))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9))^2*xc(i,1);
        dy(i,8) = -(wc(1)*xc(i,1) +wc(2)*xc(i,2) + wc(3))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9))^2*xc(i,2);
        dy(i,9) = -(wc(1)*xc(i,1) +wc(2)*xc(i,2) + wc(3))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9))^2;    
end
for i=1:size(xc,1)
    dy(i+size(xc,1),1) = 0;
    dy(i+size(xc,1),2) = 0;
    dy(i+size(xc,1),3) = 0;
    dy(i+size(xc,1),4) = xc(i,1)/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
    dy(i+size(xc,1),5) = xc(i,2)/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));
    dy(i+size(xc,1),6) = 1/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9));    
    dy(i+size(xc,1),7) = -(wc(4)*xc(i,1) +wc(5)*xc(i,2) + wc(6))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9))^2*xc(i,1);
    dy(i+size(xc,1),8) = -(wc(4)*xc(i,1) +wc(5)*xc(i,2) + wc(6))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9))^2*xc(i,2);
    dy(i+size(xc,1),9) = -(wc(4)*xc(i,1) +wc(5)*xc(i,2) + wc(6))/(wc(7)*xc(i,1) +wc(8)*xc(i,2) + wc(9))^2;        
end
%yc = [(wc(1)*xc(:,1) + wc(2)*xc(:,2) + wc(3))
%      (wc(4)*xc(:,1) + wc(5)*xc(:,2) + wc(6))];
