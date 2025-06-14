joueurs = {'Nadal', 'Simon', 'Moutet'};
p_values = [0.807, 0.557, 0.463];  % Probabilités de sets gagnés en Grand Chelem
pourcentages_reels = [87.3, 59.9, 47.1];  % Pourcentage de matchs gagnés en Grand Chelem
pourcentages_predits = zeros(size(p_values));
for i = 1:length(p_values)
    p = p_values(i);
    T = [
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S0
        p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S1
        1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S2
        0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0;  % S3
        0,   1-p, p,   0,   0,   0,   0,   0,   0,   0,   0;  % S4
        0,   0,   1-p, 0,   0,   0,   0,   0,   0,   0,   0;  % S5
        0,   0,   0,  1-p,  p,   0,   0,   0,   0,   0,   0;  % S6
        0,   0,   0,   0,   1-p, p,   0,   0,   0,   0,   0;  % S7
        0,   0,   0,   0,   0,   0, 1-p,   p,   0,   0,   0;  % S8
        0,   0,   0,   p,   0,   0,   p,   0,   p,   1,   0;  % SF1 (Victoire A)
        0,   0,   0,   0,   0, 1-p,   0, 1-p, 1-p,   0,   1;  % SF2
    ];
    v = zeros(11, 1);
    v(1) = 1;
    prob_match_win = (T^100) * v; 
    pourcentages_predits(i) = prob_match_win(10) * 100; 
end
fprintf('Comparaison des probabilités de gagner un match pour chaque joueur en Grand Chelem :\n');
for i = 1:length(joueurs)
    fprintf('%s - Modèle : %.2f%%, Statistiques réelles : %.2f%%\n', joueurs{i}, pourcentages_predits(i), pourcentages_reels(i));
end
