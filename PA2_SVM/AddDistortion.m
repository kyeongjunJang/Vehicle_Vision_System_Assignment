function [xx, yy] = AddDistortion(CameraParams, world_pts)
%world -> normal
normalize_world_pts = [world_pts(1,:)./world_pts(3,:); world_pts(2,:)./world_pts(3,:)];

%normal -> distortion
r_square = normalize_world_pts(1,:).^2 + normalize_world_pts(2,:).^2;
r = sqrt(r_square);
theta = atan(r);
xx = theta./r.*(1+CameraParams(6)*theta.^2+CameraParams(7)*theta.^4+CameraParams(8)*theta.^6+CameraParams(9)*theta.^8).*normalize_world_pts(1,:);
yy = theta./r.*(1+CameraParams(6)*theta.^2+CameraParams(7)*theta.^4+CameraParams(8)*theta.^6+CameraParams(9)*theta.^8).*normalize_world_pts(2,:);
end