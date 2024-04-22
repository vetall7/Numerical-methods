function [xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,fun)
    % a - lewa granica przedziau poszukiwa miejsca zerowego (x0=a)
    % b - prawa granica przedziau poszukiwa miejsca zerowego (x1=b)
    % max_iterations - maksymalna liczba iteracji dziaania metody siecznych
    % ytolerance - warto abs(fun(xsolution)) powinna by mniejsza ni ytolerance
    % fun - nazwa funkcji, której miejsce zerowe bdzie wyznaczane
    %
    % xsolution - obliczone miejsce zerowe
    % ysolution - warto fun(xsolution)
    % iterations - liczba iteracji wykonana w celu wyznaczenia xsolution
    % xtab - wektor z kolejnymi kandydatami na miejsce zerowe, poczwszy od x2
    % xdiff - wektor wartoci bezwzgldnych z rónic pomidzy i-tym oraz (i+1)-ym elementem wektora xtab; xdiff(1) = abs(xtab(2)-xtab(1));
    
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

format long
f = @(x) x.^2 - 4.01;
a = 0;
b = 4;
max_iterations = 100;
ytolerance = 1e-12;
[xsolution,ysolution,iterations,xtab,xdif] = secant_method(a,b,max_iterations,ytolerance,f)