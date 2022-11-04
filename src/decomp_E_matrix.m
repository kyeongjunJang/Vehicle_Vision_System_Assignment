function [R, t] = decomp_E_matrix(E)
[u,s,v] = svd(E);
w = [0 -1 0; 1 0 0; 0 0 1];

T1 = u*w*s*u';
R1 = u*w'*v';
t1 = [T1(3,2) T1(1,3) T1(2,1)]';

T2 = u*w'*s*u';
R2 = u*w*v';
t2 = [T2(3,2) T2(1,3) T2(2,1)]';

if (det(R1) < 0)
    t1 = -t1;
    R1 = -R1;
end
if (det(R2) < 0)
    t2 = -t1;
    R2 = -R2;
end

if (t1(1)>0)
    t = t1;
    R = R1;
elseif (t2(1)>0)
    t = t2;
    R = R2;
end

% t1 = u(:,3);
% R1 = u*w'*v';
% if(det(R1) < 0)
%     t1 = -t1;
%     R1 = -R1;
% end
% t2 = -u(:,3);
% R2 = u*w'*v';
% if(det(R2) < 0)
%     t2 = -t1;
%     R2 = -R2;
% end
% t3 = u(:,3);
% R3 = u*w*v';
% if(det(R3) < 0)
%     t3 = -t3;
%     R3 = -R3;
% end
% t4 = -u(:,3);
% R4 = u*w*v';
% if(det(R4) < 0)
%     t4 = -t4;
%     R4 = -R4;
% end
% % T1 = u*w*s*u';
% % R1 = u*w'*v';
% % T2 = u*w'*s*u';
% % R2 = u*w*v';
% 
% % T = inv(R2)*T2*R2;
% % t = [T(3,2) T(1,3) T(2,1)]'
% if (t1(1) > 0)
%     t = t1;
% elseif (t2(1)>0)
%     t= t2;
% elseif (t3(1)>0)
%     t= t3;
% elseif (t4(1)>0)
%     t= t4;
% end
% if (any(diag(R1))>0)
%     R = R1;
% elseif (any(diag(R2))>0)
%     R = R2;
% elseif (any(diag(R3))>0)
%     R = R3;
% elseif (any(diag(R4))>0)
%     R = R4;
% end
end