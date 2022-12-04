function newPopulation = GetNewPopulation(population, fitnessList, tournament_probability, tourSize, nVariableRegisters, nConstantRegisters, cross_probability)
    newPopulation = [];
    
    for i = 1:2:size(population, 2)
        
        iSelectedIndividual1 = TournamentSelection(fitnessList, tournament_probability, tourSize);
        iSelectedIndividual2 = TournamentSelection(fitnessList, tournament_probability, tourSize);
        
        chromosome1 = population(iSelectedIndividual1).Chromosome;
        chromosome2 = population(iSelectedIndividual2).Chromosome;
        
        
        %two-point crossover
        r = rand;
        if r < cross_probability
            [newChromosome1, newChromosome2] = TwoPointCrossover(chromosome1, chromosome2);
        else
            newChromosome1 = chromosome1;
            newChromosome2 = chromosome2;
        end 
        
        %Mutate
        newChromosome1 = Mutate(newChromosome1, nVariableRegisters, nConstantRegisters);
        newChromosome2 = Mutate(newChromosome2, nVariableRegisters, nConstantRegisters);
        
        newIndividual1 = struct('Chromosome', newChromosome1);
        newIndividual2 = struct('Chromosome', newChromosome2);
        
        %output the new population: 
        newPopulation = [newPopulation newIndividual1 newIndividual2];
        
    end 
end 

