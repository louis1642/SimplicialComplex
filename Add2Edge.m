function obj = Add2Edge(obj, n1, n2, n3)
    if any([n1, n2, n3] > obj.N) || any([n1, n2, n3] <= 0)
        error('Node indices must be between 1 and N.');
    end
    obj.Add1Edge(n1, n2);
    obj.Add1Edge(n2, n3);
    obj.Add1Edge(n1, n3);
    obj.A3(n1,n2,n3) = 1;
    obj.A3(n1,n3,n2) = 1;
    obj.A3(n2,n1,n3) = 1;
    obj.A3(n2,n3,n1) = 1;
    obj.A3(n3,n1,n2) = 1;
    obj.A3(n3,n2,n1) = 1;
    
    if (nargout == 0)
        clear obj;
    end
end