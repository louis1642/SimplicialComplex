function edges = Get1Simplices(obj)
% Get1Simplices - Returns a matrix where each row contains the two nodes forming a 1-simplex.
%
% Syntax:
%   edges = obj.Get1Simplices();
%
% Description:
%   This function extracts the 1-simplices (edges) from the adjacency matrix A2.
%   Each row of the output matrix contains the two nodes that form a 1-simplex.
%
% Outputs:
%   edges    - A matrix where each row contains two nodes forming a 1-simplex.
%              The matrix has dimensions [M x 2], where M is the number of edges.
%

    % Find the indices of the upper triangular part of A2 where there are edges (1-simplices)
    [row, col] = find(triu(obj.A2));  % Extract upper triangular indices of non-zero elements
    
    % Combine the row and column indices into a matrix
    edges = [row, col];
end