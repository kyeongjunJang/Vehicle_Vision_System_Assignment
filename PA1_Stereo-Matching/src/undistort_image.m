function Iu=undistort_image(Id, K, D, RGB)
w = 1392; % Iu
h = 512; % Iu
if (RGB == 1)
    Iu = (zeros(h,w,3));
    for y = 1:h
        for x = 1:w
            for z = 1:3
        y_nu = (y-K(2,3))/K(2,2);
        x_nu = (x-K(1,3)-K(1,2)*y_nu)/K(1,1);
        ru2 = x_nu*x_nu + y_nu*y_nu;	% ru2 = ru*ru
        
        radial_d = 1 + D(1)*ru2 + D(2)*ru2*ru2 + D(5)*ru2*ru2*ru2;
        
        x_nd = radial_d*x_nu + 2*D(3)*x_nu*y_nu + D(4)*(ru2 + 2*x_nu*x_nu);
        y_nd = radial_d*y_nu + D(3)*(ru2 + 2*y_nu*y_nu) + 2*D(4)*x_nu*y_nu;
        
        x_pd = K(1,1)*x_nd + K(1,2)*y_nd + K(1,3);
        y_pd = K(2,2)*y_nd + K(2,3);
        
        Iu(y, x, z) = Id(round(y_pd),round(x_pd),z);
            end
        end
    end  
else
    Iu = (zeros(h,w));
    for y = 1:h
        for x = 1:w
        y_nu = (y-K(2,3))/K(2,2);
        x_nu = (x-K(1,3)-K(1,2)*y_nu)/K(1,1);
        ru2 = x_nu*x_nu + y_nu*y_nu;	% ru2 = ru*ru
        
        radial_d = 1 + D(1)*ru2 + D(2)*ru2*ru2 + D(5)*ru2*ru2*ru2;
        
        x_nd = radial_d*x_nu + 2*D(3)*x_nu*y_nu + D(4)*(ru2 + 2*x_nu*x_nu);
        y_nd = radial_d*y_nu + D(3)*(ru2 + 2*y_nu*y_nu) + 2*D(4)*x_nu*y_nu;
        
        x_pd = K(1,1)*x_nd + K(1,2)*y_nd + K(1,3);
        y_pd = K(2,2)*y_nd + K(2,3);
        
        Iu(y, x) = Id(round(y_pd),round(x_pd));
        end
    end  
end
Iu = uint8(Iu);
end

