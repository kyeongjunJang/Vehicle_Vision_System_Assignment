function X = Triangulation(P1, P2, in1, in2, imgA)
X=[];
for i=1:size(in1,2)

    x1 = in1(2,i);
    y1 = in1(1,i);
    x2 = in2(2,i);
    y2 = in2(1,i);

	X1 = [0 -1 y1; 
          1 0 -x1; 
         -y1 x1 0];
	X2 = [0 -1 y2; 
          1 0 -x2; 
         -y2 x2 0];
    
    A = [X1*P1; 
         X2*P2];

    A = [A(1:2,:); 
         A(4:5,:)];
    
    [~,~,V] = svd(A);
    z = V(:,end);
    point=z/z(4);
    point = point(1:3);
    
    colormap = [];
    for x=1:3
        colormap(:,x) = imgA(round(in1(2,i)),round(in1(1,i)),x);
    end
    X(:,i) = [point' colormap]'; 
end

end