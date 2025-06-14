p_values = 0.01:0.01:1.0;
prob_victoire_A = zeros(size(p_values));  % Probabilité de victoire de A pour chaque p après avoir atteint 40-40

for i = 1:length(p_values)
    p = p_values(i);
    T = [
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S0
        p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S1
        1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S2
        0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S3
        0, 1-p,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S4
        0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S5
        0,   0,   0,   0,   0,   0,   0,   p, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S6
        0,   0,   0,   0, 1-p,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S7
        0,   0,   0, 1-p,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S8
        0,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S9
        0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S10
        0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S11
        0,   0,   0,   0,   0,   0,   0,   0,   p, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S12
        0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0;  % S13
        0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0;  % S14
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   p,   0,   p, 1-p,   0,   0;  % S15 (40-40)
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0;  % S16 (40-A)
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0;  % S17 (A-40)
        0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   p,   p,   0,   0,   0,   p,   1,   0;  % SF1 (Victoire A)
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p, 1-p,   0,   0, 1-p,   0, 1-p,   0,   0,   1;  % SF2 (Victoire B)
    ];
    
    % Initialiser le vecteur état en commençant à "40-40" (S15)
    v = zeros(20, 1);
    v(16) = 1;

    % Itérer jusqu'à la convergence
    iterations = 100;
    for k = 1:iterations
        v = T * v;
    end
    prob_victoire_A(i) = v(19);
end

% Calcul de la dérivée
derivee = diff(prob_victoire_A) ./ diff(p_values);

% Graphiques
figure;
subplot(2, 1, 1);
plot(p_values, prob_victoire_A, '-o', 'DisplayName', 'Probabilité de victoire de A');
xlabel('Probabilité p de gagner un point');
ylabel('Probabilité de gagner le jeu');
title('Probabilité de gagner le jeu à partir de 40-40 pour A en fonction de p');
legend;
grid on;

subplot(2, 1, 2);
plot(p_values(1:end-1), derivee, '-o', 'DisplayName', 'Effet amplificateur');
xlabel('Probabilité p de gagner un point');
ylabel('Effet amplificateur (dérivée)');
title('Effet amplificateur de p sur la probabilité de victoire de A');
legend;
grid on;
