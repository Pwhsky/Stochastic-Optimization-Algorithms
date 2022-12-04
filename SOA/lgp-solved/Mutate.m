function mutatedChromosome = Mutate(chromosome, nVariableRegisters, nConstantRegisters)
    
    chromosome_copy = chromosome;
    
    
    nGenes = length(chromosome);
    
    mutation_probability= 2/nGenes;
    
    for i = 1:nGenes
        p = rand;
        if p <=  mutation_probability
            
            %mutate
            switch mod(i, 4)
                case 1
         
                    newVal = randi(4); 
                case 2
                    

                    newVal = randi(nVariableRegisters); 
                case 3
                    
                    newVal = randi(nVariableRegisters + nConstantRegisters); 
                case 0
                    
                    newVal =  randi(nVariableRegisters + nConstantRegisters); 
            end 
            
            
           chromosome_copy(i) = newVal;
        end 
    end 
    mutatedChromosome = chromosome_copy;
end 