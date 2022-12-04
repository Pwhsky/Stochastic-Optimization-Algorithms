function position = GetGlobalBest(positions)

%Evaluate all the positions and return the one with the highest performance
for i = 1:length(positions)
 x = positions(i,:); 
    
term1 = (x(1)^2 + x(2)   - 11)^2;
term2 = (x(1)   + x(2)^2 - 7) ^2;
performance = term1 + term2;

performance_list(i) = performance;


end
[~, bestIndex] = min(performance_list);
position = positions(bestIndex,:);

end

