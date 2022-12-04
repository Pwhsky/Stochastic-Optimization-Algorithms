function  deltaPheromone_matrix = ComputeDeltaPheromoneLevels(pathCollection,pathLength)
%pre-allocate delta pheromone matrix
deltaPheromone_matrix = zeros(length(pathCollection));


%ants will contribute to the pheromone matrix individually as they travel
for n = 1:length(pathLength)
    deltaPheromone_ant= zeros(length(pathCollection));

    for j = 1:length(pathLength)-1
        deltaPheromone_ant(pathCollection(n,j+1),pathCollection(n,j)) = 1/pathLength(n);
    end

deltaPheromone_ant(pathCollection(n,j+1),pathCollection(n,1)) = 1/pathLength(n); 

deltaPheromone_matrix = deltaPheromone_matrix + deltaPheromone_ant; 

end

end