function generate_scale_free(obj, N0, m_tri, s)
    arguments
        obj
        N0 (1,1) {mustBeInteger, mustBeGreaterThanOrEqual(N0, 3)}
        m_tri (1,1)
        s (1,1) {mustBeMember(s,[0 1])} = 0
    end

    % initial clique of size N0
    %obj.A2(1:N0, 1:N0) = ones(N0) - eye(N0);

    for i = 1:(N0-2)
        for j = (i+1):(N0-1)
            for k = (j+1):N0
                obj.Add2Edge(i,j,k);
            end
        end
    end

    % existingEdges = nchoosek(1:N0, 2);

    % for each node not in the starting clique
    for i = (N0+1):obj.N
        % select m_tri (not pairwise adjacent) edges and form a triangle
        % with its nodes
        selectedEdges = select_edges(obj, m_tri, s);
        for newTri = 1:m_tri
            obj.Add2Edge(i, selectedEdges(newTri, 1), selectedEdges(newTri, 2));
            % existingEdges = [existingEdges; [i, selectedEdges(newTri, 1), selectedEdges(newTri, 2)]];
        end
    end


end
    

function edges = select_edges(obj, m_tri, s)
    edges = zeros(m_tri, 2);
    existingEdges = obj.Get1Simplices;
    edgesIdxs = 1:size(existingEdges,1);

    
    if (s == 0) % non preferential
        t = 1;
        while (t <= m_tri)
            if isscalar(edgesIdxs)
                ed = edgesIdxs;
            else
                ed = randsample(edgesIdxs,1);
            end
            edgesIdxs(edgesIdxs == ed) = [];
            if (any(ismember(existingEdges(ed, :), edges)))
                continue;
            end
            edges(t, :) = existingEdges(ed, :);
            t = t + 1;
        end
        
    else
        % TODO
        error('Yet to implement')
    end
end