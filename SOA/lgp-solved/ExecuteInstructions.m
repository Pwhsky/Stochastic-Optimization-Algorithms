function registers = ExecuteInstructions(instructions, registers, operations)
        
    nInstructions = size(instructions, 2)/4;
    
    %Perform the decoded instructions:
    for iInstruction = 0:(nInstructions-1)
        iGene = 1 + iInstruction*4;
        
        operator = operations(instructions(iGene));
        
        destinationRegister = instructions(iGene+1);
        
        operand1 = registers(instructions(iGene+2));
        
        operand2 = registers(instructions(iGene+3));
        
        output = registers(destinationRegister);
        
        switch operator
            case '+'
                
                output = operand1 + operand2;
            case '-'
                output = operand1 - operand2;
            case '*'
                output = operand1 * operand2;
                %in the case of dividing by zero, we want to prevent this
            case '/'
                if operand2 == 0
                    
                    output = 1e9;
                else 
                    output = operand1 / operand2;
                end 
        end  
        registers(destinationRegister) = output;
    end 
end 