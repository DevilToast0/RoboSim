% MAIN METHOD

manualModeOn = false;
objectiveGreen = false;
objectiveYellow = false;

while (~objectiveGreen)
    
    pause(.1);

    disp("*");
    pause (.1);

    [objectiveYellow, objectiveGreen] = move.completeForwards(brick, objectiveYellow);


    if (objectiveGreen && objectiveYellow)
        disp("Get green");
        return;
    end
end

return;