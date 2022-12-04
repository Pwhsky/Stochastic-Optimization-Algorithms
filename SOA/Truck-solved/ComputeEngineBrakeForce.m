function engineBrakeForce = ComputeEngineBrakeForce(gearNumber, Cb)
    % gearNumber is in range [1, 10].
    if (gearNumber == 1)
        engineBrakeForce = 7 * Cb;
        
    elseif (gearNumber == 2)
        engineBrakeForce = 5 * Cb;
        
    elseif (gearNumber == 3)
        engineBrakeForce = 4 * Cb;  
        
    elseif (gearNumber == 4)
        engineBrakeForce = 3 * Cb;
        
    elseif (gearNumber == 5)
        engineBrakeForce = 2.5 * Cb;
        
    elseif (gearNumber == 6)
        engineBrakeForce = 2 * Cb;
        
    elseif (gearNumber == 7)
        engineBrakeForce = 1.6 * Cb;  
        
    elseif (gearNumber == 8)
        engineBrakeForce = 1.4 * Cb;
        
    elseif (gearNumber == 9)
        engineBrakeForce = 1.2 * Cb;
        
    elseif (gearNumber == 10)
        engineBrakeForce =  Cb;       
    end
end