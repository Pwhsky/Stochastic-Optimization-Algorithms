function breakingForce = ComputeBrakingForce(mass, Pp, brakeTemperature, maxTemperature, gravityAcceleration)
    if (brakeTemperature < maxTemperature - 100)
       breakingForce = mass * gravityAcceleration * Pp / 20; 
    else
       breakingForce = mass * gravityAcceleration * Pp * ...
                        exp( -(brakeTemperature - (maxTemperature - 100)) / 100 ) / 20; 
    end
end