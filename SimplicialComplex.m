classdef SimplicialComplex < handle
    properties
        N   % Number of nodes
        A2  % 1-Adjacency matrix (NxN)
        A3  % 2-Adjacency tensor (NxNxN)
    end

    methods (Access=private)
        generate_all_to_all(obj)
        generate_k_nearest(obj, k1, k2)
        generate_scale_free(obj, N0, m_tri, s)
        generate_erdos_renyi(obj, p, option)
        generate_linial_meshulam(obj, p)
        
        idx = circ_idx(obj, i)
    end
    methods
        % Constructor
        function obj = SimplicialComplex(N, A2, A3)
            if ~isscalar(N) || N <= 0 || floor(N) ~= N
                error('N must be a positive integer scalar.');
            end

            if (nargin == 1)
                obj.N = N;
                obj.A2 = zeros(N,N);
                obj.A3 = zeros(N,N,N);
            elseif (nargin == 3)
                if ~isequal(size(A2), [N, N])
                    error('A2 must be an NxN matrix.');
                end
                if ~isequal(size(A3), [N, N, N])
                    error('A3 must be an NxNxN tensor.');
                end
                obj.N = N;
                obj.A2 = A2;
                obj.A3 = A3;
            else
                error('Invalid number of input arguments. Provide either N or N, A2, A3.');
            end
        end

        obj = Add1Edge(obj, n1, n2)
        obj = Add2Edge(obj, n1, n2, n3)
        obj = Remove2Edge(obj, n1, n2, n3)
        obj = Remove1Edge(obj, n1, n2)
        GenerateAdjacency(obj, method, varargin)
        hAx = DrawGraph(obj, varargin)
        deg = NodeDegree(obj, node, d)
        edges = Get1Simplices(obj)
        triangles = Get2Simplices(obj)

        % % Setter for A2
        % function set.A2(obj, value)
        %     % Check dimensions
        %     if ~isequal(size(value), [obj.N, obj.N])
        %         error('A2 must be an NxN matrix where N is the number of nodes.');
        %     end
        % 
        %     % Check that values are binary (0 or 1)
        %     if ~all(ismember(value(:), [0, 1]))
        %         error('A2 must contain only 0s and 1s.');
        %     end
        % 
        %     % Check for symmetry: A2(i, j) must equal A2(j, i)
        %     if ~isequal(value, value.')
        %         error('A2 must be symmetric.');
        %     end
        % 
        %     % If all checks pass, set the value
        %     obj.A2 = value;
        % end
        % 
        % % Setter for A3
        % function set.A3(obj, value)
        %     % Check dimensions
        %     if ~isequal(size(value), [obj.N, obj.N, obj.N])
        %         error('A3 must be an NxNxN tensor where N is the number of nodes.');
        %     end
        % 
        %     % Check that values are binary (0 or 1)
        %     if ~all(ismember(value(:), [0, 1]))
        %         error('A3 must contain only 0s and 1s.');
        %     end
        % 
        %     % Check for symmetry across all permutations
        %     for i = 1:obj.N
        %         for j = i+1:obj.N
        %             for k = j+1:obj.N
        %                 if value(i, j, k) ~= value(j, i, k) || ...
        %                    value(i, j, k) ~= value(k, i, j) || ...
        %                    value(i, j, k) ~= value(k, j, i) || ...
        %                    value(i, j, k) ~= value(j, k, i)
        %                     error('A3 must be symmetric across all permutations of indices.');
        %                 end
        %             end
        %         end
        %     end
        % 
        %     % If all checks pass, set the value
        %     obj.A3 = value;
        % end




    end
end