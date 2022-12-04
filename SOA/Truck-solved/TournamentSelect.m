function iSelected = TournamentSelect(fitness, pTournament, tournamentSize) % fitness is a vector of the populaiton fitness
    populationSize = length(fitness);
%     disp("populationSize");
%     disp(populationSize);
    
    iPreselected = zeros(1, tournamentSize); % Stores the i preselected by random sampling with replacement.
    for i = 1:tournamentSize
        iPreselected(i) = 1 + fix(rand*populationSize);
    end    
    
%     disp("preselected i");
%     disp(iPreselected);

    fitnessPreselected = fitness(iPreselected);
%     disp("preselected fitness");
%     disp(fitnessPreselected);
    
    % Return the indices of fitness values of in fitness descending order.
    [~, id] = sort(fitnessPreselected,'descend');
    iPreselectedDescending = iPreselected(id); % eg. F3 = 16, F5 = 10, F9 = 11 are three chromosome preselected from the pupulation, then iPreselectedDescending = [3, 9, 5].
    
%     disp(iPreselectedDescending);
    
    selectionRound = 1;
    
    while (selectionRound < tournamentSize )
        condition = rand < pTournament;
        if (condition) % condition
            iSelected = iPreselectedDescending(selectionRound);
            break;
        else
%             disp("condition not satisfied...");
        end        
        selectionRound = selectionRound + 1;
    end
    
    if (selectionRound == tournamentSize)
        iSelected = iPreselectedDescending(selectionRound);
    end
end