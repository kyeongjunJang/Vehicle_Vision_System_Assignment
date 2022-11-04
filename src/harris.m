function [cim, r, c] = harris(im, sigma, thresh, radius, disp)
    if ndims(im) == 3
        im = rgb2gray(im);
    end

    [dx, dy] = meshgrid(-1:1, -1:1);% Derivative masks, sobel mask
    
    Ix = conv2(im, dx, 'same');    % Image derivatives
    Iy = conv2(im, dy, 'same');    

    % Generate Gaussian filter of size 6*sigma (+/- 3sigma) and of
    % minimum size 1x1.
    g = fspecial('gaussian',max(1,fix(6*sigma)), sigma);
    
    Ix2 = conv2(Ix.^2, g, 'same'); % Smoothed squared image derivatives A
    Iy2 = conv2(Iy.^2, g, 'same'); % B
    Ixy = conv2(Ix.*Iy, g, 'same'); % C
    
%     cim = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2);% + eps); % Harris corner measure

    k = 0.04; % 0.04~0.06
    Det = Ix2.*Iy2 - Ixy.^2;
    Tr = Ix2 + Iy2;
    cim = Det - k*Tr.^2;

    if nargin > 2   % We should perform nonmaximal suppression and threshold
	
	sze = 2*radius+1;                   % Size of mask.
	mx = ordfilt2(cim,sze^2,ones(sze)); % Grey-scale dilate.
	cim = (cim==mx)&(cim>thresh);       % Find maxima.
	
	[r,c] = find(cim);                  % Find row,col coords.
	
	if nargin==5 & disp      % overlay corners on original image
	    figure, imagesc(im), axis image, colormap(gray), hold on
	    plot(c,r,'ys'), title('corners detected');
    end

    else
	r = []; c = [];
    end
