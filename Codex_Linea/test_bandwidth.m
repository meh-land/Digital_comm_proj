a = -3;
s = -a;
b = 1/3 * acos((-3-s)/a);

freq = -6:0.1:6;
psdx_db = a * cos(b*freq) + s;

max_index = find(psdx_db == max(psdx_db));
bandwidth_index = find(psdx_db(max_index+1:end) <= (psdx_db(max_index) - 3));
bandwidth_manchester = freq(bandwidth_index(1) + max_index)