function velocity_delta = rocket_velocity(t)
% velocity_delta - różnica pomiędzy prędkością rakiety w czasie t oraz zadaną prędkością M
% t - czas od rozpoczęcia lotu rakiety dla którego ma być wyznaczona prędkość rakiety

if t <= 0
    error("t must be > 0");
end

M = 750; % [m/s]
u = 2000;
q = 2700;
m = 150000;
g = 1.622;

V = u*log(m/(m-q*t)) - g*t;


velocity_delta = V - M; 

end



valocity_data = rocket_velocity(5)