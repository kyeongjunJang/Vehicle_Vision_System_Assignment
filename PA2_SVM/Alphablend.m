function I = Alphablend(I1, I2, alpha, rows, cols)
I = zeros(rows,cols,3);

for y=1:rows
    for x=1:cols
        for z=1:3
            if I1(y,x,z) == 0 && I2(y,x,z) == 0
                I(y,x,z)=0;
            elseif I1(y,x,z) == 0
                I(y,x,z)=I2(y,x,z);
            elseif I2(y,x,z) == 0
                I(y,x,z)=I1(y,x,z);
            else
                Pa = I1(y,x,z);
                Pb = I2(y,x,z);
        
                a=Pa*alpha;
                b=Pb*(1-alpha);
        
                c=a+b;
                I(y,x,z)=c;
            end
        end
    end
end
I=uint8(I);
end