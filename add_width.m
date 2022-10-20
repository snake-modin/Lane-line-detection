function line = add_width(lines)
    [M,N] = size(lines);
    line = zeros(M,N);
    for i = 2:M-1
        for j = 2:N-1
            if lines(i,j) ==1
                line(i-2:i+1,j-1:j+1)=1;
             
            end
        end
    end
end

