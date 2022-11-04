function disparity_map_view(img)
figure; imshow(img);
colormap gray;
colorbar ;
caxis([-100 100]);
end