function [matches, confidences] = match_features(features1, features2)

% This function does not need to be symmetric (e.g. it can produce
% different numbers of matches depending on the order of the arguments).

% To start with, simply implement the "ratio test", equation 4.18 in
% section 4.1.3 of Szeliski. For extra credit you can implement various
% forms of spatial verification of matches.

% Placeholder that you can delete. Random matches and confidences
% num_features = min(size(features1, 1), size(features2,1));


% ------- Direct distance implementation ---------- %
nnthreshold = 0.9991;

nnratio = zeros(size(features1,1),1);
nnfeatindex = zeros(size(features1,1),2);
i1 = size(features1,1);
i2 = size(features2,1);

dist = pdist2(features1,features2);
[sortdist, sortindex] = sort(dist,2,'ascend');
nnratio(:) = sortdist(:,1)./sortdist(:,2);

nnfeatindex(:,1) = [1:size(features1)];
nnfeatindex(:,2) = sortindex(:,1);

nn_th = nnratio < nnthreshold;

nn_thindex = find(nn_th);
matches = [nnfeatindex(nn_thindex,1), nnfeatindex(nn_thindex,2)];    
confidences = nnratio(nn_thindex);
% ------- --------------------- ---------- %


% Sort the matches so that the most confident onces are at the top of the
% list. You should probably not delete this, so that the evaluation
% functions can be run on the top matches easily.

[confidences, ind] = sort(confidences, 'ascend');
confidences = flip(confidences(:));
ind = flip(ind(:));
matches = matches(ind,:);