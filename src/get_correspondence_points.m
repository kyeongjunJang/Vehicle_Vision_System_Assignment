function [m1, m2] = get_correspondence_points(img1, img2)
    keypoint_img1 = im2double(rgb2gray(img1));
    keypoint_img2 = im2double(rgb2gray(img2));
    
    harris_sigma = 2;
    harris_thresh = 0.05;
    harris_radius = 2;
    [~,y_keypoint_img1,x_keypoint_img1] = harris(keypoint_img1,harris_sigma,harris_thresh,harris_radius,0);

    [~,y_keypoint_img2,x_keypoint_img2] = harris(keypoint_img2,harris_sigma,harris_thresh,harris_radius,0);
    
    sift_radius = 5;
    descriptors_src = find_sift(keypoint_img1,[x_keypoint_img1,y_keypoint_img1, ...
        sift_radius*ones(length(x_keypoint_img1),1)]);
    descriptors_des = find_sift(keypoint_img2,[x_keypoint_img2,y_keypoint_img2, ...
        sift_radius*ones(length(x_keypoint_img2),1)]);
    
    num_putative_matches = 200;
    [matches_src,matches_des] = select_putative_matches(...
        descriptors_src,descriptors_des,num_putative_matches);
    XY_src = [x_keypoint_img1(matches_src),y_keypoint_img1(matches_src)];
    XY_des = [x_keypoint_img2(matches_des),y_keypoint_img2(matches_des)];
%     length(XY_src)
%     num_ransac_iter = 5000;
%     [H,num_inliers,residual] = ransac(XY_src,XY_des,num_ransac_iter,...
%         @homography_fit,@homography_tf);
    
%     img_res = stitchH(img_src,H,img_des);
    
%     figure, imagesc(keypoint_img1), axis image, colormap(gray), hold on
%     plot(x_keypoint_img1,y_keypoint_img1,'ys'),
%     plot(x_keypoint_img1(matches_src),y_keypoint_img1(matches_src),'bs'),
%     predict = homography_tf(XY_src,H);
%     dists = sum((XY_des - predict).^2,2);
%     inlier_idx = find(dists < 0.3);
%     plot(XY_src(inlier_idx,1),XY_src(inlier_idx,2),'gs'),

%     figure, imagesc(keypoint_img2), axis image, colormap(gray), hold on
%     plot(x_keypoint_img2,y_keypoint_img2,'ys'),
%     plot(x_keypoint_img2(matches_des),y_keypoint_img2(matches_des),'bs'),
%     plot(XY_des(inlier_idx,1),XY_des(inlier_idx,2),'gs'),

%     m1 = [XY_src(inlier_idx,1),XY_src(inlier_idx,2)];
%     m2 = [XY_des(inlier_idx,1),XY_des(inlier_idx,2)];
    m1 = XY_src;
    m2 = XY_des;
end

