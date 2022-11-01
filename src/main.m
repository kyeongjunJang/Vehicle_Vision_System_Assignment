clc; clear; close all;
% Get Params
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

% Undistortion
% Id_0 = imread('../KITTI-Dataset/2011_09_26_drive_0048/unsync_unrect/image_00/data/0000000000.png');
Id_0 = imread('../KITTI-Dataset/2011_09_26_drive_0048/calibration/image_00/data/0000000000.png');
% figure, imshow(Id_0)
Iu_0 = uint8(zeros(375,1242));
Iu_0 = undistort_image(Id_0, Iu_0, K_00, D_00);
% figure, imshow(Iu_0)

% Id_1 = imread('../KITTI-Dataset/2011_09_26_drive_0048/unsync_unrect/image_01/data/0000000000.png');
Id_1 = imread('../KITTI-Dataset/2011_09_26_drive_0048/calibration/image_01/data/0000000000.png');
% figure, imshow(Id_1)
Iu_1 = uint8(zeros(375,1242));
Iu_1 = undistort_image(Id_1, Iu_1, K_01, D_01);
% figure, imshow(Iu_1)

% Get Correspondence Points
% corr_pts_0 = get_correspondence_points(Iu_0, 0.04, 500000, 1);
% corr_pts_1 = get_correspondence_points(Iu_1, 0.04, 500000, 1);

% [mathces, confidences] = match_features(corr_pts_0, corr_pts_1);

% show_correspondence(Iu_0, Iu_1,375,1242,375,1242,'arrows','aaa.png')

feature_width = 16;
[x1, y1, confidence1, scale1] = get_interest_points_scaling(Iu_0, feature_width);
[x2, y2, confidence2, scale2] = get_interest_points_scaling(Iu_1, feature_width);



[image1_features] = get_features(Iu_0, x1, y1, feature_width);
[image2_features] = get_features(Iu_1, x2, y2, feature_width);

[matches, confidences] = match_features(image1_features, image2_features);

%% Visualization
num_pts_to_visualize = size(matches,1);

show_correspondence(Iu_0, Iu_1, x1(matches(1:num_pts_to_visualize,1)), ...
                                    y1(matches(1:num_pts_to_visualize,1)), ...
                                    x2(matches(1:num_pts_to_visualize,2)), ...
                                    y2(matches(1:num_pts_to_visualize,2)));