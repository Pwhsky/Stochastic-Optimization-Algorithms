clear
interval = [-5,5];
N = 40;

beta = 0.95;
inertia = 1.2;
iterations = 1000;

%Initialize the particles
particle_positions = InitializePosition(N,interval,2);
particle_velocities = InitializeVelocity(N,interval,2);

%Initiate the particles best position, and the swarms best position.
best_position = particle_positions;
swarm_best = GetGlobalBest(particle_positions);

figure(1)
hold off

for y = 1:iterations
   
%Update positions and velocities for particles.

for i = 1:N
bestPos = best_position(i,:);   
velocity = particle_velocities(i,:);
currentPos = particle_positions(i,:);

[newPos,newVel] = UpdateParticle(currentPos,velocity,bestPos,swarm_best,inertia);

particle_positions(i,:) = newPos;
particle_velocities(i,:) = newVel;
end


%Update the particles best position if the new position is better
for i = 1:N
    eval_best = EvaluatePosition(best_position(i,:));
    eval_new = EvaluatePosition(particle_positions(i,:));
    
   if  eval_new < eval_best
       best_position(i,:) = particle_positions(i,:);    
    end

end

%Find the best swarm position
best_swarm = GetGlobalBest(particle_positions);
scatter(particle_positions(:,1), particle_positions(:,2));

%Update inertia:
if inertia > 0.4
    
   inertia = inertia*beta; 
end

end
 
disp(['Best position (x,y)= ',num2str(best_swarm)])
disp(['Best function value f = ',num2str(EvaluatePosition(best_swarm))])

% Overlay the results with the contour plot:
hold on

%Create the contour plot
x_1 = [-5:0.02:5];
x_2 = [-5:0.02:5];
[X,Y] = meshgrid(x_1,x_2);
f = (X.^2 + Y -11).^2 + (X + Y.^2 -7).^2;

contour(X,Y,log(0.01 + f))
xlabel('x')
ylabel('y')
xlim([-5 5]);
ylim([-5 5]);

