function obj = Remove2Edge(obj, n1, n2, n3)
    % Ensure valid node indices
    if any([n1, n2, n3] > obj.N) || any([n1, n2, n3] <= 0)
        error('Node indices must be between 1 and N.');
    end
    
    % Set the appropriate entries in A3 to 0
    obj.A3(n1, n2, n3) = 0;
    obj.A3(n1, n3, n2) = 0;
    obj.A3(n2, n1, n3) = 0;
    obj.A3(n2, n3, n1) = 0;
    obj.A3(n3, n1, n2) = 0;
    obj.A3(n3, n2, n1) = 0;
    
    if (nargout == 0)
        clear obj;
    end
end