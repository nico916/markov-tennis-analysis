p_values = 0.5:0.01:1.0;
prob_22 = zeros(size(p_values));  % Probabilité d'atteindre 2-2 pour chaque p
for i = 1:length(p_values)
    p = p_values(i);
    T = [
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0, 1-p, p,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0, 1-p, 0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,  1-p,  p,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   1-p, p,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0, 1-p,   p,   0,   0,   0;
        0,   0,   0,   p,   0,   0,   p,   0,   p,   1,   0;
        0,   0,   0,   0,   0, 1-p,   0, 1-p, 1-p,   0,   1;
    ];
    v = zeros(11, 1);
    v(1) = 1;

    % Calculer la probabilité d'atteindre le 2-2 en itérant T
    iterations = 100;
    prob_22_actuelle = 0; 
    for k = 1:iterations
        v = T * v;
        prob_22_actuelle = prob_22_actuelle + v(9);
    end 
    prob_22(i) = prob_22_actuelle;
end

% Graphique de la probabilité d'atteindre le score de 2-2 en fonction de p
figure;
plot(p_values, prob_22, '-o');
xlabel('Probabilité p de gagner un point');
ylabel('Probabilité d''atteindre 2-2');
title('Probabilité d''atteindre 2-2 en fonction de p');
grid on;