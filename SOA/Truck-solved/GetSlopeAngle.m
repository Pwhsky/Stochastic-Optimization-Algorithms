%% This file provides the FORMAT you should use for the
%% slopes in HP2.3. x denotes the horizontal distance
%% travelled (by the truck) on a given slope, and
%% alpha measures the slope angle at distance x
%%
%% iSlope denotes the slope index (i.e. 1,2,..10 for the
%% training set etc.)
%% iDataSet determines whether the slope under consideration
%% belongs to the training set (iDataSet = 1), validation
%% set (iDataSet = 2) or the test set (iDataSet = 3).
%%
%% Note that the slopes given below are just EXAMPLES.
%% Please feel free to implement your own slopes below,
%% as long as they fulfil the criteria given in HP2.3.
%%
%% You may remove the comments above and below, as they
%% (or at least some of them) violate the coding standard 
%%  a bit. :)
%% The comments have been added as a clarification of the 
%% problem that should be solved!).

function alpha = GetSlopeAngle(x, iSlope, iDataSet)

    if (iDataSet == 1)                                % Training
        if (iSlope == 1) 
            alpha = 3.1 + sin(x/100) + cos(sqrt(2)*x/50);    % You may modify this!
        elseif (iSlope == 2)
            alpha = 6 + x/1000 + sin(x/30) - 1.3*cos(sqrt(2)*x/40);       
        elseif (iSlope== 3)
            alpha = 4.1 + cos(0.12*sqrt(x+10)) - 1.2*sin(x/100); 
        elseif (iSlope== 4)
            alpha = 5.9 + 0.5 * sin(sqrt(x)/100) + cos(x/200);  
        elseif (iSlope== 5)
            alpha = 4 + 2 * cos(0.021*x + 4) + sin(log(0.002*x*x+1)/500); 
        elseif (iSlope== 6)
            alpha = 5 + cos(x/250 - 2) + 2.1 * sin(x/40);             
        elseif (iSlope== 7)
            alpha = 3.6 + cos(x/300 + 256/(x + 2.5)) + x/1000; 
        elseif (iSlope== 8)
            alpha = 5.0 + 2.5 * sin(0.03*x*log(x+4.5) + 4); 
        elseif (iSlope== 9)
            alpha = 4.1 + cos(0.02*x + 0.0015 * log(x+2.6))+ x/500;    
        elseif (iSlope== 10)
            alpha = 3.4 + 2 * sin(x/50);             
        end 
       
    elseif (iDataSet == 2)                            % Validation
        if (iSlope == 1) 
           alpha = 3.5 - sin(x/100) + cos(sqrt(3)*x/50);    % You may modify this!
        elseif (iSlope == 2) 
           alpha = 3 + 0.9 * sin(x/500) + 1.8 * cos(x/600);    
        elseif (iSlope == 3) 
           alpha = 5 - sin(log(x+20) + 100) + 2.5 * cos((x+69)/80);    
        elseif (iSlope == 4) 
           alpha = 4 - sin(x/200) + cos(x/500) + 2 * cos(0.0315*x + 4);         
        elseif (iSlope == 5) 
           alpha = 2.6 + sin(x/520) + cos(sqrt(5)*x/50);    % You may modify this!
        end 
        
    elseif (iDataSet == 3)                           % Test
        if (iSlope == 1) 
            alpha = 5 - sin(x/100) - cos(sqrt(7)*x/50);   % You may modify this!      
        elseif (iSlope == 2)
            alpha = 3.6 + (x/200) + sin(x/70) + cos(x/100); % You may modify this!      
        elseif (iSlope == 3)
            alpha = 4 + 1.2 * sin(x/80) + cos(sqrt(7)*x/100); % You may modify this!       
        elseif (iSlope == 4)
            alpha = 5  + sin(x/70) - 2.0 * cos((x+23)/700 + log(x+78)); % You may modify this!
        elseif (iSlope == 5)
            alpha = 4.2 + (x/1000) + sin(x/70) + cos(sqrt(7)*x/100); % You may modify this!
        end        
    end

end
