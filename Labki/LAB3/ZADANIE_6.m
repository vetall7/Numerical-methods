load("filtr_dielektryczny.mat");

% Solve using direct method
[time_direct, err_direct] = solve_direct(A, b);
disp( "Error for direct method: " + err_direct);
disp("Time taken for direct method: " + time_direct);

% Solve using Jacobi method
[err_Jacobi, time_Jacobi, iterations_Jacobi, err_norm_Jacobi] = solve_Jacobi(A, b);
disp( "Error for Jacobi method: " + err_Jacobi);
disp("Time taken for Jacobi method: " + time_Jacobi);
disp("Number of iterations taken for Jacobi method: " + iterations_Jacobi);

% Plotting residual error for Jacobi method
figure;
plot(1:iterations_Jacobi, err_norm_Jacobi);
title('Residual Error for Jacobi Method');
xlabel('Iteration');
ylabel('Residual Error');
grid on;

% Solve using Gauss Seidel method
[err_Gauss_Seidel, time_Gauss_Seidel, iterations_Gauss_Seidel, err_norm_Gauss_Seidel] = solve_Gauss_Seidel(A, b);
disp( "Error for Gauss Seidel method: " + err_Gauss_Seidel);
disp("Time taken for Gauss Seidel method: " + time_Gauss_Seidel);
disp("Number of iterations taken for Gauss Seidel method: " + iterations_Gauss_Seidel);

% Plotting residual error for Gauss Seidel method
figure;
plot(1:iterations_Gauss_Seidel, err_norm_Gauss_Seidel);
title('Residual Error for Gauss Seidel Method');
xlabel('Iteration');
ylabel('Residual Error');
grid on;

function [time_direct,err_norm] = solve_direct(A, b)
    tic
    x = A\b;
    time_direct = toc;
    err_norm = norm(A*x - b);
end

function [err_norm,time,iterations,err_norm_history] = solve_Jacobi(A, b)
    x = ones(size(A, 1), 1);
    U = triu(A, 1);
    D = diag(diag(A));
    L = tril(A, -1);
    M = -inv(D)*(L+U);
    bm = inv(D)*b;
    
    err_norm = 1;
    err_norm_history = ones(1000, 1); % Preallocate memory for error history
    tic
    for iterations = 1:1000
        x = M*x + bm;
        err_norm = norm(A*x-b);
        disp(err_norm);
        err_norm_history(iterations) = err_norm; % Store error at each iteration
        %disp(err_norm_history)
        if err_norm <= 1e-12
            break;
        end
    end
    disp(err_norm_history);
    time = toc;
end

function [err_norm,time,iterations,err_norm_history] = solve_Gauss_Seidel(A, b)
    x = ones(size(A, 1), 1);
    U = triu(A, 1);
    D = diag(diag(A));
    L = tril(A, -1);
    M = -(D+L)\U; 
    bm = (D+L)\b;
    
    err_norm = 1;
    err_norm_history = zeros(1000, 1); % Preallocate memory for error history
    tic
    for iterations = 1:1000
        x = M*x + bm;
        err_norm = norm(A*x-b);
        disp(err_norm);
        err_norm_history(iterations) = err_norm; % Store error at each iteration
        if err_norm <= 1e-12
            break;
        end
    end
    time = toc;
end
