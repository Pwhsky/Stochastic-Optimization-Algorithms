function x = DecodeChromosome(chromosome, nVariables, variableRange)
    nGenes = length(chromosome);    
    numGenenesPerVariable = nGenes/nVariables;   % the number of genes that belong to one variable.
    x = zeros(1, nVariables); 
    
    binarySeries = zeros(1, numGenenesPerVariable); 
    for i = 1:length(binarySeries)
        binarySeries(i) = 0.5^i;    % binarySeries = [1/2, 1/4, 1/8, ..., (1/2)^numGenenesPerVariable]
    end
    
    for j = 1:nVariables
        subChromosome = chromosome(1+(j-1)*numGenenesPerVariable:j*numGenenesPerVariable);
        x(j) = subChromosome * binarySeries.'; % x(j) = [1 0 1 ...]*[1/2, 1/4, 1/8,]'
        x(j) = - variableRange + 2 * variableRange * x(j) / (1 - 2^(-numGenenesPerVariable));
    end
end