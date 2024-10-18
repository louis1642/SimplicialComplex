function idx = circ_idx(obj, i)
    idx = mod(i-1, obj.N)+1;
end