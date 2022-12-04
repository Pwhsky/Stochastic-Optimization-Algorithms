function population = InitializePopulation(populationSize, nWeights, numGenenesPerWeight)
    % Initialize the weights
    nGenes = nWeights * numGenenesPerWeight;
    population = fix(2.0 * rand(populationSize, nGenes));
end