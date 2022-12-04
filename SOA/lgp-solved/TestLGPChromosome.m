clc 
clf
clear all

load('BestChromosome.mat', 'bestChromosome');

M = 5;
cMax = 400;
variableRegisters = zeros(1, M);

constantRegisters = [-1 3 -5 1 10];

operators = ['+' '-' '*' '/'];

functionData = LoadFunctionData;
registers = [variableRegisters constantRegisters];
estimatedFunctionValues = zeros(size(functionData, 1), 1);

%f_hat denoting the estimated function
f_estimate = GetEstimatedFunction(bestChromosome, operators);

%Calculate estimated function value for every data point
for k = 1:size(functionData, 1)
   
    %Start by setting all other registers to 0;
    registers(1) = functionData(k, 1); 
    for i = 2:M
        registers(i) = 0;
    end

    registers = ExecuteInstructions(bestChromosome, registers, operators);
    estimatedFunctionValue = registers(1);
    
    estimatedFunctionValues(k) = estimatedFunctionValue;
    
end 

fitness = EvaluateIndividual(bestChromosome, functionData, registers, operators, length(variableRegisters), cMax);
error = 1/fitness;


f_estimate
figure(1)

plot(functionData(:,1), functionData(:,2))
xlabel('x')
ylabel('f(x)')
figure(2)

plot(functionData(:,1), estimatedFunctionValues(:),'color','red')
xlabel('x')
ylabel('f(x)')
        