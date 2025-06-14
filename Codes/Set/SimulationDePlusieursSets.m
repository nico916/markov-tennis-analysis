num_simulations = 10000;  % Nombre de sets à simuler
p = 0.55;                 % Probabilité pour le joueur A de gagner un jeu (nous avons testé pour p = 0.51 également)
q = 1 - p;                % Probabilité pour le joueur B de gagner un jeu
nset = 41;

% Liste des scores correspondant à chaque état (S0 à S38)
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

find_state_set = @(a, b) find(scores_set(:,1) == a & scores_set(:,2) == b);
SF1_set = 40;
SF2_set = 41;
T_set = zeros(nset, nset);
for j = 1:nset - 2
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

% Convertir la matrice de transition en probabilités cumulées pour chaque état
cum_T_set = cumsum(T_set);

% Initialisation des scores finaux
max_games = 14; % On limite les scores pour éviter des indices trop élevés
score_distribution = zeros(max_games+1, max_games+1); % Matrice pour stocker les scores [A-B]

% Simulations
for sim = 1:num_simulations
    current_state = 1; % État initial : 0-0
    path_states = [];  % Pour stocker les états parcourus

    while current_state ~= SF1_set && current_state ~= SF2_set
        % Générer un nombre aléatoire entre 0 et 1
        rand_num = rand;

        % Trouver le prochain état en fonction des probabilités cumulées
        next_state = find(cum_T_set(:, current_state) >= rand_num, 1);

        % Enregistrer le nouvel état
        current_state = next_state;
        path_states(end+1) = current_state; %#ok<AGROW>
    end

    % Déterminer le score final à partir des états parcourus
    if current_state == SF1_set
        winner = 'A';
    else
        winner = 'B';
    end

    % Récupérer le dernier score avant l'état absorbant
    if isempty(path_states)
        final_state = 1; % Cas où on passe directement à l'état absorbant (théorique)
    else
        final_state = path_states(end-1);
    end

    final_score = scores_set(final_state, :);

    games_won_A = final_score(1);
    games_won_B = final_score(2);

    % Ajuster le score final en fonction du joueur gagnant
    if winner == 'A'
        games_won_A = games_won_A + 1;
    else
        games_won_B = games_won_B + 1;
    end

    % Limiter les indices pour éviter les dépassements
    games_won_A = min(games_won_A, max_games);
    games_won_B = min(games_won_B, max_games);

    % Stocker le score final
    score_distribution(games_won_A + 1, games_won_B + 1) = ...
        score_distribution(games_won_A + 1, games_won_B + 1) + 1;
end

% Afficher la distribution des scores finaux
figure;
imagesc(0:max_games, 0:max_games, score_distribution);
colorbar;
xlabel('Jeux gagnés par le joueur B');
ylabel('Jeux gagnés par le joueur A');
title(['Distribution des scores finaux de sets (A-B) pour p = ', num2str(p)]);
set(gca, 'YDir', 'normal'); % Pour inverser l'axe Y et avoir l'origine en bas
