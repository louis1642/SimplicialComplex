function GenerateAdjacency(obj, method, varargin)
    switch method
        case {'alltoall','all'}
            generate_all_to_all(obj);
        
        case {'knearest','k','knn'}
            if length(varargin) < 1
                error('generate_k_nearest requires k1 or k1 and k2 as additional arguments.');
            end
            k1 = varargin{1};
            k2 = varargin{end};
            generate_k_nearest(obj, k1, k2);
        
        case {'scalefree','sf'}
            if length(varargin) < 2
                error('generate_scale_free requires N0, m_tri, and s as additional arguments.');
            end
            N0 = varargin{1};
            m_tri = varargin{2};
            if length(varargin) == 3
                s = varargin{3};
                generate_scale_free(obj, N0, m_tri, s);
            else
                generate_scale_free(obj, N0, m_tri);
            end

        
        case {'erdosrenyi','erdos','er'}
            if length(varargin) < 1
                error('generate_erdos_renyi requires probability p as additional argument.');
            end
            p = varargin{1};
            if length(varargin) < 2
                generate_erdos_renyi(obj, p);
            else
                generate_erdos_renyi(obj, p, varargin{2})
            end

        case {'linialmeshulam','linial','lm'}
            if length(varargin) < 1
                error('generate_linial_meshulam requires probability p as additional argument.')
            end
            p = varargin{1};
            generate_linial_meshulam(obj,p);
        
        otherwise
            error('Invalid method specified. Choose from ''alltoall'', ''knearest'', ''scalefree'', ''erdosrenyi'', or ''linialmeshulam''.');
    end
end
