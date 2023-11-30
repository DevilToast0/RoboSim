% MAIN METHOD

% READ INFOWENEVERGOT.m

% CONNECT TO ROBOT ## USING ROCKET MODEL ##
run ConnectToEV3.m; 

disp("INITIALIZING...");

% MAKE SURE MODEL IS SET TO GYRO AT 2 %
angle = brick.GyroAngle(2);
disp("EV3 ANGLE: " + angle);

% init sensors %
dist = brick.UltrasonicDist(4);
touch1= brick.TouchPressed(1);

% print out initialized variables
disp("TOUCH 1: " + touch1);
[colorString, colorVal] = sensors.getColor(brick);
disp("Color: " + colorString + " - " + colorVal);
[distance] = sensors.getDistance(brick);
disp("Distance: " + distance);

% Raise and lower lift (for funzies)
move.raiseLift(brick); 
move.lowerLift(brick);
move.raiseLiftPer(brick, 1.5);

% Fancy print statements (they do nothing but slow things down and look
% cool
disp("FINISHED INITIALIZING...");
pause(.5);
disp("PROGRAM STARTING...")
pause(.5);
disp("3...")
pause(1);
disp("2...")
pause(1);
disp("1...")
pause(1);
disp("READY!")

% open keyboard
global key
InitKeyboard();

% - - - - - - - - - - - - - - - - - - %

% main code stuff from here on:

% initialize all of the variables to fals
runAutonomous = false; % this is checking if the autonomus script is running or not
manualModeOn = false; % if manual mode is on (read the variable name dummy)
objectiveGreen = false; % if the car has completed objective green (only happens AFTER objective yellow is done)
objectiveYellow = false; % if objective yellow is completed or not

% loops true forever (until break)
while 1
    
    % wait .1 seconds so the loop has time to breathe
    pause(.1);

    % if the autonomus script is running and the green objective is not done 
    if (runAutonomous && ~objectiveGreen)

        % AUTONOMOUS SCRIPT HERE %

        % movement script (function in move class) it brings in the brick
        % and if the yellow objective has been completed. Then it sets if
        % the yellow objective and green objective are true or false;
        [objectiveYellow, objectiveGreen] = move.completeForward(brick, objectiveYellow);
     
    end

    % checks if the keyboard has been pressed
    switch key

        %starts the autonomus program
        case 'tab'
            % start autonomous %
            disp("STARTING AUTONOMOUS MODE...");
            runAutonomous = true;
        case '1'
            % start autonomous %
            disp("STARTING AUTONOMOUS MODE...");
            run autonomousScript.m;
            objectiveGreen = true;
            objectiveYellow = true;

        % starts manual mode
        case 'm'
            % MANUAL MODE %

            %if manual mode is already running it doesn't do anything.
            if (manualModeOn)
                break;
            end

            % set variables to know the manual script is running
            runAutonomous = false;
            manualModeOn = true;

            disp("RUNNING MANUAL MODE...");        
            pause(1);

            % run the manual script file
            run manual.m;

            % runs after the manual script has completed | v
            disp("EXITED MANUAL MODE...");  
            manualModeOn = false;
            pause(1);
            disp("STARTING AUTONOMOUS MODE...");        

            runAutonomous = true;
        
        % quits program
        case 'q'
            disp("STOPPING PROGRAM...");
            brick.StopAllMotors();
            pause(1);
            disp("PROGRAM STOPPED")
            break;
    end

    % if the green and yellow objective are complete the program is done.
    % (FANCY PRINT STUFF)
    if (objectiveGreen && objectiveYellow)
        disp("_____________________________________________________");
        disp("|         /\/\   - - - - - - - - - -   /\/\         |");
        disp("|        /_/\_\ | MISSION  COMPLETE | /_/\_\        |");
        disp("|        [~][~]  - - - - - - - - - -  [~][~]        |");
        disp("|___________________________________________________|");
        brick.StopAllMotors();
        pause(1);
        disp("--- PROGRAM ENDED ---")
        break;
    end
end

CloseKeyboard();