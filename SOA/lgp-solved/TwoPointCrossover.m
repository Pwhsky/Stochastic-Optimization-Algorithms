function [newChromosome1, newChromosome2] = TwoPointCrossover(chromosome1, chromosome2)
    %Very important to not cross-over in the middle of an instruction
    
   
    nGenes1 = size(chromosome1, 2)/4;
    nGenes2 = size(chromosome2, 2)/4;
    
    %the chromosome with the fewest number of instructions will decide the
   %limits of the crossover points:
    nGenes = min(nGenes1, nGenes2);
    
    
    
    point1 = randi(nGenes-1)*4;
    point2 = randi(nGenes-1)*4;

    if point1 > point2
        tempCrossOverPoint = point2;
        point2 = point1;
        point1 = tempCrossOverPoint;
    end 
    %"Snip" meaning cutting them out with scissors
    % indexed with letter and number.
    
    
    snip_a1 = chromosome1(1:point1);
    snip_a2 = chromosome1((point1+1):point2);
    snip_a3 =  chromosome1((point2+1):end);
    
    snip_b1 = chromosome2(1:point1);
    snip_b2 = chromosome2((point1+1):point2);
    snip_b3 =  chromosome2((point2+1):end);
    
    newChromosome1 = [snip_a1 snip_b2 snip_a3];
    newChromosome2 = [snip_b1 snip_a2 snip_b3];
    
end 
