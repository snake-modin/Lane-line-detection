%% 读取视频
video_file='solidWhiteRight.mp4';
video=VideoReader(video_file);
frame_number = video.NumFrames; %视频的总帧数
%% 分离图片
for i=1:30:frame_number % 这里演示的是每30帧数保存一次
% image_name=strcat(['D:\Users\Admin\Desktop\中南大学文档\大三\大三上\' ...
%     '数字图像处理代码\车道线检测' ...
%     '\IMG\image_'],num2str(i),'.jpg');
Photo=read(video,i); %读出所在帧的图片对象
% imwrite(Photo,image_name); %将图片保存到指定的位置


img = double(rgb2gray(Photo));

% 高斯平滑
ws = 5;
sigma = 2;
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
% figure
% imshow(Edge_Canny,[])
% title("result")

img_res = lines_add(img0,Edge_Canny); % 将frame变换成imwrite函数可以识别的格式
img_name=strcat(['D:\Users\Admin\Desktop\中南大学文档\大三\大三上\' ...
    '数字图像处理代码\车道线检测' ...
    '\IMG_RES\image_'],num2str(i),'.jpg');
imwrite(img_res,img_name); 
end