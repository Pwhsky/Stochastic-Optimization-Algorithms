function selectedIndividualIndex = TournamentSelection(fitnessList, tournament_probability, tourSize)
    
    participants = zeros(1, tourSize); 
    for i = 1:tourSize
        iParticipant = 1 + fix(rand*size(fitnessList, 1));
        participants(i) = iParticipant;
    end 
    

    
    while true

        if size(participants, 2) == 1
            selectedIndividualIndex = participants(1);
            return
        end
        
        % Find best participant index
        bestFitness = -inf;
        
        iBestParticipant = 0;
        
      for i = 1:size(participants, 2)
            if fitnessList(participants(i)) > bestFitness
                bestFitness = fitnessList(participants(i));
                iBestParticipant = i;
            end 
        end
      
        r = rand;
        if r < tournament_probability
            
            selectedIndividualIndex = participants(iBestParticipant);
           return 
        else 
            %remove best participant
            participants = [participants(1:(iBestParticipant -1)) participants((iBestParticipant + 1):end)];
        end     
    end   
end 
