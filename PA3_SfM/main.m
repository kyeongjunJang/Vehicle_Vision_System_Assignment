clear; clc; close all;

run('./vlfeat/toolbox/vl_setup')

addpath('./Givenfunctions')

imgA = imread('./Data/0016.jpg');
imgB = imread('./Data/0017.jpg');

%% Feature Matching from SIFT
[Fa, Da] = vl_sift(single(rgb2gray(imgA)));
[Fb, Db] = vl_sift(single(rgb2gray(imgB)));

matches = vl_ubcmatch(Da, Db);

xa = Fa(1,matches(1,:));
xb = Fb(1,matches(2,:));
ya = Fa(2,matches(1,:));
yb = Fb(2,matches(2,:));

Ma = [xa; ya; ones(1, size(xa,2))];
Mb = [xb; yb; ones(1, size(xb,2))];

%% Estimate Essential matrix with RANSAC using given calibrated_fivepoint function
K = readmatrix('./Data/K.txt');
[in1, in2, m, E] = ransac5pE(Ma, Mb, 0.8, K);

% Display inliers Feature Matching
figure; clf;
imagesc(cat(2, imgA, imgB));

xa = in1(1,:);
xb = in2(1,:) + size(imgA,2) ;
ya = in1(2,:);
yb = in2(2,:);

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
axis image off ;

%% Decompose essential matrix to camera extrinsic [R|t]
transfoCandidates = decomp_E_matrix(E);
cnt = 0;
for i=1:4
    R = transfoCandidates(i).R;
    t = transfoCandidates(i).t;
    R_t = vertcat(horzcat(R,t),[0 0 0 1]);
    dim_corr = horzcat(eye(3),[0; 0; 0]);
    
    P1 = K*dim_corr*R_t;
    P2 = K*dim_corr*inv(R_t);

    %% Triangulation
    X = Triangulation(P1,P2,in1,in2,imgA);
    
    if isempty(find(X(3,:)<0))
        %% save PLY
        SavePLY('3Dmodel.ply', X)
        fprintf('3D model file saved! \n');
        break
    else
        cnt = cnt+1;
        if cnt==4
            fprintf('3D model file not saved! Please try again! \n');
        end
    end
end

