function visibility_matrix = GetVisibility(cityLocation)
%Calculate inverse euclidian distance between all cities.
%Creates an upper triangular matrix.


nCities = length(cityLocation);
visibility_matrix = zeros(nCities);


for i=1:nCities
        for j= i:nCities
                if i == j 
          visibility(i,j) = 0;
      end
      
           location_difference = cityLocation(j,:) - cityLocation(i,:);
           distance = sqrt(sum(location_difference.^2));
           
           visibiliy_matrix(i,j)=distance;
           
           %as defined in the book, inverse distance.
            visibility_matrix(i,j) = 1./visibiliy_matrix(i,j);
            
            visibility_matrix(j,i) = visibility_matrix(i,j);

        end
end
visibility_matrix(visibility_matrix ==inf) = 0;
end




