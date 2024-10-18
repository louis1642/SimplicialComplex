function generate_all_to_all(obj)
    % Loop through all combinations of i, j, k where i < j < k
    for i = 1:obj.N
        for j = i+1:obj.N
            for k = j+1:obj.N
                % Set the corresponding elements in the tensor
                obj.Add2Edge(i,j,k);
            end
        end
    end
    % obj.A2 = ones(obj.N) - eye(obj.N); % not needed, A2 is updated by Add2Edge()
end