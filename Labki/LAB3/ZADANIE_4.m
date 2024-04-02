function [A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(N)
    % A - macierz z równania macierzowego A * x = b
    % b - wektor prawej strony równania macierzowego A * x = b
    % M - macierz pomocnicza opisana w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje M jako M_J.
    % bm - wektor pomocniczy opisany w instrukcji do Laboratorium 3 – sprawdź wzór (5) w instrukcji, który definiuje bm jako b_{mJ}.
    % x - rozwiązanie równania macierzowego
    % err_norm - norma błędu residualnego wyznaczona dla rozwiązania x; err_norm = norm(A*x-b)
    % time - czas wyznaczenia rozwiązania x
    % iterations - liczba iteracji wykonana w procesie iteracyjnym metody Jacobiego
    % index_number - Twój numer indeksu
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
        disp(err_norm);
        if err_norm <= 1e-12
            break;
        end
    end
    time = toc;
    disp(iterations);
end


[A,b,M,bm,x,err_norm,time,iterations,index_number] = solve_Gauss_Seidel(100);