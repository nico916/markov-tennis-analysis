n = 41;
p_values = 0.5:0.01:1.0;
num_p = length(p_values);

% Initialisation du vecteur pour stocker les probabilités d'atteindre 5-5
prob_att_5_5 = zeros(size(p_values));
scores = [
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

find_state = @(a, b) find(scores(:,1) == a & scores(:,2) == b);
for i = 1:num_p
    p = p_values(i);
    q = 1 - p;
    T = zeros(n, n);
    for j = 1:n - 2 
        current_score = scores(j, :);
        a = current_score(1);
        b = current_score(2);
        if (a >= 6 && a - b >= 2)
            T(n - 1, j) = 1;
            continue;
        elseif (b >= 6 && b - a >= 2)
            T(n, j) = 1;
            continue;
        end
        new_a = a + 1;
        new_b = b;
        if (new_a >= 6 && new_a - new_b >= 2)
            T(n - 1, j) = p;
        else
            next_state = find_state(new_a, new_b);
            if ~isempty(next_state)
                T(next_state, j) = p;
            end
        end
        new_a = a;
        new_b = b + 1;
        if (new_b >= 6 && new_b - new_a >= 2)
            T(n, j) = q;
        else
            next_state = find_state(new_a, new_b);
            if ~isempty(next_state)
                T(next_state, j) = q;
            end
        end
    end
    state_6_6 = find_state(6,6);
    if ~isempty(state_6_6)
        T(n - 1, state_6_6) = p;
        T(n, state_6_6) = q;
    end
    initial_state = zeros(n, 1);
    initial_state(1) = 1;
    
    % Progression étape par étape pour atteindre 5-5
    prob_intermediaire = initial_state;
    prob_5_5 = 0;
    for k = 1:100  % Parcourir les étapes
        prob_intermediaire = T * prob_intermediaire;
        prob_5_5 = prob_5_5 + prob_intermediaire(find_state(5, 5));
    end
    
    % Stocker la probabilité d'atteindre 5-5
    prob_att_5_5(i) = prob_5_5;
end

% Graphique de la probabilité d'atteindre 5-5 en fonction de p
figure;
plot(p_values, prob_att_5_5, 'b-', 'LineWidth', 2);
xlabel('Probabilité p de gagner un jeu');
ylabel('Probabilité cumulative d atteindre 5-5');
title('Probabilité cumulative d atteindre 5-5 en fonction de p');
grid on;
