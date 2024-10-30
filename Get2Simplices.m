function triangles = Get2Simplices(obj)
% Get2Simplices - Returns a matrix where each row contains the three nodes forming a 2-simplex.
%
% Syntax:
%   triangles = obj.Get2Simplices();
%
% Description:
%   This function extracts the 2-simplices (triangles) from the adjacency tensor A3.
%   Each row of the output matrix contains the three nodes that form a 2-simplex.
%
% Outputs:
%   triangles - A matrix where each row contains three nodes forming a 2-simplex.
%               The matrix has dimensions [M x 3], where M is the number of triangles.
%

    % Preallocate a matrix for the maximum number of possible triangles
    maxTriangles = nchoosek(obj.N, 3);  % Maximum number of 2-simplices (triangles)
    triangles = zeros(maxTriangles, 3);  % Preallocate with zeros
    
    % Counter for the actual number of triangles
    count = 0;
    
    % Loop through each combination of three nodes (i, j, k)
    for i = 1:obj.N
        for j = i+1:obj.N
            for k = j+1:obj.N
                % Check if the 2-simplex (triangle) exists
                if obj.A3(i, j, k) == 1
                    % Increment the counter
                    count = count + 1;
                    
                    % Store the triangle in the preallocated matrix
                    triangles(count, :) = [i, j, k];
                end
            end
        end
    end
    
    % Trim the matrix to remove unused rows
    triangles = triangles(1:count, :);
end
