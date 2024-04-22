a = 1;
b = 60000;
ytolerance = 1e-12;
max_iterations = 100;


[n_bisection, ~, ~, xtab_b, xdif_b] = bisection_method(a, b, max_iterations, ytolerance, @estimate_execution_time)
[n_secant, ~, ~, xtab_s, xdif_s] = secant_method(a, b, max_iterations, ytolerance, @estimate_execution_time)


% Tworzenie górnego wykresu
figure;
subplot(2,1,1);
plot(1:numel(xtab_b), xtab_b, 'b-', 1:numel(xtab_s), xtab_s, 'r--');
xlabel('Iterations');
ylabel('Omega');
title('Change of Omega with Iterations (Linear Scale)');
legend('Bisection Method', 'Secant Method');

% Tworzenie dolnego wykresu
subplot(2,1,2);
semilogy(1:numel(xdif_b), xdif_b, 'b-', 1:numel(xdif_s), xdif_s, 'r--');
xlabel('Iterations');
ylabel('Delta Omega');
title('Difference in Omega between Iterations (Logarithmic Scale)');
legend('Bisection Method', 'Secant Method');
saveas(gcf, 'ZAD8.png');

function time_delta = estimate_execution_time(N)
% time_delta - różnica pomiędzy estymowanym czasem wykonania algorytmu dla zadanej wartości N a zadanym czasem M
% N - liczba parametrów wejściowych
M = 5000; % [s]

t = (N^(16/11) + N^((pi^2)/8))/1000;

time_delta = t - M;

end


function [xsolution,ysolution,iterations,xtab,xdif] = bisection_method(a,b,max_iterations,ytolerance,fun)
    
    xsolution = [];
    ysolution = [];
    xtab = (a+b)/2;
    xdif = [];

    for iteration = 2:max_iterations
        if abs(fun(xtab(end))) < ytolerance
            xsolution = xtab(end);
            ysolution = fun(xsolution);
            break;
        elseif fun(a)*fun(xtab(end)) < 0
            b = xtab(end);
        else 
            a = xtab(end);
        end
        
        xtab = [xtab; (a+b)/2];
        xdif = [xdif; abs(xtab(end) - xtab(end-1))];
    end
    iterations = iteration-1;
end


function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)

xsolution = [];
ysolution = [];
iterations = [];
xtab = [a; b];
xdif = abs(xtab(2) - xtab(1));

for iteration = 3:max_iterations
    xsolution = xtab(iteration-1) - ((fun(xtab(iteration-1))*(xtab(iteration-1) - xtab(iteration-2)))/(fun(xtab(iteration-1))-fun(xtab(iteration-2))));
    ysolution = fun(xsolution);
    xtab = [xtab; xsolution];
    xdif = [xdif; abs(xtab(iteration) - xtab(iteration-1))];
    if abs(ysolution) < ytolerance
        break
    end
end
xtab = xtab(3:end);
xdif = xdif(3:end);
iterations = iteration-2;

end
