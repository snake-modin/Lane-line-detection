function img_result = lines_add(img,Edge_Canny)
    %%
[H,T,R] = hough(Edge_Canny);
maxlen = sort(H(:));
line_num =100;
P = zeros(line_num,2);
for i = 1:line_num
    [rho,theta] = find(H==maxlen(end-i+1),1);
    P(i,1) = rho;
    P(i,2) = theta;
end
lines = houghlines(Edge_Canny,T,R,P,'FillGap',100,'MinLength',10);
fig = figure;
% set(0,'DefaultFigureVisible', 'off')
imshow(img,[]), hold on
for k = 1:length(lines)
   xy = [lines(k).point1; lines(k).point2];
   plot(xy(:,1),xy(:,2),'LineWidth',5,'Color','red');
end
frame = getframe(fig);
img_result = frame2im(frame); % 将frame变换成imwrite函数可以识别的格式

