%Batch wrapper for LGP
%Alex Lech, 2022-10-04
clear all
clc


nBatches = 6;


bestFitness = 0;
bestIndividual = struct('Chromosome', []);
bestError = 0;

for ibatch = 1:nBatches
    
    [newfitnessValue, individual] = RunLGPSingle();
    
    
    if newfitnessValue > bestFitness  
        
        bestFitness = newfitnessValue
        bestError = 1/newfitnessValue
     
        bestIndividual = individual;
      
    end 
   
    if bestError < 0.01
        break
    end 
    
end

bestChromosome = bestIndividual.Chromosome;
%best error obtained was 2.847958997793384e-09
save('bestChromosome.mat', 'bestChromosome');

