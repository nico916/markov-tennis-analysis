joueurs = {'Nadal', 'Simon', 'Moutet'};
p_game_values = [0.597, 0.513, 0.471];  
pourcentages_reels_sets = [77.1, 53.6, 43.2];
pourcentages_predits_sets = zeros(size(p_game_values));
nb_etats = 41;
etat_SF1 = 40;
etat_SF2 = 41;
scores_set = [
    0, 0; 1, 0; 0, 1; 2, 0; 1, 1; 0, 2; 3, 0; 2, 1; 1, 2; 0, 3;
    4, 0; 3, 1; 2, 2; 1, 3; 0, 4; 5, 0; 4, 1; 3, 2; 2, 3; 1, 4;
    0, 5; 5, 1; 4, 2; 3, 3; 2, 4; 1, 5; 5, 2; 4, 3; 3, 4; 2, 5;
    5, 3; 4, 4; 3, 5; 5, 4; 4, 5; 5, 5; 6, 5; 5, 6; 6, 6
];
trouver_etat = @(a, b) find(scores_set(:,1) == a & scores_set(:,2) == b);
for idx = 1:length(p_game_values)
    p = p_game_values(idx);
    q = 1 - p;
    matrice_transition = zeros(nb_etats, nb_etats);
    for j = 1:nb_etats - 2
        score_actuel = scores_set(j, :);
        a = score_actuel(1);
        b = score_actuel(2);
        nouveau_a = a + 1;
        nouveau_b = b;
        if (nouveau_a >= 6 && nouveau_a - nouveau_b >= 2)
            matrice_transition(etat_SF1, j) = p;
        else
            prochain_etat = trouver_etat(nouveau_a, nouveau_b);
            if ~isempty(prochain_etat)
                matrice_transition(prochain_etat, j) = p;
            end
        end
        nouveau_a = a;
        nouveau_b = b + 1;
        if (nouveau_b >= 6 && nouveau_b - nouveau_a >= 2)
            matrice_transition(etat_SF2, j) = q;
        else
            prochain_etat = trouver_etat(nouveau_a, nouveau_b);
            if ~isempty(prochain_etat)
                matrice_transition(prochain_etat, j) = q;
            end
        end
    end
    etat_6_6 = trouver_etat(6, 6);
    if ~isempty(etat_6_6)
        matrice_transition(etat_SF1, etat_6_6) = p;  
        matrice_transition(etat_SF2, etat_6_6) = q;
    end
    for col = 1:nb_etats
        somme_colonne = sum(matrice_transition(:, col));
        if somme_colonne < 1
            matrice_transition(col, col) = 1 - somme_colonne;
        end
    end
    etat_initial = zeros(nb_etats, 1);
    etat_initial(1) = 1;
    probabilites_finales = matrice_transition^100 * etat_initial;
    pourcentages_predits_sets(idx) = probabilites_finales(etat_SF1) * 100;
end
fprintf('Comparaison des probabilités de gagner un set pour chaque joueur :\n');
for idx = 1:length(joueurs)
    fprintf('%s - Modèle : %.2f%%, Statistiques réelles : %.2f%%\n', joueurs{idx}, pourcentages_predits_sets(idx), pourcentages_reels_sets(idx));
end
