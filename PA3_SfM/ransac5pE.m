function [in1, in2, m, E] = ransac5pE(p1, p2, threshold, K)

bestInlierCount = 0;
bestInliers = [];
bestErr = inf;
bestE = [];

desiredConfidence = 0.99;
nSamples = 5;

m = 3; t = 1;
while t < m
    rIndex = randperm(size(p1,2));
    rIndex = rIndex(1:5);

    fa_n = inv(K) * p1(:, rIndex);
    fb_n = inv(K) * p2(:, rIndex);
    
    Evector = calibrated_fivepoint(fa_n, fb_n);
    
    E = [];
    for i=1:size(Evector,2)
        E(:,:,i) = [ Evector(1:3, i) Evector(4:6, i) Evector(7:9, i) ]';
    end
    
    for ec=1:size(Evector,2)
        F=inv(K')*E(:,:,ec)*inv(K);
        %% Find inlier
        for j=1:size(p1,2)
            d(j)=EpipolarDistance( p1(:,j), F,  p2(:,j));
        end
        
        inlier_indexes = find(d < threshold);
        inlierCount = size(inlier_indexes,2);
        total_count = size(p1,2);
        Err = (sum(d(inlier_indexes)) + (total_count - inlierCount)*threshold) / total_count;  

        if(inlierCount > bestInlierCount || (inlierCount == bestInlierCount && Err < bestErr ) )
            bestInlierCount = inlierCount;
            bestErr=Err;
            bestInliers = inlier_indexes;
            bestE = E(:,:,ec);

            inlierRatio = inlierCount/size(p1, 2);

            m = log(1-desiredConfidence) / log(1-(inlierRatio)^nSamples);
        end
    end
    t = t+1;
end

in1 = p1(:, bestInliers);
in2 = p2(:, bestInliers);

E = bestE;
end