k = [1 0 1 0];
m = 20;
s1 = ones(1,m);
s2 = zeros(1,m);
w = zeros(1, length(k) * m);

for w_i = 1:m:length(w)
    k_i = 1/m * w_i + (1-1/m);
    if k(k_i) == 1
        w(w_i : w_i+m-1) = s1;
    else
        w(w_i : w_i+m-1) = s2;
    end
end