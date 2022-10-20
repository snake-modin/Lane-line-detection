img = imread("IMG/image_31.jpg");
img = double(rgb2gray(img));

% 高斯平滑
ws = 5;
sigma = 3;
imgf = Gau_Filter(img,ws,sigma);
% Sobel
[G,theta] = Sobel_Edge_Detection(imgf);
% NMS
G_nms = NMS(G,theta);
% figure
% imshow(G_nms,[])
% title("NMS")
% 双阈值
thresh_low = 100;
thresh_high = 2*thresh_low;
Edge_Canny = ThresholdSeg(G_nms,thresh_low,thresh_high);
Edge_Canny(1:300,:) = 0;
Edge_Canny(288:427,1:330) = 0;
Edge_Canny(307:399,640:end) = 0;
Edge_Canny(292:338,331:428) = 0;
figure
imshow(Edge_Canny,[])
title("result")
%%
[m,n] = size(img);
[h,theta_range,rho_range] = naiveHough(Edge_Canny);
maxlen = sort(h(:));
lines = zeros(m,n);
line_num = 10;
rho_max =  floor(sqrt(m^2 + n^2)) - 1;
theta_max = 90;
% P = zeros(line_num,2);
P = houghpeaks(h,line_num,'Threshold',1);
left_flag = 0;
right_flag = 0;
for i = 1:line_num
%     [rho,theta] = find(h==maxlen(end-i+1),1);
%     P(i,1) = rho;
%     P(i,2) = theta;
    rho = P(i,1);
    theta = P(i,2);
    rho = rho - rho_max - 1;
    theta = theta - theta_max - 1;
    if right_flag == 0 && theta < 0
    x = 500:800;
    y = (rho-x.*cosd(theta))/sind(theta);
    index = find(((y<m).*(y>0)));
    x = x(index);
    y = y(index);
    for j = 1:length(index)
    lines(round(y(j))+1,round(x(j)+1)) = 1;
    end
    right_flag = 1;
    end
    if left_flag == 0 && theta > 0
    x = 200:450;
    y = (rho-x.*cosd(theta))/sind(theta);
    index = find(((y<m).*(y>0)));
    x = x(index);
    y = y(index);
    for j = 1:length(index)
    lines(round(y(j))+1,round(x(j)+1)) = 1;
    end
    left_flag = 1;
    end
    if right_flag==1 && left_flag == 1
        break
    end
end
imshow(lines,[])
%%

[H,T,R] = hough(Edge_Canny);
lines = houghlines(Edge_Canny,T,R,P,'FillGap',100,'MinLength',300);
figure, imshow(img,[]), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','red');
end


%%
[H,T,R] = hough(Edge_Canny);
maxlen = sort(H(:));
P = houghpeaks(H,10,'Threshold',1);
%%
lines = houghlines(Edge_Canny,T,R,P,'FillGap',110,'MinLength',10);
fig = figure;
% set(0,'DefaultFigureVisible', 'off')
imshow(img,[]), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');
end
% img_res = lines_add(img0,Edge_Canny);