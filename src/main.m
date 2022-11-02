clc; clear; close all;
%% Load Parameters and Image
[calibration_var, calibration_data] = ...
readvars('../KITTI-Dataset/2011_09_26_drive_0048/calib_cam_to_cam.txt');

K_00 = strsplit(string(calibration_data(3)),' ');
K_00 = str2double(reshape(K_00,3,3)');
D_00 = strsplit(string(calibration_data(4)),' ');
D_00 = str2double(D_00);

K_01 = strsplit(string(calibration_data(3)),' ');
K_01 = str2double(reshape(K_01,3,3)');
D_01 = strsplit(string(calibration_data(4)),' ');
D_01 = str2double(D_01);

Image1 = imread('../KITTI-Dataset/2011_09_26_drive_0048/unsync_unrect/image_02/data/0000000000.png');
Image2 = imread('../KITTI-Dataset/2011_09_26_drive_0048/unsync_unrect/image_03/data/0000000000.png');

%% Undistortion
% undistortImage1 = undistort_image(Image1, K_00, D_00, 1);
% undistortImage2 = undistort_image(Image2, K_01, D_01, 1);

%% Get Correspondence Points
% [H,num_inliers,residual] = get_correspondence_points(Image1,undistortImage2);

%% Get Disparity Map
disparityImage = get_disparity_map(Image1, Image2);









% feature_width = 16;
% [x1, y1, confidence1, scale1] = get_interest_points_scaling(Iu_0, feature_width);
% [x2, y2, confidence2, scale2] = get_interest_points_scaling(Iu_1, feature_width);
% 
% 
% 
% [image1_features] = get_features(Iu_0, x1, y1, feature_width);
% [image2_features] = get_features(Iu_1, x2, y2, feature_width);
% 
% [matches, confidences] = match_features(image1_features, image2_features);
% 
% %% Visualization
% num_pts_to_visualize = size(matches,1);
% 
% show_correspondence(Iu_0, Iu_1, x1(matches(1:num_pts_to_visualize,1)), ...
%                                     y1(matches(1:num_pts_to_visualize,1)), ...
%                                     x2(matches(1:num_pts_to_visualize,2)), ...
%                                     y2(matches(1:num_pts_to_visualize,2)));