function generate_scale_free(obj, N0, m_tri, s)
    arguments
        obj
        N0 (1,1) {mustBeInteger, mustBeGreaterThanOrEqual(N0, 3)}
        m_tri (1,1)
        s (1,1) {mustBeMember(s,[0 1])} = 0
    end

    % check if there are enough nodes in the initial clique to generate
    % m_tri triangles at each step
    if (N0 < 2*m_tri +1)
        error("Initial clique is too small for selected m_tri")
    end

    % initial clique of size N0

    for i = 1:(N0-2)
        for j = (i+1):(N0-1)
            for k = (j+1):N0
                obj.Add2Edge(i,j,k);
            end
        end
    end


    % for each node not in the starting clique
    for i = (N0+1):obj.N
        % select m_tri (not pairwise adjacent) edges and form a triangle
        % with its nodes
        selectedEdges = select_edges(obj, m_tri, s);
        for newTri = 1:m_tri
            obj.Add2Edge(i, selectedEdges(newTri, 1), selectedEdges(newTri, 2));
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
        
    else        % preferential
        % TODO
        % number of triangles edge ij belongs to
        TntriaEd = triu(obj.A2 .* (obj.A2^2));
        % find the indices of edges forming triangles
        [i, j] = find(TntriaEd > 0);
        k = TntriaEd > 0;
        % computing the cumulative probability distribution
        plink = [i j TntriaEd(k)];
        pcum = [0; cumsum((plink(:,3)) ./ sum(plink(:,3)))];
        % apply inverse transform sampling
        while (true)
            r = rand(m_tri, 1);
            d = pcum' - r;
            temp = diff(sign(d),1,2);
            [~, idx] = find(temp);
            % plink(idx,1:2)
            if (length(unique(plink(idx,1:2)))==2*m_tri)
                edges(:,:) = plink(idx, 1:2);
                break;
            end
        end

    end
end