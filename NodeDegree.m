function deg = NodeDegree(obj, node, d)
% NodeDegree - Compute the degree of one or more nodes in the simplicial complex.
%
% Syntax:
%   deg = obj.NodeDegree(node);
%   deg = obj.NodeDegree(node, d);
%
% Description:
%   This function calculates the degree of one or more nodes in the simplicial complex.
%   By default, the degree is computed based on 2-simplices (triangles). If 
%   the user specifies d = 1, the degree is computed based on 1-simplices (edges).
%
% Inputs:
%   node      - A vector of node numbers for which the degrees are calculated.
%   d         - (optional) The degree type: 
%               1 for 1-simplices (edges), 
%               2 for 2-simplices (triangles). Default is 2.
%
% Outputs:
%   deg       - A vector of degrees corresponding to the input nodes for the chosen simplex type.
%
    arguments
        obj
        node {mustBeVector, mustBeInteger, mustBePositive}
        d (1,1) {mustBeMember(d, [1 2])} = 2
    end

    if any(node > obj.N)
        error("Invalid node. The hypergraph only contains %d nodes.", obj.N)
    end

    deg = zeros(size(node));
    
    for idx = 1:length(node)
        if d == 1 % edges
            deg(idx) = sum(obj.A2(node(idx), :));
        else % triangles
            deg(idx) = sum(obj.A3(node(idx), :, :), 'all') / 2;
        end
    end
end
