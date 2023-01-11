function [transfoCandidates] = decomp_E_matrix(E)

transfoCandidates = repmat(struct('t',[],'R',[]),[4 1]);

[u,s,v] = svd(E);
w = [0 -1 0; 1 0 0; 0 0 1];

T1 = u*w*s*u';
T2 = u*w'*s*u';
T3 = u*w'*s*u';
T4 = u*w*s*u';

t1 = [T1(3,2) T1(1,3) T1(2,1)]';
t2 = [T2(3,2) T2(1,3) T2(2,1)]';
t3 = [T3(3,2) T3(1,3) T3(2,1)]';
t4 = [T4(3,2) T4(1,3) T4(2,1)]';

R1 = u*w*v';
R2 = u*w'*v';
R3 = u*w'*v';
R4 = u*w*v';

if det(R1) < 0
    t1 = -t1;
    R1 = -R1;
end
if det(R2) < 0
    t2 = -t2;
    R2 = -R2;
end
if det(R3) < 0 
    t3 = -t3;
    R3 = -R3;
end
if det(R4) < 0 
    t4 = -t4;
    R4 = -R4;
end

transfoCandidates(1).t = t1;
transfoCandidates(2).t = t2;
transfoCandidates(3).t = t3;
transfoCandidates(4).t = t4;

transfoCandidates(1).R = R1;
transfoCandidates(2).R = R2;
transfoCandidates(3).R = R3;
transfoCandidates(4).R = R4;

end