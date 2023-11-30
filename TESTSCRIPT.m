% -/-/-/-/-/-/-/-/- MAIN -/-/-/-/-/-/-/-/-
% ASU FSE doc https://sites.google.com/a/asu.edu/fse100-cse-wiki
% Setup:
% brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5')

% DisconnectBrick(brick);
disp("Connect to EV3?");

run ConnectToEV3.m

beep()

while true

    touch = brick.TouchPressed(1); % Read a touch sensor connected to port 1.
    touch2 = brick.TouchPressed(2); % Read a touch sensor connected to port 2.
    
    disp("START");
    brick.playTone(100, 2000, 1000);

    brick.MoveMotor('AB', -50); 
    pause(2);
    brick.beep();    
    disp("AFTER BEEP 1 AND PAUSE");

    
    if touch==1 || touch2==1
        disp("TOUCH");

        brick.beep();   
        brick.beep();    
        brick.beep();    

        % Beep if the sensor was touched.

        brick.MoveMotor('AB', 50); 
        pause(4);
        disp("FINISHED TOUCH");
        brick.MoveMotor('AB', 0); 
        pause(1);


        break;            % End program

    end
    disp("Break and repeat true?");

end
    disp("End?");
