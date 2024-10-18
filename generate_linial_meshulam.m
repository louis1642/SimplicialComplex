function generate_linial_meshulam(obj, p)
% 1-simplices all-to-all, 2-simplices with probability p
    arguments
        obj
        p (1,1) {mustBeInRange(p, 0, 1)}
    end

    % 1-simplices all-to-all
    for i = 1:obj.N
        for j = (i+1):obj.N
            obj.Add1Edge(i,j);
        end
    end

    % 2-simplices with prob p
    if (p ~= 0)
    triangles = nchoosek(1:obj.N, 3);
        for i = 1:size(triangles,1)
            if rand < p
                obj.Add2Edge(triangles(i,1), triangles(i,2), triangles(i,3))
            end
        end
    end

end
