%% TestProgram
clear; clc; close all;

%% --------------Specify slope-------------------
iSlope = 1;% Slope number
iDataSet = 3; % Slope set: training 1, validation 2, or test 3.


%% ---------------Do NOT change things below. ---------------------
nNodesOfEachLayer = [3, 4, 2];
variableRange = 5; 

chromosomeBest = ...
[1,0,1,0,1,0,0,0,1,1,0,0,0,1,0,0,0,1,1,0,0,1,0,0,0,0,1,1,1,1,0,0,1,1,1,0,0,1,0,1,0,1,1,1,1,0,1,1,1,0,0,0,1,0,0,1,0,1,1,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,1,1,1,1,0,0,1,0,0,1,0,1,1,0,0,1,0,1,1,0,1,0,1,1,1,1,0,0,1,1,0,1,1,1,1,0,1,1,1,1,1,1,1,0,1,1,0,0,0,0,0,0,1,0,1,0,0,0,1,1,0,1,0,1,1,0,0,0,1,1,0,1,0,0,0,1,1,1,0,0,1,1,0,1,1,1,0,0,1,1,0,1,0,0,0,0,1,0,0,1,1,1,0,1,1,0,1,1,1,0,0,0,0,1,0,1,1,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,1,1,1,0,1,0,0,1,0,0,1,1,1,0,0,0,1,1,0,0,1,0,0,1,0,0,0,1,0,1,0,1,0,0,1,0,0,1,1,0,1,1,1,1,1,0,0,0,1,1,1,0,1,0,0,0,1,0,1,1,0,0,1,1,0,1,1,1,1,0,0,1,1,1,1,0,0,1,1,0,1,0,1,0,0,0,0,0,0,1,1,0,1,0,1,1,0,1,1,1,0,0,1,0,0,0,1,0,0,1,0,1,0,0,0,1,0,1,0,1,1,1,0,1,1,1,1,1,0,1,1,0,0,0,1,1,0,0,0,0,1,0,0,0,0,1,0,1,1,1,0,1,0,0,1,0,1,1,0,1,0,1,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,1,0,1,1,0];


[xPositionList, alphaList, PpList, gearChoiseList, velocityList, brakeTemperatureList, breakingForceList] = TestOnSlope_old(chromosomeBest, iSlope, iDataSet, nNodesOfEachLayer, variableRange);

numPlots = 5;

subplot(numPlots,1,1);
plot(xPositionList, alphaList);
title("slope angle");

subplot(numPlots,1,2);
plot(xPositionList, PpList);
title("brake pedal pressure, Pp");

subplot(numPlots,1,3);
plot(xPositionList, gearChoiseList);
title("gear")

subplot(numPlots,1,4);
plot(xPositionList, velocityList);
title("speed");

subplot(numPlots,1,5);
plot(xPositionList, brakeTemperatureList);
title("brake temperature");

if numPlots == 6
    subplot(numPlots,1,6);
    plot(xPositionList, breakingForceList);
    title("Fb");
end


function [xPositionList, alphaList, PpList, gearChoiseList, velocityList, brakeTemperatureList, breakingForceList] = TestOnSlope_old(chromosome, iSlope, iDataSet, nNodesOfEachLayer, variableRange)
% The function evaluate the network on each road in the traning set. 
% the fitness value is the average fitness of the slope.

    % constant parameters
    maxTemperature = 750;
    mass = 2e4;
    tau = 30;
    Ch = 40;
    Tamb = 283;
    Cb = 3000;
    velocityMax = 25;
    velocityMin = 1;
    alphaMax = 10;
    
    gravityAcceleration = 9.8;
    
    slopeHorizontalLength = 1000; 
    
    normalizationDenominator = [velocityMax, alphaMax, maxTemperature];
    
    % For decoding and encoding.
    

    
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

    
    % Decode chromosome to weights.
    weights = DecodeChromosome(chromosome, nWeights, variableRange);

       

        
    % Initial state variables
    xPosition = initialPosition;
    alpha = GetSlopeAngle(xPosition, iSlope, iDataSet);
    brakeTemperature = initialBrakeTemperature;
    gearNumber = intitialGearNumber;
    velocity = intitialVelocity;

    lastBreakTime = 0;

   
    
    % Initialize empty list to store the state variables along the process.
    alphaList = [GetSlopeAngle(0, iSlope, iDataSet)];
    PpList = [];
    gearChoiseList = [intitialGearNumber];
    velocityList = [intitialVelocity];
    brakeTemperatureList = [initialBrakeTemperature];
    xPositionList = [initialPosition];
    breakingForceList = [];
    
 
    kTimeElapsed = 0;
    while ( (velocity < velocityMax) && (velocity > velocityMin) && (brakeTemperature < maxTemperature) && (xPosition <= slopeHorizontalLength))
        ANNInputs = [velocity, alpha, brakeTemperature];  % ANNInputs(k)
        ANNOutputs = ANN(ANNInputs, nOutputs, weights, normalizationDenominator); % ANNOutputs = [Pp, deltaGear]
        Pp = ANNOutputs(1); % t(k)
        PpList = [PpList, Pp];

        deltaGear = ANNOutputs(2); % t(k)

        % Compute breakingForce: Fb
        breakingForce = ComputeBrakingForce(mass, Pp, brakeTemperature, maxTemperature, gravityAcceleration); % Fb(k)
        breakingForceList = [breakingForceList, breakingForce];

        % Compute engine breaking force: Feb.
        engineBrakeForce = ComputeEngineBrakeForce(gearNumber, Cb);  % Feb(k)

        % Compute the acceleration
        acceleration = gravityAcceleration * sin(alpha / 180 * pi) - 1 / mass * (breakingForce + engineBrakeForce); % acceleration(k)

        % Update the state variable of next time stamp.
        xPosition = xPosition + velocity * cos(alpha / 180 * pi) * timeInterval;          % x(k+1) = x(k) + v * cos(¦Á(k)) * timeInterval
        xPositionList = [xPositionList, xPosition];

        velocity = velocity + timeInterval * acceleration;      % v(k+1) = v(k) + timeInterval * acceleration(k)
        velocityList = [velocityList, velocity];

        alpha = GetSlopeAngle(xPosition, iSlope, iDataSet);     % ¦Á(k+1) =  GetSlopeAngle(x(k+1), iSlope, iDataSet)
        alphaList = [alphaList, alpha];

        brakeTemperature = UpdateBrakeTemperature(Pp, brakeTemperature, tau, Ch, Tamb, timeInterval); % Tb(k+1) = ComputeBrakeTemperature(Pp(k)..., Tb(k), ...)
        brakeTemperatureList = [brakeTemperatureList, brakeTemperature];

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
        gearChoiseList = [gearChoiseList, gearNumber];

        % update time stamp.
        kTimeElapsed = kTimeElapsed + 1;      
    end
    
    listLength = min([length(alphaList), length(PpList), length(gearChoiseList), ...
                length(velocityList), length(brakeTemperatureList), length(xPositionList), ...
                length(breakingForceList)]);
    
    alphaList = alphaList(1:listLength);
    PpList = PpList(1:listLength);
    gearChoiseList = gearChoiseList(1:listLength);
    velocityList = velocityList(1:listLength);
    brakeTemperatureList = brakeTemperatureList(1:listLength);
    xPositionList = xPositionList(1:listLength);
    breakingForceList = breakingForceList(1:listLength);
end

