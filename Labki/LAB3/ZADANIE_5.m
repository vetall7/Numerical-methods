function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N)
    index_number = 196633;
    L1 = 3;
    [A, b] = generate_matrix(N, L1);
    x = ones(N, 1);
    U = triu(A, 1);
    D = diag(diag(A));
    L = tril(A, -1);
    M = -(D+L)\U; 
    bm = (D+L)\b;
    
    err_norm = 1;
    tic
    for iterations = 1:1000
        x = M*x + bm;
        err_norm = norm(A*x-b);
        if err_norm <= 1e-12
            break;
        end
    end
    time = toc;
end

function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Jacobi(N)
    index_number = 196633;
    L1 = 3;
    [A, b] = generate_matrix(N, L1);
    x = ones(N, 1);
    U = triu(A, 1);
    D = diag(diag(A));
    L = tril(A, -1);
    M = -inv(D)*(L+U);
    bm = inv(D)*b;
    
    err_norm = 1;
    tic
    for iterations = 1:1000
        x = M*x + bm;
        err_norm = norm(A*x-b);
        if err_norm <= 1e-12
            break;
        end
    end
    time = toc;
end

function plot_problem_5(N, vtime_Jacobi, vtime_Gauss_Seidel, iter_Jacobi, iter_Gauss_Seidel)
    figure;
    
    subplot(2,1,1);
    plot(N, vtime_Jacobi);
    hold on;
    plot(N, vtime_Gauss_Seidel);
    hold off;
    title('Time vs Matrix Size');
    xlabel('Matrix Size');
    ylabel('Time (s)');
    legend('Jacobi Method', 'Gauss-Seidel Method', 'Location', 'eastoutside');
    
    subplot(2,1,2);
    bar_data = [iter_Jacobi', iter_Gauss_Seidel'];
    bar(N, bar_data);
    title('Iterations vs Matrix Size');
    xlabel('Matrix Size');
    ylabel('Iterations');
    legend('Jacobi Method', 'Gauss-Seidel Method', 'Location', 'eastoutside');
    print -dpng zadanie5.png
end




N = 1000:1000:8000;
n = length(N);
time_Jacobi = ones(1,n);
time_Gauss_Seidel = 2*ones(1,n);
iterations_Jacobi = 40*ones(1,n);
iterations_Gauss_Seidel = 40*ones(1,n);

for i = 1:length(N)
    [A, b, M, bm, x, err_norm, time, iterations, index_number] = solve_Jacobi(N(i));
    time_Jacobi(i) = time;
    iterations_Jacobi(i) = iterations;
end

for i = 1:length(N)
    [A, b, M, bm, x, err_norm, time, iterations, index_number] = solve_Gauss_Seidel(N(i));
    time_Gauss_Seidel(i) = time;
    iterations_Gauss_Seidel(i) = iterations;
end

plot_problem_5(N, time_Jacobi, time_Gauss_Seidel, iterations_Jacobi, iterations_Gauss_Seidel);