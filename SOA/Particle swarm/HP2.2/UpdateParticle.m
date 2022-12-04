function [newPosition,newVelocity] = UpdateParticle(currentPos,velocity,bestPos,swarmBest,w)
c_1 = 2;
c_2 = 2;

r = rand;
q = rand;

%V_max is decided by max([-5,5]) - min([-5,5]) 

v_max = 10;

%calculate new velocity
term1 = (bestPos - currentPos);
term2 = (swarmBest - currentPos);

newVelocity = w*velocity + c_1*q*term1 + c_2*r*term2;

%limit to v_max

for iV = 1:2
if newVelocity(iV) > v_max
    newVelocity(iV) = v_max;
end
if newVelocity(iV) < -v_max 
    newVelocity(iV) = -v_max;
end
end

newPosition = currentPos + newVelocity;
end

