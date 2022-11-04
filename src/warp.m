
% control pointÀÇ °³Œö ÁöÁ€
ctrNx = 5;
ctrNy = 5;

% ¿öÇÎÇÒ ÀÌ¹ÌÁö ÁØºñ
I = checkerboard(16);
[nrow, ncol] = size(I);    % ÀÌ¹ÌÁöÀÇ »çÀÌÁî ŸòŽÂŽÙ




% control point grid Œ³Á€
[x1, y1] = meshgrid( linspace(1,ncol,ctrNx), linspace(1,nrow,ctrNy) );

% ¹«ÀÛÀ§ °ªÀ» °¡Áöµµ·Ï motion vector »ýŒº
amp  = 5;  % motion vectorÀÇ Å©±âžŠ Å°¿öÁÖŽÂ factor
Vx = padarray(randn([ctrNy-2 ctrNx-2])*amp,[1, 1]);   % ¿Ü°ûÀÇ motion vectorŽÂ ¿òÁ÷ÀÌÁö ŸÊµµ·Ï Œ³Á€
Vy = padarray(randn([ctrNy-2 ctrNx-2])*amp,[1, 1]);

% motion vectoržŠ ÀÌ¿ëÇØŒ­ deformation map Ux, Uy »ýŒº
[x2, y2] = meshgrid( 1:ncol, 1:nrow);
Ux = interp2( x1, y1, Vx, x2, y2 );
Uy = interp2( x1, y1, Vy, x2, y2 );





% pixelÀ» ÀÌµ¿ÇØŒ­ warping ŒöÇà
Iwarped = interp2(x2, y2, I, x2 - Ux, y2 - Uy );




% Ç¥œÃ
figure;
subplot(1,2,1);
imagesc(I, [ 0 1]); colormap gray; axis image;
hold on;
scatter( x1(:), y1(:), 25, 'g');

subplot(1,2,2);
imagesc(Iwarped,[0 1]); colormap gray; axis image;
hold on;
scatter( x1(:)+Vx(:), y1(:)+Vy(:), 25, 'g');