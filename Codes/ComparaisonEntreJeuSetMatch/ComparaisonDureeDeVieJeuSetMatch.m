% Plage de valeurs pour p
p_values = 0.5:0.01:1.0;
duree_moyenne_jeu = zeros(size(p_values));  % Durée moyenne du jeu (en points)
duree_moyenne_set = zeros(size(p_values));   % Durée moyenne du set (en jeux)
duree_moyenne_match = zeros(size(p_values)); % Durée moyenne du match (en sets)

%% Calcul de la durée moyenne du jeu
for i = 1:length(p_values)
    p = p_values(i);

    % Matrice de transition T pour le jeu
    T_jeu = [
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

    T_jeu = T_jeu';

    % États non absorbants (les 18 premiers états)
    Q_jeu = T_jeu(1:18, 1:18);

    % Matrice fondamentale N pour le jeu
    N_jeu = inv(eye(size(Q_jeu)) - Q_jeu);

    % Durée moyenne du jeu (nombre moyen de points)
    nomb_moy_points = N_jeu * ones(size(Q_jeu,1),1);
    duree_moyenne_jeu(i) = nomb_moy_points(1);
end

%% Calcul de la durée moyenne du set
% Nombre d'états : 38 transitions + 2 absorbants pour le set
nset = 40;
scores_set = [
    0, 0;  % S0
    1, 0;  % S1
    0, 1;  % S2
    2, 0;  % S3
    1, 1;  % S4
    0, 2;  % S5
    3, 0;  % S6
    2, 1;  % S7
    1, 2;  % S8
    0, 3;  % S9
    4, 0;  % S10
    3, 1;  % S11
    2, 2;  % S12
    1, 3;  % S13
    0, 4;  % S14
    5, 0;  % S15
    4, 1;  % S16
    3, 2;  % S17
    2, 3;  % S18
    1, 4;  % S19
    0, 5;  % S20
    5, 1;  % S21
    4, 2;  % S22
    3, 3;  % S23
    2, 4;  % S24
    1, 5;  % S25
    5, 2;  % S26
    4, 3;  % S27
    3, 4;  % S28
    2, 5;  % S29
    5, 3;  % S30
    4, 4;  % S31
    3, 5;  % S32
    5, 4;  % S33
    4, 5;  % S34
    5, 5;  % S35
    6, 5;  % S36
    5, 6;  % S37
];

find_state_set = @(a, b) find(scores_set(:,1) == a & scores_set(:,2) == b);
SF1_set = 39;
SF2_set = 40; 
for i = 1:length(p_values)
    p = p_values(i);
    q = 1 - p;
    T_set = zeros(nset, nset);
    for j = 1:nset - 2  
        current_score = scores_set(j, :);
        a = current_score(1);
        b = current_score(2);
        new_a = a + 1;
        new_b = b;
        if (new_a >= 6 && new_a - new_b >= 2) || (new_a >= 7 && new_b >= 5)
            T_set(SF1_set, j) = p;
        else
            next_state = find_state_set(new_a, new_b);
            if ~isempty(next_state)
                T_set(next_state, j) = p;
            else
                T_set(SF1_set, j) = p;
            end
        end
        new_a = a;
        new_b = b + 1;
        if (new_b >= 6 && new_b - new_a >= 2) || (new_b >= 7 && new_a >= 5)
            T_set(SF2_set, j) = q;
        else
            next_state = find_state_set(new_a, new_b);
            if ~isempty(next_state)
                T_set(next_state, j) = q;
            else
                T_set(SF2_set, j) = q;
            end
        end
    end
    T_set = T_set';

    % États non absorbants (les 38 premiers états)
    Q_set = T_set(1:38, 1:38);

    % Matrice fondamentale N pour le set
    N_set = inv(eye(size(Q_set)) - Q_set);

    % Durée moyenne du set (nombre moyen de jeux)
    nomb_moy_jeux = N_set * ones(size(Q_set,1),1);
    duree_moyenne_set(i) = nomb_moy_jeux(1);
end

%% Calcul de la durée moyenne du match
for i = 1:length(p_values)
    p = p_values(i);

    % Matrice de transition T pour le match
    T_match = [
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

    T_match = T_match';

    % États non absorbants (les 18 premiers états)
    Q_match = T_match(1:9, 1:9);

    % Matrice fondamentale N pour le match
    N_match = inv(eye(size(Q_match)) - Q_match);

    % Durée moyenne du match (nombre moyen de sets)
    nomb_moy_sets = N_match * ones(size(Q_match,1),1);
    duree_moyenne_match(i) = nomb_moy_sets(1);
end

%% Tracé des durées moyennes
figure;
plot(p_values, duree_moyenne_jeu, 'b-', 'LineWidth', 2);
hold on;
plot(p_values, duree_moyenne_set, 'r-', 'LineWidth', 2);
plot(p_values, duree_moyenne_match, 'g-', 'LineWidth', 2);
xlabel('Probabilité p');
ylabel('Durée moyenne');
title('Durée moyenne d un jeu, d un set et d un match en fonction de p');
legend('Jeu (en points)', 'Set (en jeux)', 'Match (en sets)');
grid on;
hold off;
