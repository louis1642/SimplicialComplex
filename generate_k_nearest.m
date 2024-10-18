function generate_k_nearest(obj, k1, k2)
    if nargin == 2
        k2 = k1;
    end
    if any([k1 k2] > obj.N-1)
        error("A graph with %d nodes can only support up to %d-nearest neighbors.", obj.N, obj.N-1)
    end
    if mod(k1, 2) ~= 0
        warning("Only even values of k1 are supported. Computing %d-nearest neighbors instead.", k1-1)
        k1 = k1 - 1;
    end
    if mod(k2, 2) ~= 0
        warning("Only even values of k2 are supported. Computing %d-nearest neighbors instead.", k2-1)
        k2 = k2 - 1;
    end



    for i = 1:obj.N
        for kk = 1:k1/2
            obj.Add1Edge(i, obj.circ_idx(i+kk))
        end

        if (k2 > 0)
            triangles = nchoosek([obj.circ_idx(i+1):obj.circ_idx(i+k2/2) obj.circ_idx(i-k2/2):obj.circ_idx(i-1)], 2);
    
            for tr = 1:size(triangles,1)
                obj.Add2Edge(i, triangles(tr,1), triangles(tr,2))
            end
        end
        
    end


end