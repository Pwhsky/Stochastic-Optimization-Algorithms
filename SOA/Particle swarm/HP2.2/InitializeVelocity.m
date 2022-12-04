function velocity = InitializeVelocity(swarmSize,interval,number_of_variables)
%interval = [-5,5] for our problem
%swarm size = N.

%According to book values
alpha = 1;
dt = 1;

x_min = min(interval);
x_max = max(interval);

for n = 1:number_of_variables
    for N= 1:swarmSize
    r= rand;
    
    velocity(N,n) = alpha/dt * ((x_min + r*(x_max) - x_min));

    end

end

end