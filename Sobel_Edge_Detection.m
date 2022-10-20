function [G,theta] = Sobel_Edge_Detection(img)
    Hy = [-1 0 1;
          -2 0 2;
          -1 0 1];
    Hx = [-1 -2 -1;
           0  0  0;
           1  2  1];
    [M,N] = size(img);
    Gx = zeros(M,N);
    Gy = zeros(M,N);
    img_pd = zeros(M+2,N+2);
    img_pd(2:end-1,2:end-1) = img;
    % 梯度
    for i = 1:M
        for j = 1:N
        patch = img_pd(i:i+2,j:j+2);
        tmpx = patch.*Hx;
        tmpy = patch.*Hy;
        Gx(i,j) = sum(tmpx(:));
        Gy(i,j) = sum(tmpy(:));
        end
    end
    G =abs(Gx) + abs(Gy);
    G(1,:)=0;G(end,:)=0;G(:,1)=0;G(:,end)=0;
    theta = atan(Gy./Gx)/pi*180;
