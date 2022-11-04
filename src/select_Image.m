function [I1,I2,cam2_folder,cam3_folder,img_name] = select_Image(idx)

cam2_folder = '../KITTI-Dataset/2011_09_26_drive_0048/unsync_unrect/image_02/data/'; 
cam3_folder = '../KITTI-Dataset/2011_09_26_drive_0048/unsync_unrect/image_03/data/'; 

list = dir(cam2_folder);
img_name = [];
for i = 3:30
    img_name = [img_name; list(i).name]; 
end

I1 = imread([cam2_folder, img_name(idx, :)]);
I2 = imread([cam3_folder, img_name(idx, :)]);
end