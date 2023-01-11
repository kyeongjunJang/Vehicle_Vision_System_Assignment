function [m1, m2] = select_putative_matches(d1, d2, num)
    d1 = zscore(d1')';
    d2 = zscore(d2')';
    
    distance = dist2(d1,d2);
    
    [h,w] = size(distance);
    distance = reshape(distance,1,[]);
    [~,idx] = sort(distance);
    [r,c] = ind2sub([h,w],idx(1:num));
    m1 = r';
    m2 = c';
end

