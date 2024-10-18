function obj = Remove1Edge(obj, n1, n2)
    % Ensure valid node indices
    if any([n1, n2] > obj.N) || any([n1, n2] <= 0)
        error('Node indices must be between 1 and N.');
    end
    
    % Remove the 1-edge from A2
    obj.A2(n1, n2) = 0;
    obj.A2(n2, n1) = 0;
    
    % Remove all affected 2-edges from A3 by setting relevant slices to 0
    obj.A3(n1, n2, :) = 0;
    obj.A3(n1, :, n2) = 0;
    obj.A3(n2, n1, :) = 0;
    obj.A3(n2, :, n1) = 0;
    obj.A3(:, n1, n2) = 0;
    obj.A3(:, n2, n1) = 0;
    
    if (nargout == 0)
        clear obj;
    end
end