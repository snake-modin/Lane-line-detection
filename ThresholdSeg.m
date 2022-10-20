function img_out = ThresholdSeg(img,thresh_low,thresh_high)
    [M,N] = size(img);
    img_out = zeros(M,N);
    for i = 2:M-1
        for j = 2:N-1
            if img(i,j) >= thresh_high
                img_out(i,j) = 1;
            elseif img(i,j)<thresh_high && img(i,j)>=thresh_low
                patch = img(i-1:i+1,j-1:j+1);
                n = sum(sum(patch>=thresh_high));
                if n >=1
                    img_out(i,j) = 1;
                else
                    img_out(i,j) = 0;
                end
            end
        end
    end

