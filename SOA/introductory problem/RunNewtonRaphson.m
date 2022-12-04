% This function should run the Newton-Raphson method, making use of the
% other relevant functions (StepNewtonRaphson, DifferentiatePolynomial, and
% GetPolynomialValue). Before returning iterationValues any non-plottable values 
% (e.g. NaN) that can occur if the method fails (e.g. if the input is a
% first-order polynomial) should be removed, so that only values that
% CAN be plotted are returned. Thus, in some cases (again, the case of
% a first-order polynomial is an example) there may be no points to plot.

function iterationValues = RunNewtonRaphson(polynomialCoefficients, startingPoint, tolerance)

if length(polynomialCoefficients) <= 2
error('The input polynomial needs to be of higher order than 1.')
else
    

iterationNumber = 1;
iterationValues(1) = startingPoint;
x = startingPoint;



                                         
fPrimeCoefficients = DifferentiatePolynomial(polynomialCoefficients, 1);
fDoublePrimeCoefficients = DifferentiatePolynomial(polynomialCoefficients, 2);    

fPrime = GetPolynomialValue(x,fPrimeCoefficients);                
fDoublePrime = GetPolynomialValue(x, fDoublePrimeCoefficients); 

xNext = StepNewtonRaphson(x, fPrime, fDoublePrime); 

relativeError = abs((xNext-x)/(xNext));                                     

while relativeError > tolerance
    
    
    x = xNext; %Take on the value of xNext
    
    fPrime = GetPolynomialValue(x, fPrimeCoefficients);
    fDoublePrime = GetPolynomialValue(x, fDoublePrimeCoefficients);
    
    
    
    xNext = StepNewtonRaphson(x, fPrime, fDoublePrime); %Update xNext to the next iteration
                                                             
    
    relativeError = abs((xNext-x)/(xNext));
    iterationNumber = iterationNumber+1;
    iterationValues(iterationNumber) = xNext;
end



sprintf('The stationary point is calculated to %.5f with a tolerance of %.5f.',iterationValues(end), tolerance )


end

end