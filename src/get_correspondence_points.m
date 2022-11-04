function [m1, m2] = get_correspondence_points(img1, img2)
    keypoint_img1 = im2double(rgb2gray(img1));
    keypoint_img2 = im2double(rgb2gray(img2));
    
    harris_sigma = 1;
    harris_thresh = 0.1;
    harris_radius = 2;
    [~,y_keypoint_img1,x_keypoint_img1] = harris(keypoint_img1,harris_sigma,harris_thresh,harris_radius,0);

    [~,y_keypoint_img2,x_keypoint_img2] = harris(keypoint_img2,harris_sigma,harris_thresh,harris_radius,0);
    
    sift_radius = 5;
    descriptors_img1 = find_sift(keypoint_img1,[x_keypoint_img1,y_keypoint_img1, ...
        sift_radius*ones(length(x_keypoint_img1),1)]);
    descriptors_img2 = find_sift(keypoint_img2,[x_keypoint_img2,y_keypoint_img2, ...
        sift_radius*ones(length(x_keypoint_img2),1)]);
    
    num_putative_matches = 200;
    [matches_img1,matches_img2] = select_putative_matches(...
        descriptors_img1,descriptors_img2,num_putative_matches);
    XY_img1 = [x_keypoint_img1(matches_img1),y_keypoint_img1(matches_img1)];
    XY_img2 = [x_keypoint_img2(matches_img2),y_keypoint_img2(matches_img2)];
%     length(XY_src)
%     num_ransac_iter = 5000;
%     [H,num_inliers,residual] = ransac(XY_src,XY_des,num_ransac_iter,...
%         @homography_fit,@homography_tf);
    
%     img_res = stitchH(img_src,H,img_des);
    
%     figure, imagesc(keypoint_img1), axis image, colormap(gray), hold on
%     plot(x_keypoint_img1,y_keypoint_img1,'ys'),
%     plot(x_keypoint_img1(matches_img1),y_keypoint_img1(matches_img1),'bs'),
%     predict = homography_tf(XY_img1,H);
%     dists = sum((XY_img2 - predict).^2,2);
%     inlier_idx = find(dists < 0.3);
%     plot(XY_img1(inlier_idx,1),XY_img1(inlier_idx,2),'gs'),
% 
%     figure, imagesc(keypoint_img2), axis image, colormap(gray), hold on
%     plot(x_keypoint_img2,y_keypoint_img2,'ys'),
%     plot(x_keypoint_img2(matches_img2),y_keypoint_img2(matches_img2),'bs'),
%     plot(XY_img2(inlier_idx,1),XY_img2(inlier_idx,2),'gs'),

%     m1 = [XY_src(inlier_idx,1),XY_src(inlier_idx,2)];
%     m2 = [XY_des(inlier_idx,1),XY_des(inlier_idx,2)];
    m1 = XY_img1;
    m2 = XY_img2;
end

