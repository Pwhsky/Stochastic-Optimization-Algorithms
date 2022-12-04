function population = InitializePopulation(populationSize,  minNumberOfInstructions, maxNumberOfInstructions,  nVariableRegisters, nConstantRegisters)
%An instruction is 4 genes 
%[operator,destination,operand1,operand2]



%operand takes on value 1,2,3,4
    population = [];
    for i = 1:populationSize
        
        nInstructions = minNumberOfInstructions + fix(rand*(maxNumberOfInstructions - minNumberOfInstructions));
        chromosome = zeros(1, nInstructions*4);
        
        
        
        for j = 1:nInstructions
            
            %iterate through instructions, 4 genes per.
             currentGene = 1 + (j-1)*4;
  
            %operator gene
            chromosome(currentGene) = randi(4);
            
            
            %destination register gene %double check to see if this works
            chromosome(currentGene+1) = randi(nVariableRegisters); 
            
    
             %operand 1 gene 
            chromosome(currentGene+2) = randi(nVariableRegisters + nConstantRegisters); 
            
            %operand 2 gene
            chromosome(currentGene+3) = randi(nVariableRegisters + nConstantRegisters); 
           
        end 
        
        individual = struct('Chromosome', chromosome);
        population = [population individual];
    end 
end