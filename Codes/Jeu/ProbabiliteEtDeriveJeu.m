n = 20;  % Nombre d'états
p_values = 0.5:0.01:1.0;  % Valeurs que va prendre p (p va de 0.5 à 1 par incrémentation de 0.01)
prob_victoire_A = zeros(size(p_values));  % Tableau pour stocker les probabilités de victoire de A

% Vecteur état initial pour le score 0-0 (S0)
v0 = zeros(n, 1);
v0(1) = 1;

% Pour chaque valeur de p
for i = 1:length(p_values)
    p = p_values(i);
    % Matrice de transition T
    T = [
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S0
        p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S1
        1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S2
        0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S3
        0,   1-p, p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S4
        0,   0,   1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S5
        0,   0,   0,   0,   0,   0,   0,   p,   1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S6
        0,   0,   0,   0,   1-p, p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S7
        0,   0,   0,  1-p,  p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S8
        0,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S9
        0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S10
        0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S11
        0,   0,   0,   0,   0,   0,   0,   0,   p, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S12
        0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0;  % S13
        0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0;  % S14
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   p,   0,   p,  1-p,  0,   0;  % S15
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0;  % S16 
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0;  % S17 
        0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   p,   p,   0,   0,   0,   p,   1,   0;  %SF1 (victoire de A)
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p, 1-p,   0,   0, 1-p,   0, 1-p,   0,   0,   1;  %SF2
    ];

 % Calcul des probabilités finales après un grand nombre de transitions
    T_long_term = T^100;
    proba_finale = T_long_term * v0;
    
    % Stocke la probabilité de gagner un jeu pour A
    prob_victoire_A(i) = proba_finale(19);  % Probabilité d'atteidre l'état SF1 et donc de gagner le jeu pour le joueur A
end

% Graphique traçant la probabilité de gagner un jeu en fonction de p
figure;
plot(p_values, prob_victoire_A, '-o');
xlabel('Probabilité p de gagner un point');
ylabel('Probabilité de victoire du joueur A');
title('Probabilité de victoire du joueur A en fonction de p');
grid on;

% Calcul de la dérivée numérique
dp = diff(prob_victoire_A) ./ diff(p_values);

% Graphique de la dérivée
figure;
plot(p_values(1:end-1), dp, '-o');
xlabel('Probabilité p de gagner un point');
ylabel('Variation de la probabilité de victoire (dP/dp)');
title('Effet amplificateur de p sur la probabilité de victoire');
grid on;
