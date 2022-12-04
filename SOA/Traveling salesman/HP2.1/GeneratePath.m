function path = GeneratePath(pheromoneLevel, visibility, alpha, beta)
%Pre-allocaten

nCities = length(visibility);
path = zeros(1,nCities);

tabu_list= zeros(1,nCities);
P_all = zeros(nCities,nCities);

random_city = randi(nCities);

start = random_city;
tabu_list(1) = random_city;


tau = pheromoneLevel;
eta = visibility ;




for j = 1:nCities 
    for i = 1:nCities 

    %Skip city in tabu_list
     if sum(tabu_list ==i)
    	   continue
         else
                 %Create numerator in equation (4.3)
                 P_term1=tau(i,random_city).^alpha *eta(i,random_city).^beta;  
                 
                 %Create denominator in equation (4.3)
                 P_term2 = tau(:,random_city).^alpha .*eta(:,random_city).^beta; 
                 P_term2 = sum (P_term2(setdiff(1:end,tabu_list)));
                 P_all(i,j) = P_term1/P_term2;
          end
        
     
  end
   if sum(P_all(:,j)) == 0
     break
   else
       
         path(j) = GetNode(P_all(:,j));
         tabu_list(j+1) = path(j);
         
   end
    random_city = path(j);
    
end

path = tabu_list;


 