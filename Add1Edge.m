function obj = Add1Edge(obj, n1, n2)
    if any([n1, n2] > obj.N) || any([n1, n2] <= 0)
        error('Node indices must be between 1 and N.');
    end
    obj.A2(n1, n2) = 1;
    obj.A2(n2, n1) = 1;
    
    if (nargout == 0)
        clear obj;
    end
end