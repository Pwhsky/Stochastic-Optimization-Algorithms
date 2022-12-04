function outputs = ANN(inputs, nOutputs, weights, normalizationDenominator)
    % inputs = [velocity, alpha, brakeTemperature]
    % normalizationDenominator = [velocityMax, alphaMax, maxTemperature]
    
    % outputs = [Pp, deltaGear]
    
    % For this problem, the number of inputs is 3, the number of outputs is
    % 2.
    nInputs = length(inputs);
    nWeights = length(weights);
    
    % Solve the equation  (nInputs + 1) * nHiddenNodes + (nHiddenNodes + 1) * nOutputs = nWeights .
    nHiddenNodes = (nWeights - nOutputs) / (nInputs + 1 + nOutputs);
    
    
    normalizedInputs = inputs ./ normalizationDenominator;
    
    inputLayer = [1; normalizedInputs(:)];
    
    % Extract weights between input layer and hidden layer.
    weights12 = weights(1:(nInputs+1)*nHiddenNodes);
    weights12 = reshape(weights12, [nHiddenNodes, nInputs + 1]);
    
    % Compute Hidden layer.
    hiddenLayerWithoutBias = weights12 * inputLayer;
%     disp(hiddenLayerWithoutBias);
    
    hiddenLayerWithoutBias = 1 ./ (1 + exp(-hiddenLayerWithoutBias)); % activation function on the hidden layer outputs.
    hiddenLayerWithoutBias = hiddenLayerWithoutBias(:);             % reshape hiddenLayerWithoutBias to a column vector. 
    
%     disp(hiddenLayerWithoutBias);
    
    % Extract weights between hidden layer and output layer.
    weights23 = weights((nInputs+1)*nHiddenNodes + 1 : end);
    weights23 = reshape(weights23, [nOutputs, nHiddenNodes + 1]);
    
    % Compute Output layer
    hiddenLayer = [1; hiddenLayerWithoutBias];    
    outputLayer = weights23 * hiddenLayer;
    
%     disp(outputLayer(1));
    
    % Activation with sigmoid function.
    outputs = 1 ./ (1 + exp(-outputLayer));
    
%     disp(outputs(1));
  
    outputs = outputs(:).'; % Reshape the output to a row vector.
    
    % decoding deltaGear
    if (outputs(2) < 1/3)
        outputs(2) = -1; % reduce one gear level.
    elseif (outputs(2) >= 1/3 && outputs(2) < 2/3)
        outputs(2) = 0; % keep the gear level unchanged.
    else
        outputs(2) = 1; % increase one gear level.
    end
end
