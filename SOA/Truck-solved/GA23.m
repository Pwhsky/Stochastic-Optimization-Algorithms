%% Genetic Algorithm
clear; clc; close all;



%% Parameters for the Neural network
nNodesOfEachLayer = [3, 4, 2];
nInputs = nNodesOfEachLayer(1);
nHiddenNodes = nNodesOfEachLayer(2);
nOutputs = nNodesOfEachLayer(3);
nWeights = (nInputs + 1) * nHiddenNodes + (nHiddenNodes + 1) * nOutputs; % the number of weights in the neural network

%% Parameters for GA
populationSize = 100;
numGenenesPerWeight = 15; % Ô­À´15
nGenerations = 20;
variableRange = 5;  % range of weights
tournamentSelectionParameter = 0.75;
tournamentSize = 1;
crossoverProbability = 0.8;
nCopies = 1;
mutationProbability = 1/(nWeights * numGenenesPerWeight);

%% Initialize population
population = InitializePopulation(populationSize, nWeights, numGenenesPerWeight);

%% initialize some variables or sets to store fitness
FitnessTrainingSet = zeros(populationSize, 1); % Stores the fitness of each chromosome on the "training" set.
FitnessValidationSet = zeros(populationSize, 1); % Stores the fitness of each chromosome on the "validation" set.
fitnessOverEpochTrainingSet = [];
fitnessOverEpochValidationSet = [];
lastBestFitnessOnValidationSet = 0;
bestFitnessOnTrainingSet = 0;


%% assistive variable to determine when to stop training 
stopTrainingCounter = 0; 

%% GA training process
epoch = 0;
while (1)
    
    %% Evaluate the each chromosome on "Training set". At the same time, find the best chromosome(on the training set) and make a copy of it.
    for iIndividual = 1:populationSize
        chromosome = population(iIndividual, :);
        FitnessTrainingSet(iIndividual) = EvaluateIndividual(chromosome, 1, nNodesOfEachLayer, variableRange);
        FitnessValidationSet(iIndividual) = EvaluateIndividual(chromosome, 2, nNodesOfEachLayer, variableRange);
        
        if (FitnessTrainingSet(iIndividual) > bestFitnessOnTrainingSet)
            bestFitnessOnTrainingSet = FitnessTrainingSet(iIndividual);
            chromosomeBestOnTrainingSet = chromosome;
        end
    end
    
    bestFitnessOnTrainingSet = max(FitnessTrainingSet);
    fitnessOverEpochTrainingSet = [fitnessOverEpochTrainingSet, bestFitnessOnTrainingSet];

    % Evaluate the best chromosomeBestOnTrainingSet on the validation set. 
    bestFitnessOnValidationSet = EvaluateIndividual(chromosomeBestOnTrainingSet, 2, nNodesOfEachLayer, variableRange);  
    fitnessOverEpochValidationSet = [fitnessOverEpochValidationSet, bestFitnessOnValidationSet];
   
    
    %% Determine whether to continue training, or stop.
    if (bestFitnessOnValidationSet >= lastBestFitnessOnValidationSet)
        lastBestFitnessOnValidationSet = bestFitnessOnValidationSet;
        lastBestChromosomeOnValidationSet = chromosomeBestOnTrainingSet; % Save a copy of the best chromosome so far for the Validation set.
        disp(['epoch = ' num2str(epoch) ', fitness on the validation network has been updated to ' num2str(bestFitnessOnValidationSet)]);
        
        stopTrainingCounter = 0;
    else
        disp('Fitness on validation test is not increasing...');
        stopTrainingCounter = stopTrainingCounter + 1;
        if (stopTrainingCounter >= 15)
            break;   % When the fitness on Validation set given by the best chromosome continuesly decreases over 15 epoches, stop training.
        end
    end

    
    %% Form the next generation.
    tempPopulation = population;

    for i = 1:2:populationSize

        % Select two individuals i1 and i2 from the evaluated population.
        i1 = TournamentSelect(FitnessTrainingSet, tournamentSelectionParameter, tournamentSize);
        i2 = TournamentSelect(FitnessTrainingSet, tournamentSelectionParameter, tournamentSize);
        chromosome1 = population(i1, :);
        chromosome2 = population(i2, :);

        % Generate two offspring chromosomes by crossing, with probability pc,
        % the two chromosomes ci1 and ci2 of the two parents. With probability
        % 1-c, copy the parent chromosomes without modification.

        r = rand;
        if (r < crossoverProbability)
            newChromosomePair = Cross(chromosome1, chromosome2);                  
            tempPopulation(i, :) = Mutate(newChromosomePair(1,:), mutationProbability);
            tempPopulation(i+1, :) = Mutate(newChromosomePair(2,:), mutationProbability); 
        else
            tempPopulation(i, :) = Mutate(chromosome1, mutationProbability);
            tempPopulation(i+1, :) = Mutate(chromosome2, mutationProbability);
        end
    end
    
    % Elitism
    modifiedPopulation = InsertBestIndividual(tempPopulation, chromosomeBestOnTrainingSet, nCopies);
    population = modifiedPopulation; % Update the population of this generation.
    epoch = epoch + 1;
end

a1 = plot(fitnessOverEpochTrainingSet); M1 = 'Trainingset curve';
hold on;
a2 = plot(fitnessOverEpochValidationSet); M2 = 'Validationset curve';
legend([a1;a2], M1, M2);
xlabel("iteration");
ylabel("max fitness");
