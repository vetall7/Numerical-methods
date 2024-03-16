function [numer_indeksu, Edges, I, B, A, b, r] = page_rank()
    numer_indeksu = 196633;
    N = 8;
    Edges = [1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5, 6, 6, 7, 8, 7;
             4, 6, 3, 4, 5, 5, 6, 7, 5, 6, 4, 6, 4, 7, 6, 4, 8];
    I = speye(N);
    B = sparse(Edges(2,:), Edges(1,:), 1, N, N);

    L = sum(B).';
    disp(L);
    A = spdiags(1 ./ L, 0, N, N);
    
    d = 0.85;
    b = ((1 - d) / N) * ones(N, 1);
    M = I - d*B*A;
    r = M\b;
end