function fitness = EvaluateIndividual(chromosome, iDataSet, nNodesOfEachLayer, variableRange)
% The function evaluate the network on each road in the traning set. 
% the fitness value is the average fitness of the slope.

    % constant parameters
    maxTemperature = 750;
    mass = 2e4;
    tau = 30;
    Ch = 40;
    T_ambient = 283;
    Cb = 3000;
    velocityMax = 25;
    velocityMin = 1;
    alphaMax = 10;
    
    gravityAcceleration = 9.8;
    
    slopeHorizontalLength = 1000; 
    
    normalizationDenominator = [velocityMax, alphaMax, maxTemperature];

    nInputs = nNodesOfEachLayer(1);
    nHiddenNodes = nNodesOfEachLayer(2);
    nOutputs = nNodesOfEachLayer(3);
    nWeights = (nInputs + 1) * nHiddenNodes + (nHiddenNodes + 1) * nOutputs;
    
    % For simulation progress
    timeInterval = 0.1;
    initialPosition = 0;
    intitialVelocity = 20;
    intitialGearNumber = 7;
    initialBrakeTemperature = 500;
    
    velocityList = [intitialVelocity];

    
    % Decode chromosome to weights.
    weights = DecodeChromosome(chromosome, nWeights, variableRange);

    %% Run loops over all traning slopes
    if (iDataSet == 1)          % Training set has 10 slopes.
        nSlope = 10;
    elseif (iDataSet == 2)      % Validation set has 5 slopes.
        nSlope = 5;
    elseif (iDataSet == 3)      % Test set has 5 slopes.
        nSlope = 5;
    end
    
    % Create a matrix to store the fitness on a given slope
    fitnessMatrix = zeros(1, nSlope);
    
    for iSlope = 1:nSlope
        
        % Initial state variables
        xPosition = initialPosition;
        alpha = GetSlopeAngle(xPosition, iSlope, iDataSet);
        brakeTemperature = initialBrakeTemperature;
        gearNumber = intitialGearNumber;
        velocity = intitialVelocity;
        
        lastBreakTime = 0;
        
        kTimeElapsed = 0;
   

        while ( (velocity < velocityMax) && (velocity > velocityMin) && (brakeTemperature < maxTemperature) && (xPosition <= slopeHorizontalLength))
            ANNInputs = [velocity, alpha, brakeTemperature];  % ANNInputs(k)
            ANNOutputs = ANN(ANNInputs, nOutputs, weights, normalizationDenominator); % ANNOutputs = [Pp, deltaGear]
            Pp = ANNOutputs(1); % Pp(k)
            deltaGear = ANNOutputs(2); % deltaGear(k)
            
            % Compute breakingForce: Fb
            breakingForce = ComputeBrakingForce(mass, Pp, brakeTemperature, maxTemperature, gravityAcceleration); % Fb(k)
            
            % Compute engine breaking force: Feb.
            engineBrakeForce = ComputeEngineBrakeForce(gearNumber, Cb);  % Feb(k)
            
            % Compute the acceleration
            acceleration = gravityAcceleration * sin(alpha / 180 * pi) - 1 / mass * (breakingForce + engineBrakeForce); % acceleration(k)           
    
            % Update the state variable of next time stamp.
            xPosition = xPosition + velocity * cos(alpha / 180 * pi) * timeInterval;          % x(k+1) = x(k) + v * cos(¦Á(k)) * timeInterval
            velocity = velocity + timeInterval * acceleration;      % v(k+1) = v(k) + timeInterval * acceleration(k)
            velocityList = [velocityList, velocity];
            alpha = GetSlopeAngle(xPosition, iSlope, iDataSet);     % ¦Á(k+1) =  GetSlopeAngle(x(k+1), iSlope, iDataSet)
            brakeTemperature = UpdateBrakeTemperature(Pp, brakeTemperature, tau, Ch, T_ambient, timeInterval); % Tb(k+1) = ComputeBrakeTemperature(Pp(k)..., Tb(k), ...)

            if (kTimeElapsed * timeInterval - lastBreakTime < 2)
                deltaGear = 0;
            else
                lastBreakTime = kTimeElapsed * timeInterval;
            end
            
            % Update gear number, and bound the gearNumber between 1 to 10.
            gearNumber = gearNumber + deltaGear; % gearNumber(k+1) = gearNumber(k) + deltaGear(k)
            if (gearNumber < 1)
                gearNumber = 1;
            elseif (gearNumber > 10)
                gearNumber = 10;
            end
            
            % update time stamp.
            kTimeElapsed = kTimeElapsed + 1;      
        end
        
        fitnessMatrix(iSlope) = xPosition * mean(velocityList);   % fitness of this slope = distance * average velocity
    end
    
    fitness = mean(fitnessMatrix); % The fitness of some chromosome on a given set.
end