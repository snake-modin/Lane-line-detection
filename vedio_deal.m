% %% 读取视频
% video_file='solidWhiteRight.mp4';
% video=VideoReader(video_file);
% frame_number = video.NumFrames; %视频的总帧数
% % 分离图片
% for i=1:30:frame_number % 这里演示的是每30帧数保存一次
% % image_name=strcat(['D:\Users\Admin\Desktop\中南大学文档\大三\大三上\' ...
% %     '数字图像处理代码\车道线检测' ...
% %     '\IMG\image_'],num2str(i),'.jpg');
% Photo=read(video,i); %读出所在帧的图片对象
%  imwrite(Photo,image_name); %将图片保存到指定的位置

%%
video_file='solidWhiteRight.mp4';
video=VideoReader(video_file);
frame_number = video.NumFrames; %视频的总帧数
%创建视频文件并打开 
vidObj = VideoWriter('output','MPEG-4');
open(vidObj);
for i=1:frame_number % 这里演示的是每30帧数保存一次
    i
    image_name=strcat('IMG\image_',num2str(i),'.jpg');
    img = edge_det(image_name);
    writeVideo(vidObj,img);             %写入视频
end
% 关闭视频文件
close(vidObj);