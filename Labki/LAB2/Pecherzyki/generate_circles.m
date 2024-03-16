function [circles, index_number, circle_areas, rand_counts, counts_mean] = generate_circles(a, r_max, n_max)
    index_number = 196633; % numer Twojego indeksu
    L1 = mod(index_number, 10);
    rand_counts = ones(n_max, 1);
    counts_mean = zeros(n_max, 1);
    if mod(L1, 2) == 0
        circles = zeros(n_max, 3);
        circle_areas = zeros(1, n_max);
    else
        circles = zeros(3, n_max);
        circle_areas = zeros(n_max, 1);
    end
    
    for i = 1:n_max 
        R = rand()*r_max;
        X = rand()*(a - 2*R) + R;
        Y = rand()*(a - 2*R) + R;

        if mod(L1, 2) == 0
            while check_intersection(circles(1:i-1, :), X, Y, R, true)
                R = rand()*r_max;
                X = rand()*(a - 2*R) + R;
                Y = rand()*(a - 2*R) + R;
                rand_counts(i) = rand_counts(i) + 1;
            end
            circles(i, :) = [X, Y, R];
            circle_areas(:, i) = pi*R*R;
        else
            while check_intersection(circles(:, 1:i-1), X, Y, R, false)
                R = rand()*r_max;
                X = rand()*(a - 2*R) + R;
                Y = rand()*(a - 2*R) + R;
                rand_counts(i) = rand_counts(i) + 1;
            end
            circles(:, i) = [R, X, Y];
            circle_areas(i, :) = pi*R*R;
        end
        counts_mean(i) = mean(rand_counts(1:i));
    end
    circle_areas = cumsum(circle_areas());
end


function is_intersected = check_intersection(current_circles, X, Y, R, is_vertical_matrix)
    is_intersected = false;
    if is_vertical_matrix
        for j = 1:size(current_circles, 1)
            if sqrt((X - current_circles(j, 1))^2 + (Y - current_circles(j, 2))^2) < R + current_circles(j, 3)
                is_intersected = true;
                break;
            end
        end
    else
        for j = 1:size(current_circles, 2)
            if sqrt((X - current_circles(2, j))^2 + (Y - current_circles(3, j))^2) < R + current_circles(1, j)
                is_intersected = true;
                break;
            end
        end
    end
end