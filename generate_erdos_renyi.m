function generate_erdos_renyi(obj, p, varargin)
% 2-simplices with probability p. No 1-simplices not supporting a triangle
    arguments
        obj
        p (1,1) {mustBeInRange(p,0,1)} = 0
    end
    arguments (Repeating)
        varargin
    end
    edgesOnlyFlag = false;

    if (nargin > 2) && strcmpi(varargin{1}, 'edgesonly')
        edgesOnlyFlag = true;
    end

    % if edgesOnlyFlag % only 1-edges
    %     edges = nchoosek(1:obj.N,2);
    %     if (p ~= 0)
    %         for i = 1:size(edges,1)
    %             if rand < p
    %                 obj.Add1Edge(edges(i,1), edges(i,2))
    %             end
    %         end
    %     end
    % else
        triangles = nchoosek(1:obj.N, 3);
        if (p ~= 0)
            for i = 1:size(triangles,1)
                if rand < p
                    obj.Add2Edge(triangles(i,1), triangles(i,2), triangles(i,3))
                    if edgesOnlyFlag
                        obj.Remove2Edge(triangles(i,1), triangles(i,2), triangles(i,3))
                    end
                end
            end
        end
    % end

    


    
end