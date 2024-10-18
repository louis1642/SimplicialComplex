function hAx = DrawGraph(obj, varargin)
% DrawGraph - Visualize the simplicial complex as a graph with nodes, edges, and triangles.
%
% Syntax:
%   obj.DrawGraph();
%   hAx = obj.DrawGraph('force');
%   hAx = obj.DrawGraph('focus', focusNode);
%
% Description:
%   This function plots the simplicial complex up to 10 nodes
%   It plots nodes, 1-simplices (edges), and 2-simplices (triangles)
%   displayed on a circular layout. It allows for the visualization 
%   of the graph, with optional highlighting of 2-simplices associated with a specific node.
%   Additionally, the function can be forced to plot even for larger 
%   graphs (N>10) by using the 'force' option.
%
% Inputs:
%   'force'   - (optional) If provided, the function will force the drawing of the graph
%               even if the number of nodes (N) is 10 or greater.
%
%   'focus'   - (optional) Specifies a node number to focus on. Triangles involving this node 
%               will be highlighted. If no node is specified, the function defaults to focusing on node 1.
%
% Outputs:
%   hAx       - (optional) Handle to the axis object where the graph is plotted.
%

    forceFlag = false;
    focusFlag = false;
    focusNode = 1; % Default focus node
    if nargin > 1
        for i = 1:length(varargin)
            if strcmp(varargin{i}, 'force')
                forceFlag = true;
            elseif strcmp(varargin{i}, 'focus')
                focusFlag = true;
                % Check if a focus node is provided
                if i + 1 <= length(varargin) && isnumeric(varargin{i+1})
                    focusNode = varargin{i+1};
                end
            end
        end
    end
    
    % Check if N <= 10 or 'force' is provided
    if obj.N <= 10 || forceFlag
        % Proceed with drawing the graph
        theta = linspace(0, 2*pi, obj.N+1);  % Angular position of nodes in a circle
        x = cos(theta(1:end-1));
        y = sin(theta(1:end-1));
    
        % Create figure and axis
        hFig = figure;
        hAx = axes('Parent', hFig);
        hold(hAx, 'on');
    
        % Plot 1-simplices (edges) - red lines
        [row, col] = find(triu(obj.A2));  % Find upper triangular nonzero elements
        for k = 1:length(row)
            plot(hAx, [x(row(k)), x(col(k))], [y(row(k)), y(col(k))], 'r-', 'LineWidth', 1.5);
        end
    
        % Plot 2-simplices (triangles) - random colors, bordered, and transparent
        for i = 1:obj.N
            for j = i+1:obj.N
                for k = j+1:obj.N
                    if obj.A3(i, j, k) == 1
                        % Calculate the centroid of the triangle
                        centroidX = mean([x(i), x(j), x(k)]);
                        centroidY = mean([y(i), y(j), y(k)]);
    
                        % Apply a random scaling factor for each triangle
                        randomScaleFactor = 0.65 + 0.3 * rand;  % Random value between 0.65 and 0.95
    
                        % Scale the vertices toward the centroid
                        scaledX = centroidX + randomScaleFactor * ([x(i), x(j), x(k)] - centroidX);
                        scaledY = centroidY + randomScaleFactor * ([y(i), y(j), y(k)] - centroidY);
    
                        % Generate random color for each triangle
                        randomColor = rand(1, 3);
    
                        % Determine face alpha based on focus node
                        if focusFlag
                            if i == focusNode || j == focusNode || k == focusNode
                                faceAlphaValue = 0.85;
                            else
                                faceAlphaValue = 0.1;
                            end
                        else
                            faceAlphaValue = 0.3; % Default for all triangles if no focus
                        end
    
                        % Plot triangle with random color, transparent, and black border
                        fill(hAx, scaledX, scaledY, randomColor, ...
                            'FaceAlpha', faceAlphaValue, 'EdgeColor', 'k', 'LineWidth', 0.5);
                    end
                end
            end
        end
    
        % Plot nodes - larger black circles
        plot(hAx, x, y, 'ko', 'MarkerFaceColor', 'k', 'MarkerSize', 12);
    
        % Annotate nodes
        for i = 1:obj.N
            text(hAx, x(i), y(i), num2str(i), 'HorizontalAlignment', 'center', ...
                'VerticalAlignment', 'middle', 'Color', 'w');
        end
    
        % Set axis properties
        axis(hAx, 'equal');
        axis(hAx, 'off');
        hold(hAx, 'off');
    
        % Only return the axis handle if an output is requested
        if nargout == 0
            clear hAx;  % Clear the output if no output is requested
        end
    
    else
        warning("N is too large to draw the graph. Use 'force' to override.");
        return;
    end
end
