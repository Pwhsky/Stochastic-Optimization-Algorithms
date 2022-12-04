function pathLength = GetPathLength(path,cityLocation)
%Get length of the path
%Path contains indices of cities in cityLocation
L = length(path);

pathLength = 0;

for i=1:L-1
   coords_1 =  cityLocation(path(i +1),:);
   coords_2 =  cityLocation(path(i),:);
   difference = coords_1 - coords_2;
   
   distance(i) = sqrt(sum(difference.^2));
end

first_to_last_coords = cityLocation(path(i+1),:) - cityLocation(path(1),:);
distance_first_to_last = sqrt(sum(first_to_last_coords.^2));

pathLength = distance_first_to_last + sum(distance);

