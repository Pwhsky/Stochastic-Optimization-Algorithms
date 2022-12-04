function outBrakeTemperature = UpdateBrakeTemperature(Pp, inBrakeTemperature, tau, Ch, Tamb, timeInteval)
    % Pp: 
    % deltaTb: the relative temperature to ambient temature
    % tau: constant,
    % Ch: constant
    % Tamb: ambient temperature
    % delta time: the time interval for simulation
    
    deltaTb = inBrakeTemperature - Tamb;
    
    if (Pp < 0.01)
        diffDeltaTb = - deltaTb / tau;
    else
        diffDeltaTb = Ch * Pp;
    end
    
    deltaTb = deltaTb + timeInteval * diffDeltaTb; % deltaTb(k+1) = deltaTb(k+1) + timeInteval * diffDeltaTb(k)
    outBrakeTemperature = Tamb + deltaTb;    
end