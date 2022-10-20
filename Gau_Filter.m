function imgf = Gau_Filter(img,ws,sigma)
    x = 1:ws;
    y = 1:ws;
    [X,Y] = meshgrid(x,y);
    X = X';
    Y = Y';
    x0 = (ws+1)/2;
    y0 = (ws+1)/2;
    X1 = X - x0;
    Y1 = y - y0;
    dist = (X1.^2 + Y1.^2);
    H = exp(-dist/(2*sigma.^2));
    H = H/sum(H(:));

    [M,N] = size(img);
    imgf = img;
    pd = (ws-1)/2;
    for i = pd:M-pd-1
        for j = pd:N-pd-1
            patch = img(i-pd+1:i+pd+1,j-pd+1:j+pd+1);
            tmp = patch.*H;
            imgf(i,j) = sum(tmp(:));
        end
    end





