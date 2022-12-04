% This method should perform a single step of the Newton-Raphson method.
% Note: In cases where the step cannot be completed, e.g. if f" = 0, a
% clear error message should be given.

function xNext = StepNewtonRaphson(x, fPrime, fDoublePrime)

%if computed numerically, f'' would return NaN and not 0, therefore isnan()
%is used instead of "== 0" as a condition.

    if isnan(fDoublePrime)
          xNext = NaN;
          error('Second derivative is equal to zero. Unable to compute further.');
    else  
          xNext = x - fPrime/fDoublePrime; 
    end
end