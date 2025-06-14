% Comparaison de la probabilité de gagner un jeu, un set, et un match mais également de l'effet amplificateur en fonction de p

p_values = 0.5:0.01:1.0;  % De 0.5 à 1.0 avec un pas de 0.01
num_p = length(p_values);

%% Calcul pour le jeu

n = 20; 
prob_victoire_jeu = zeros(size(p_values));  % Probabilités de victoire pour le jeu
v0_jeu = zeros(n, 1);
v0_jeu(1) = 1;

for i = 1:num_p
    p = p_values(i);
    % Matrice de transition T pour le jeu
    T_jeu = [
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        1-p, 0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0, 1-p,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   0,   p, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0, 1-p,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0, 1-p,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   0,   0,   p, 1-p,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0,   p,   0,   0,   0,   0,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   p,   0,   p, 1-p,   0,   0;
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0, 1-p,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   0,   0;
        0,   0,   0,   0,   0,   0,   0,   0,   0,   p,   0,   0,   p,   p,   0,   0,   0,   p,   1,   0;
        0,   0,   0,   0,   0,   0,   0,   0, 1-p, 1-p,   0,   0, 1-p,   0, 1-p,   0,   0, 1-p,   0,   1;
    ];
    
    T_long_term_jeu = T_jeu^100;
    proba_finale_jeu = T_long_term_jeu * v0_jeu;
    
    prob_victoire_jeu(i) = proba_finale_jeu(19);
end

% Calcul de la dérivée numérique pour le jeu
dp_jeu = diff(prob_victoire_jeu) ./ diff(p_values);

%% Calcul pour le set

% Nombre d'états : 39 transitions + 2 absorbants pour le set
nset = 41;
prob_victoire_set = zeros(size(p_values));

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
    6, 6;  % S38
];

% Trouver l'indice de l'état correspondant au score
find_state_set = @(a, b) find(scores_set(:,1) == a & scores_set(:,2) == b);
SF1_set = 40; % Victoire de A
SF2_set = 41; % Défaite de A

for i = 1:num_p
    p = p_values(i);
    q = 1 - p;
    
    % Matrice de Transition du set
    T_set = zeros(nset, nset);
    
    for j = 1:nset - 2 % On exclut les états absorbants
        current_score = scores_set(j, :);
        a = current_score(1);
        b = current_score(2);
        
        new_a = a + 1;
        new_b = b;
        if (new_a >= 6 && new_a - new_b >= 2) || (new_a == 7 && new_b == 5)
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
        if (new_b >= 6 && new_b - new_a >= 2) || (new_b == 7 && new_a == 5)
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
    
    state_6_6 = find_state_set(6,6);
    if ~isempty(state_6_6)
        T_set(SF1_set, state_6_6) = p;
        T_set(SF2_set, state_6_6) = q;
    end
    
    for col = 1:nset
        column_sum = sum(T_set(:, col));
        if column_sum < 1
            T_set(col, col) = 1 - column_sum;
        end
    end
    
    etat_initial = zeros(nset, 1);
    etat_initial(1) = 1;
    
    T_long_term_set = T_set^100;
    proba_finale_set = T_long_term_set * etat_initial;
    
    prob_victoire_set(i) = proba_finale_set(SF1_set);
end

% Calcul de la dérivée numérique pour le set
dp_set = diff(prob_victoire_set) ./ diff(p_values);

%% Calcul pour le match

n_match = 11;
prob_victoire_match = zeros(size(p_values));
v0_match = zeros(n_match, 1);
v0_match(1) = 1;

for i = 1:num_p
    p = p_values(i);
    
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
    
    T_long_term_match = T_match^100;
    proba_finale_match = T_long_term_match * v0_match;
    
    prob_victoire_match(i) = proba_finale_match(10);
end

dp_match = diff(prob_victoire_match) ./ diff(p_values);

%% Graphiques

figure;
plot(p_values,prob_victoire_jeu, 'b-', 'LineWidth', 2);
hold on;
plot(p_values, prob_victoire_set, 'r-', 'LineWidth', 2);
plot(p_values, prob_victoire_match, 'g-', 'LineWidth', 2);
xlabel('Probabilité p');
ylabel('Probabilité de victoire');
title('Probabilité de gagner (jeu, set, match) en fonction de p');
legend('Jeu', 'Set', 'Match');
grid on;
hold off;

figure;
plot(p_values(1:end-1), dp_jeu, 'b-', 'LineWidth', 2);
hold on;
plot(p_values(1:end-1), dp_set, 'r-', 'LineWidth', 2);
plot(p_values(1:end-1), dp_match, 'g-', 'LineWidth', 2);
xlabel('Probabilité p');
ylabel('Effet amplificateur');
title('Effet amplificateur (jeu, set, match) en fonction de p');
legend('Jeu', 'Set', 'Match');
grid on;
hold off;
