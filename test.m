%% 读取视频
video_file='solidWhiteRight.mp4';
video=VideoReader(video_file);
frame_number = video.NumFrames; %视频的总帧数
%% 分离图片
for i=1:frame_number % 这里演示的是每30帧数保存一次
image_name=strcat(['D:\Users\Admin\Desktop\中南大学文档\大三\大三上\' ...
    '数字图像处理代码\车道线检测' ...
    '\IMG\image_'],num2str(i),'.jpg');
Photo=read(video,i); %读出所在帧的图片对象
% imwrite(Photo,image_name); %将图片保存到指定的位置
end

%% 自己写的
[m,n] = size(img);
[h,theta_range,rho_range] = naiveHough(Edge_Canny);
maxlen = sort(h(:));
lines = zeros(m,n);
line_num = 100;
rho_max =  floor(sqrt(m^2 + n^2)) - 1;
theta_max = 90;
P = zeros(line_num,2);
for i = 1:line_num
    [rho,theta] = find(h==maxlen(end-i+1),1);
    P(i,1) = rho;
    P(i,2) = theta;
    rho = rho - rho_max - 1;
    theta = theta - theta_max - 1;
    x = 0:n-1;
    y = (rho-x.*cosd(theta))/sind(theta);
    index = find(((y<m).*(y>0)));
    x = x(index);
    y = y(index);
    for j = 1:length(index)
    lines(round(y(j))+1,round(x(j)+1)) = 1;
    end
end
% imshow(lines,[])
[H,T,R] = hough(Edge_Canny);
lines = houghlines(Edge_Canny,T,R,P,'FillGap',100,'MinLength',300);
figure, imshow(img,[]), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','red');
end
%%
[m,n] = size(img);
[H,T,R] = hough(Edge_Canny);
P  = houghpeaks(H,100);
lines = houghlines(Edge_Canny,T,R,P,'FillGap',100,'MinLength',0.001);
figure, imshow(img,[]), hold on
max_len = 0;
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',2,'Color','red');

   % 画出起点和终点
%    plot(xy(1,1),xy(1,2),'o','LineWidth',2,'Color','blue');
%    plot(xy(2,1),xy(2,2),'o','LineWidth',2,'Color','blue');

%   % Determine the endpoints of the longest line segment
%    len = norm(lines(k).point1 - lines(k).point2);
%    if ( len > max_len)
%       max_len = len;
%       xy_long = xy;
%    end
end