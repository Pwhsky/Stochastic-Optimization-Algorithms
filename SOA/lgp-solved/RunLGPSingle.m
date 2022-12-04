
function [bestFitness, bestIndividual] = RunLGPSingle(current_cross_probability)
    %Variable registers:
    M = 5; 
    
    operators = ['+' '-' '*' '/'];
    
   
    bestFitness = 0;
    bestIndividual = struct('Chromosome', []); 
    variableRegisters = zeros(1, M);
    
    
    %Tournament parameters
    tournament_probability = 0.75;
    tournamentSize = 5;
    
  
    
   
    nIndividuals = 100;
    minInstructions = 10;
    maxInstructions = 100;
    
    %The number of generations need to be large.
    nGenerations = 10000; 
    
    %define the upper and lower bounds of the varying cross probability.
    maxCross = 0.6;
    minCross = 0.25;
    diffCross = maxCross-minCross;
    
    
    
    cross_probability = [maxCross: -diffCross/(nGenerations-1) :minCross];
    
    cMax = 400;

    %this can be experimented with further
     constantRegister = [-1 3 -5 1 10];
     
    N = length(constantRegister); 
    registers = [variableRegisters constantRegister];
    
    population = InitializePopulation(nIndividuals, minInstructions, maxInstructions, M, N);
    
    function_data = LoadFunctionData;
    
    for iGen = 1:nGenerations
         currentCrossProbability = cross_probability(iGen);
        
        
        %Elitism
        eliteFitness = 0;
        eliteIndividual = struct('Chromosome', []);

        %Evalute current generation and append to list
      fitnessList = EvaluatePopulation(population, function_data, registers, M, operators, cMax);

       
        for i = 1:nIndividuals
            fitnessVal = fitnessList(i);

            if fitnessVal > eliteFitness
                eliteFitness = fitnessVal;
                eliteIndividual = population(i);
            end 

            if fitnessVal > bestFitness
                bestFitness = fitnessVal;
                bestIndividual = population(i);
            end 
        end 
      
        population = GetNewPopulation(population, fitnessList, tournament_probability, tournamentSize, M, N, currentCrossProbability);

       %Complete cycle and replace old gen with new gen.
        population(1) = eliteIndividual;
    end 
end 

