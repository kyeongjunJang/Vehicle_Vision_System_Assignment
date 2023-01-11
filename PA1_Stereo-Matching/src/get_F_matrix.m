function F=get_F_matrix(img1, img2, m1, m2, K1, K2)

s = length(m1);
m1=[m1(:,1) m1(:,2) ones(s,1)];
m2=[m2(:,1) m2(:,2) ones(s,1)];

Width = size(img1,2); %image width
Height = size(img1,1); %image height

% normalize
N=[2/Width 0 -1;
    0 2/Height -1;
    0   0   1];

% Data Centroid
x1=N*m1'; x2=N*m2';
x1=[x1(1,:)' x1(2,:)'];  
x2=[x2(1,:)' x2(2,:)']; 

% Af=0 
A=[x1(:,1).*x2(:,1) x1(:,2).*x2(:,1) x2(:,1) x1(:,1).*x2(:,2) x1(:,2).*x2(:,2) x2(:,2) x1(:,1) x1(:,2), ones(s,1)];

% Get F matrix
[U S V] = svd(A);
F=reshape(V(:,9), 3, 3)';
% make rank 2 
[U S V] = svd(F);
F=U*diag([S(1,1) S(2,2) 0])*V';

% Denormalize
F = N'*F*N;

% use matlab function
[F, inliersIndex] = estimateFundamentalMatrix(m1(:,1:2),m2(:,1:2));
end
