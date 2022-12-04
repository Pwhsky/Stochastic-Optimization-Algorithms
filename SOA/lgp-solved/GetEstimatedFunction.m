function estimatedFunction = GetEstimatedFunction(chromosome, operators)

    
    registers = ["x" "0" "0" "0" "0" "-1" "3" "-5" "1" "10"];
    
    
    nInstructions = size(chromosome, 2)/4;
    
    for iInstruction = 0:(nInstructions-1)
        
        iGene = 1 + (iInstruction*4);
        
        operation = operators(chromosome(iGene));
        destinationRegister = chromosome(iGene+1);
        
        operand1 = chromosome(iGene+2);
        operand2 = chromosome(iGene+3);
        
        instruction = strcat('(', registers(operand1), ' ', operation, ' ', registers(operand2), ')');
        registers(destinationRegister) = instruction;
         
    end 
    
    
    estimatedFunction = registers(1);
    
    %Str2sym to give an expression
    estimatedFunction = simplify(str2sym(estimatedFunction));
end 