function result = Warping(pix, img)
result = zeros(3,size(pix,2));
for i=1:size(pix,2)
    for n=1:3
        %pix(1,i) -> u pix(2,i) -> v
        if pix(1,i) < 1 || pix(1,i) > 1288
            result(n,i) = -1;
        elseif pix(2,i) < 1 || pix(2,i) >964 || pix(2,i) < 300
            result(n,i) = -1;
        else
            result(n,i)=img(uint16(pix(2,i)),uint16(pix(1,i)),n);
        end
    end
end
end