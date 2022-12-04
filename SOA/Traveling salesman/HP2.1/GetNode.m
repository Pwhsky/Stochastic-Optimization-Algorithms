function new_node = GetNode(Probability)
cumulative_sum = cumsum(Probability);
r = rand;


new_node = find(r <= cumulative_sum);

new_node = new_node(1);


end

