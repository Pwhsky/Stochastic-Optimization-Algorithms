function pheromone_level = UpdatePheromoneLevels(pheromone_level,deltaPheromoneLevel,rho)
%Update pheromones
pheromone_level = pheromone_level*(1-rho) + deltaPheromoneLevel; 

%Locate small values and set them to our lower bound value.
indices = pheromone_level < 10^(-15);
pheromone_level(indices) = 10^(-15); 

