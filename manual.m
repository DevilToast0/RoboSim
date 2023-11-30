global key
InitKeyboard();

while 1

    pause(.1);
    
    touch1 = brick.TouchPressed(1);
    gyro = brick.GyroAngle(2);

    switch key      

        % move forward until release
        case 'w'
            brick.MoveMotor('A', 50);
            brick.MoveMotor('B', 50);
            
        % turn left until release
        case 'a'
            brick.MoveMotor('A', -25);
            brick.MoveMotor('B', 25);
        
        % move backward until release
        case 's'
            brick.MoveMotor('A', -50);
            brick.MoveMotor('B', -50);
        
        % move right until release
        case 'd'
            brick.MoveMotor('A', 25);
            brick.MoveMotor('B', -25);

        % move forward 1 unit    
        case 'uparrow'
            disp ("FORWARD");
            brick.MoveMotor('AB', -80);
            pause(1.7);
            brick.StopAllMotors('Brake');

        % turn left 90°
        case 'leftarrow'
            disp ("LEFT TURN");
            move.turnLeft(brick);
        
        % turn around
        case 'downarrow'
            disp ("BACKWARDS");
            move.turnAround(brick);
        
        % turn left 90°
        case 'rightarrow'
            disp ("RIGHT TURN");
            move.turnRight(brick);

        % Lift lift up   
        case '1'
             disp ("LIFT UP");
            move.raiseLift(brick);
        
        % Lower lift down
        case '2'
            disp ("LIFT DOWN");
            move.lowerLift(brick);

        % stop all motors
        case 'g'
            brick.StopAllMotors();

        % print out the scanner values
        case 'p'
            %TEST ROTATION
            move.testScanner(brick);

        % read and print out color values
        case 'c'
            brick.StopAllMotors();
            pause(1);
            [colorString, colorVal] = sensors.getColor(brick);
            disp("Color: " + colorString + " - " + colorVal);

        % get distance from wall (between 5 - 255)
        case 'f'
            brick.StopAllMotors();
            pause(1);
            [distance] = sensors.getDistance(brick);
            disp("Distance: " + distance);

        % quit manual mode and return to autonomus script
        case 'q'
            brick.StopAllMotors();
            pause(1);
            disp("LEAVING MANUAL MODE...")
            pause(1);           
            break;
        case 0
            brick.StopAllMotors('Brake');
    end

    if (touch1 == 1)
            disp("TOUCHING: " +touch1);
    end
end

CloseKeyboard();