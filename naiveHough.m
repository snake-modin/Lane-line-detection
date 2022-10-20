function [ Hough, theta_range, rho_range ] = naiveHough(I)
% 霍夫变换
[rows, cols] = size(I);
 
theta_maximum = 90;
rho_maximum = floor(sqrt(rows^2 + cols^2)) - 1;% 坐标从0开始
theta_range = -theta_maximum:theta_maximum - 1; % 90与-90重合了
rho_range = -rho_maximum:rho_maximum;
 
Hough = zeros(length(rho_range), length(theta_range));
for row = 1:rows
    for col = 1:cols
        if I(row, col) > 0 %only find: pixel > 0
            % 坐标从0开始
            x = col - 1;
            y = row - 1;
            for theta = theta_range
                rho = round((x * cosd(theta)) + (y * sind(theta)));  %approximate
                rho_index = rho + rho_maximum + 1;% 因为矩阵左上角点为（-rho_maximun，theta_maximun）
                theta_index = theta + theta_maximum + 1;
                Hough(rho_index, theta_index) = Hough(rho_index, theta_index) + 1;
            end
        end
    end
end