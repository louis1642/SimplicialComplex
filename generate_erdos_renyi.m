function generate_erdos_renyi(obj, p, option)
%GENERATE_ERDOS_RENYI Generates an Erdős-Rényi graph with specified options.
%
%   generate_erdos_renyi(obj, p)
%   generate_erdos_renyi(obj, p, option)
%
%   Inputs:
%       obj     - The object instance containing graph properties.
%       p       - Probability for edge or simplex creation (0 <= p <= 1).
%       option  - (Optional) String specifying the generation mode:
%                 'edgesonly' - Adds 2-simplices and then removes them, effectively keeping only edges.
%                 '1d'        - Adds 1-simplices (edges) based on probability p
%

    arguments
        obj
        p (1,1) {mustBeNumeric, mustBeNonnegative, mustBeLessThanOrEqual(p, 1)} = 0
        option (1,1) string {mustBeMember(option, ["", "edgesonly", "1d"])} = ""
    end

    switch lower(option)
        case "edgesonly"
            % Option: 'edgesonly'
            % Adds 2-simplices (triangles) based on probability p,
            % then removes them to retain only edges.

            triangles = nchoosek(1:obj.N, 3);
            if p > 0
                for i = 1:size(triangles, 1)
                    if rand < p
                        obj.Add2Edge(triangles(i, 1), triangles(i, 2), triangles(i, 3));
                        obj.Remove2Edge(triangles(i, 1), triangles(i, 2), triangles(i, 3));
                    end
                end
            end

        case "1d"
            % Option: '1d'
            % Adds 1-simplices (edges) based on probability p.
            edges = nchoosek(1:obj.N, 2);
            if p > 0
                for i = 1:size(edges, 1)
                    if rand < p
                        obj.Add1Edge(edges(i, 1), edges(i, 2));
                    end
                end
            end

        otherwise
            % No option provided: Default behavior.
            % Generates 2-simplices (triangles) based on probability p.
            triangles = nchoosek(1:obj.N, 3);
            if p > 0
                for i = 1:size(triangles, 1)
                    if rand < p
                        obj.Add2Edge(triangles(i, 1), triangles(i, 2), triangles(i, 3));
                    end
                end
            end
    end
end

% % % % % % % % % % % % % % OLD CODE % % % % % % % % % % % % % % % % % % %
% % % function generate_erdos_renyi(obj, p, varargin)
% % % % 2-simplices with probability p. 1-simplices only supporting the triangles
% % %     arguments
% % %         obj
% % %         p (1,1) {mustBeInRange(p,0,1)} = 0
% % %     end
% % %     arguments (Repeating)
% % %         varargin
% % %     end
% % %     edgesOnlyFlag = false;
% % % 
% % %     if (nargin > 2) && strcmpi(varargin{1}, 'edgesonly')
% % %         edgesOnlyFlag = true;
% % %     end
% % % 
% % %     % if edgesOnlyFlag % only 1-edges
% % %     %     edges = nchoosek(1:obj.N,2);
% % %     %     if (p ~= 0)
% % %     %         for i = 1:size(edges,1)
% % %     %             if rand < p
% % %     %                 obj.Add1Edge(edges(i,1), edges(i,2))
% % %     %             end
% % %     %         end
% % %     %     end
% % %     % else
% % %         triangles = nchoosek(1:obj.N, 3);
% % %         if (p ~= 0)
% % %             for i = 1:size(triangles,1)
% % %                 if rand < p
% % %                     obj.Add2Edge(triangles(i,1), triangles(i,2), triangles(i,3))
% % %                     if edgesOnlyFlag
% % %                         obj.Remove2Edge(triangles(i,1), triangles(i,2), triangles(i,3))
% % %                     end
% % %                 end
% % %             end
% % %         end
% % %     % end
% % % 
% % % end