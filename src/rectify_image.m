function rect_img = rectify_image(img, K, R)
w = 1242;
h = 375;%size(img,1);
rect_img = (zeros(375,1242,3));
R_inv = inv(R);
% R_inv = diag([1,1,1]);
% Trans = K*inv(R)*inv(K);
    for y = 1:h
        for x = 1:w
            for z = 1:3
%                                                                                                   normalize_img = invK * pixel_img
            y_n_rect = (y-K(2,3))/K(2,2);
            x_n_rect = (x-K(1,3)-K(1,2)*y_n_rect)/K(1,1);
%                                                                                     r2 = x_n_r*x_n_r + y_n_r*y_n_r;

                                                                                    %                 x_n = radial_d*x_n_r + 2*D(3)*x_n_r*y_n_r + D(4)*(r2 + 2*x_n_r*x_n_r);
                                                                                    %                 y_n = radial_d*y_n_r + D(3)*(r2 + 2*y_n_r*y_n_r) + 2*D(4)*x_n_r*y_n_r;
            x_n = (R_inv(1,1)*x_n_rect+R_inv(1,2)*y_n_rect+R_inv(1,3)) ...
                / (R_inv(3,1)*x_n_rect+R_inv(3,2)*y_n_rect+R_inv(3,3));
            y_n = (R_inv(2,1)*x_n_rect+R_inv(2,2)*y_n_rect+R_inv(2,3)) ...
                / (R_inv(3,1)*x_n_rect+R_inv(3,2)*y_n_rect+R_inv(3,3));

            x_p = K(1,1)*x_n + K(1,2)*y_n + K(1,3);
            y_p = K(2,2)*y_n + K(2,3);
%                                                                                         rect_pixel = Trans*[y,x,z]'
            
%                 
            rect_img(y, x, z) = img(round(y_p),round(x_p),z);
            end
        end
    end

% 3d_coord = inv(R)*inv(K)*(pixel)
% rect_pixel = K*3d_coord

% H =R*K; %R * cameraParams.IntrinsicMatrix;
% rect_img = imwarp(img, projective2d(inv(H)));

end
