function modifiedPopulation = InsertBestIndividual(population, bestIndividual, nCopies)
    
    modifiedPopulation = population;
    
    for i = 1:nCopies
        modifiedPopulation(i, :) = bestIndividual;
    end
    
end