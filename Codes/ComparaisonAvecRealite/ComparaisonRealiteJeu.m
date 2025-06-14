joueurs = {'Nadal', 'Simon', 'Moutet'};
p_values = [0.544, 0.507, 0.486];  % Probabilités de points gagnés en carrière (vrais stats)
pourcentages_reels = [59.7, 51.3, 47.1];  % Pourcentage de jeux gagnés en carrière (vrais stats)
pourcentage_predits = zeros(size(p_values));

% Simulation pour chaque joueur
for i = 1:length(p_values)
    p = p_values(i);
    
    % Matrice de transition T pour le joueur actuel
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
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   p,   0,   p, 1-p,   0,   0;  % S15
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0;  % S16
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0;  % S17
        0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   p,   p,   0,   0,   0,   p,   1,   0;  % SF1 (Victoire A)
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p, 1-p,   0,   0, 1-p,   0, 1-p,   0,   0,   1;  % SF2
    ];
    
    v = zeros(20, 1);
    v(1) = 1;  % État initial (0-0)
    prob_victoire_jeu = (T^100) * v;
    pourcentage_predits(i) = prob_victoire_jeu(19) * 100;
end
fprintf('Comparaison des probabilités de gagner un jeu pour chaque joueur :\n');
for i = 1:length(joueurs)
    fprintf('%s - Modèle : %.2f%%, Statistiques réelles : %.2f%%\n', joueurs{i}, pourcentage_predits(i), pourcentages_reels(i));
end
