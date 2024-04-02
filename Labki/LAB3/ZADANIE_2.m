function [A,b,x,time_direct,err_norm,index_number] = solve_direct(N)
    index_number = 196633;
    L1 = 3;
    [A, b] = generate_matrix(N, L1);
    
    tic
    x = A\b;
    time_direct = toc;
    err_norm = norm(A*x - b);
end

function plot_direct(N, vtime_direct)
    figure;
    plot(N, vtime_direct, 'b.-', 'LineWidth', 1.5, 'MarkerSize', 15);
    xlabel('Matrix Size (N)');
    ylabel('Time (seconds)');
    title('Time vs. Matrix Size');
    grid on;
    %print -dpng zadanie2.png 
end


N = 1000:1000:8000;

n = length(N);
vtime_direct = ones(1,n);

for i = 1:length(N)
    [~, ~, ~, vtime_direct(i)] = solve_direct(N(i));
end

plot_direct(N, vtime_direct);

