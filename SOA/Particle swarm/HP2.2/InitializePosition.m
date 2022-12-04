function position = InitializePosition(swarmSize,interval,number_of_variables)
%interval = [-5,5] for our problem
%swarm size = N.

for n = 1:number_of_variables
    for N= 1:swarmSize
    r= rand;
    position(N,n) = min(interval) + r*(max(interval) - min(interval));

    end

end

end