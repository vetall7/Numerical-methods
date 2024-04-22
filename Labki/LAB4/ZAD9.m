% Ustawienie opcji dla funkcji fzero
options = optimset('Display', 'iter');

% Znalezienie miejsc zerowych funkcji tan(x) dla dwóch różnych punktów startowych
x0_1 = 6.0;
x0_2 = 4.5;

% Użycie funkcji fzero dla pierwszego punktu startowego
x_solution_1 = fzero(@tan, x0_1, options);

% Użycie funkcji fzero dla drugiego punktu startowego
x_solution_2 = fzero(@tan, x0_2, options);
