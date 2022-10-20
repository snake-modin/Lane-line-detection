function G_nms = NMS(G,THETA)
[M,N] = size(G);
G_nms = G;
for i = 2:M-1
    for j = 2:N-1
        theta = THETA(i,j);
        if theta>-22.5 && theta<=22.5 % 0区域
            neib = [G(i-1,j),G(i+1,j)];
        elseif theta>22.5 && theta<=67.5 % 1区域
            neib = [G(i+1,j+1),G(i-1,j-1)];
        elseif theta>67.5 || theta<=-67.5 % 2区域
            neib = [G(i,j+1),G(i,j-1)];
        else % 3区域
            neib = [G(i+1,j-1),G(i-1,j+1)];
        end
        maxv = max(neib);
        if maxv > G(i,j)
            G_nms(i,j) = 0;
        end
    end
end
