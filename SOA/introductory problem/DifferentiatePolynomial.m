% This method should return the coefficients of the k-th derivative (defined by
% the derivativeOrder) of the polynomial given by the polynomialCoefficients (see also GetPolynomialValue)

function derivativeCoefficients = DifferentiatePolynomial(polynomialCoefficients, derivativeOrder)


if derivativeOrder > 2                      
   derivativeCoefficients = [];               
else
    newCoefficients = polynomialCoefficients;
    derivativeCoefficients = zeros(1,length(newCoefficients));
    
    for kOrder = 1:derivativeOrder    
    
      for n = 1:(length(newCoefficients)-1) 
      derivativeCoefficients(n) = newCoefficients(n+1)*n;
      end
      
      newCoefficients = derivativeCoefficients;  
    end
    
    if kOrder == 2                                                 
     derivativeCoefficients(end) = [];                    
    end
    
end

end

