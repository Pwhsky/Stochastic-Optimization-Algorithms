% This method should plot the polynomial and the iterates obtained
% using NewtonRaphsonStep (if any iterates were generated)

%TO DO: To choose an appropriate range for plotting you could 
%check the minimum and maximum values of the iterates.
function PlotIterations(polynomialCoefficients, iterationValues)


%Below is a loop to calculate the polynomial values so it may be plotted
x = linspace(-7,7,2000);
polynomialValues = zeros(1,length(x));

    for i = 1:length(x)
         polynomialValues(i) = GetPolynomialValue(x(i), polynomialCoefficients);
    end



%The code below will calculate the y-value for each step of the method.
yValues = zeros(1,length(iterationValues));

    for k = 1:length(iterationValues)
         yValues(k) = GetPolynomialValue(iterationValues(k), polynomialCoefficients);
    end


clf

plot(x,polynomialValues,'-');                                                    
hold on
plot(iterationValues,yValues ,'o','color','black')                   

hold on
xlim([iterationValues(end)-0.3 iterationValues(1)+0.3])





display1 = sprintf(' %.1f iterations,    Start value = %.1f ',length(iterationValues)-1, iterationValues(1) ); %-1 here because we don't count the 0th iteration?
legend(display1)

end

