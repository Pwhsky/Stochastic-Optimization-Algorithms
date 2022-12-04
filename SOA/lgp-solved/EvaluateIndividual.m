function fitnessVal = EvaluateIndividual(chromosome, functionData, registers, operators, nVariableRegisters, cMax)


    %The fitness value will be defined as 1/(error)
    error_sum = 0;
    K = size(functionData, 1);
    penalty_factor = 1/(exp(length(chromosome)/(cMax*3)));
    
    for k = 1:K
        
        % reset variable register 1
        registers(1) = functionData(k, 1); 
        for i = 2:nVariableRegisters
            registers(i) = 0;
        end 
        
        

        registers = ExecuteInstructions(chromosome, registers, operators);
        errorVal = registers(1);
        error_sum = error_sum + (errorVal - functionData(k,2))^2;
       
    end 
    
    final_error = (error_sum/K)^(0.5);
    
    fitnessVal = final_error^(-1);
    
    %Penalty factor for long chromosomes.
    if length(chromosome) > cMax
        fitnessVal = fitnessVal*penalty_factor;
    end 
    
end 