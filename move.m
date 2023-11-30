classdef move
    methods(Static)

        function [objectiveYellow, objectiveGreen] = completeForward(brick, objectiveYPrior)

            objectiveYellow = objectiveYPrior;
            objectiveGreen = false;
            %move.stuck(brick);
            move.determinePath(brick);
 
            disp("move forward");
            
            brick.WaitForMotor('ABC');
            brick.StopAllMotors();
            pause(.2);
            brick.MoveMotor('AB', -80);
            i = 0;

            while (i < 17)
                
                touch = brick.TouchPressed(1);
                
                if (touch == 1)
                    brick.StopAllMotors('Brake');
                    pause(.5);
                    move.hitWall(brick);
                    i = 0;
                    move.turnToFreeDirection(brick);
                end

                [~, hitColor] = sensors.getColor(brick); 

                pause(.1);
                
                if (hitColor == 5)
                   disp("hit red");
                   brick.StopAllMotors('Brake');
                   pause(2);
                   brick.MoveMotor('AB', -80);

                elseif (hitColor == 4)
                    if ~objectiveYPrior
                        move.turnAround(brick);
                        move.lowerLift(brick);
                        brick.MoveMotor('AB', 50);
                        pause(1.7);
                        brick.StopAllMotors('Brake');
                        move.raiseLift(brick);
                        i = 0;
                        brick.MoveMotor('AB', -80);
                        objectiveYPrior = true;
                        objectiveYellow = true;
                    end

                elseif (hitColor == 3 && objectiveYellow)

                    objectiveGreen = true;

                    brick.MoveMotor('AB', -80);
                    pause(1);
                    brick.StopAllMotors('Brake');
                    break;
                end

                i = i + 1;
            end

            brick.StopAllMotors();
            pause(.5);
            move.checkAngle(brick);
        end

        function determinePath(brick)
            
            if ~sensors.isWall(brick)
                move.turnRight(brick);
            end

        end
        
        function turnRight(brick)
            disp("turn right");

            %moveList.addMoveList("right")

            brick.StopAllMotors();
            pause(1);
            brick.StopAllMotors();
            pause(.5);

            brick.MoveMotor('A', -15);
            brick.MoveMotor('B', 15);

            pause(2);
            brick.StopAllMotors();
            pause(.75);

            move.checkAngle(brick);

        end

        function turnLeft(brick)
            disp("turn left");

            %moveList.addMoveList("left")

            brick.StopAllMotors();
            pause(1);
            brick.StopAllMotors();
            pause(.5);

            brick.MoveMotor('A', 15);
            brick.MoveMotor('B', -15);

            pause(2);
            brick.StopAllMotors();
            pause(.75);

            move.checkAngle(brick);
            
        end

        function turnAround(brick)
            disp("turn around");

            %moveList.addMoveList("right")            
            %moveList.addMoveList("right")

            brick.StopAllMotors();
            pause(1);
            brick.StopAllMotors();
            pause(.5);

            brick.MoveMotor('A', 15);
            brick.MoveMotor('B', -15);

            pause(3.6);
            brick.StopAllMotors();
            pause(.75);

            move.checkAngle(brick);
        end

        function raiseLift(brick)
            disp("raise lift");

            %disp (brick.GetMotorAngle('C'));
            brick.MoveMotor('C', 100);
            pause(3.2);
            brick.StopAllMotors();
            %disp ("--> " + brick.GetMotorAngle('C'));

        end

        function raiseLiftPer(brick, time)
            disp("raise lift half");

            %disp (brick.GetMotorAngle('C'));
            brick.MoveMotor('C', 100);
            pause(time);
            brick.StopAllMotors();
            %disp ("--> " + brick.GetMotorAngle('C'));

        end

        function lowerLift(brick)
             disp("lower lift");

            %disp (brick.GetMotorAngle('C'));
            brick.MoveMotor('C', -100);
            pause(3.2);
            brick.StopAllMotors();
            %disp ("--> " + brick.GetMotorAngle('C'));

        end

        function lowerLiftPer(brick, time)
            disp("lower lift half");

            disp (brick.GetMotorAngle('C'));
            brick.MoveMotor('C', -100);
            pause(time);
            brick.StopAllMotors();
            disp ("--> " + brick.GetMotorAngle('C'));

        end

        function hitWall(brick)

            disp("hit wall");

            brick.StopAllMotors('Brake');
            pause(1);
            
            brick.MoveMotor('A', 50);
            brick.MoveMotor('B', 50);

            pause(.2);
            brick.StopAllMotors();

            move.checkAngle(brick);

            brick.MoveMotor('AB', 50);
            pause(.9);

            brick.StopAllMotors();
            pause(.5);

            move.checkAngle(brick);
        end

        function turnToFreeDirection(brick)
            
            disp("turn free direction");

            %if there is a wall on the right
            if(sensors.isWall(brick))

                %turn to check opposite wall
                move.turnAround(brick);

                %if oppostite wall that it initally checked has a wall
                if (sensors.isWall(brick))

                    %go straight back out where it came from
                else
                    %no wall to left of original position
                    move.turnRight(brick);
                    
                end 
            else
                move.turnRight(brick);
            end

            move.checkAngle(brick);
            move.checkAngle(brick);

        end

        function checkAngle(brick)
            %% WORKS %%
            disp("check angle");
            
            % GET ANGLE
            brick.GyroAngle(2);
            brick.GyroAngle(2);
            gyro = brick.GyroAngle(2);

            %check if it is negative and get relative angle
            %then get modulus and correct it.
            if (gyro < 0)
                if (gyro < -360)
                    gyro = gyro + 360;
                end
                
                absAngle = abs(gyro);

                if (mod(absAngle, 90) >= 45)
                    turnLeft = true;
                    differenceAngle = 90 - mod(absAngle, 90);
    
                else
                    turnLeft = false;
                    differenceAngle = mod(absAngle, 90);
                end
            else

                if (gyro > 360)
                    gyro = gyro - 360;
                end

                if (mod(gyro, 90) >= 45)
                    turnLeft = false;
                    differenceAngle = 90 - mod(gyro, 90);
    
                else
                    turnLeft = true;
                    differenceAngle = mod(gyro, 90);
                end
            end
         
            %if the angle is negative it reverses the
            %dirreciton so it corrects the right amount
            
            if (differenceAngle  >  1)

                if (turnLeft)
                    %turn left **MOVES CORRECT ANGLE**
                    
                    brick.MoveMotorAngleRel('A', 10, differenceAngle);
                    brick.MoveMotorAngleRel('B', -10, differenceAngle);
                    
                    brick.WaitForMotor('AB');

                else

                    %turn right **MOVES CORRECT ANGLE**
                   
                    brick.MoveMotorAngleRel('A', -10, differenceAngle);
                    brick.MoveMotorAngleRel('B', 10, differenceAngle);
                    
                    brick.WaitForMotor('AB');
                    
                end

            end
            
        end

        function stuck(brick)
            
            switch moveList.isTraped()
                case "right"
                    move.turnRight(brick);

                case "left"
                    move.turnLeft(brick);

                case "turnAround"
                    move.turnArround(brick);

            end

        end

        function [objectiveYellow, objectiveGreen] = completeForwards(brick, objectiveYPrior)

            objectiveYellow = objectiveYPrior;
            objectiveGreen = false;
            %move.stuck(brick);
            move.determinePaths(brick);
 
            disp("move forward");
            
            brick.WaitForMotor('ABC');
            brick.StopAllMotors();
            pause(.2);
            brick.MoveMotor('AB', -80);
            i = 0;

            while (i < 17)
                
                touch = brick.TouchPressed(1);
                
                if (touch == 1)
                    brick.StopAllMotors('Brake');
                    pause(.5);
                    move.hitWall(brick);
                    i = 0;
                    move.turnToFreeDirection(brick);
                end

                [~, hitColor] = sensors.getColor(brick); 

                pause(.1);
                
                if (hitColor == 5)
                   disp("hit red");
                   brick.StopAllMotors('Brake');
                   pause(2);
                   brick.MoveMotor('AB', -80);

                elseif (hitColor == 4)
                    if ~objectiveYPrior
                        move.turnAround(brick);
                        move.lowerLift(brick);
                        brick.MoveMotor('AB', 50);
                        pause(1.7);
                        brick.StopAllMotors('Brake');
                        move.raiseLift(brick);
                        i = 0;
                        brick.MoveMotor('AB', -80);
                        objectiveYPrior = true;
                        objectiveYellow = true;
                    end

                elseif (hitColor == 3 && objectiveYellow)

                    objectiveGreen = true;

                    brick.MoveMotor('AB', -80);
                    pause(1);
                    brick.StopAllMotors('Brake');
                    break;
                end

                i = i + 1;
            end

            brick.StopAllMotors();
            pause(.5);
            
            move.checkAngle(brick);
        end
        
        function determinePaths(brick)
            r = 0 + (30) * rand(); 

            if (r < 10) 
                move.turnAround(brick); 
            end

            if ~sensors.isWall(brick)
                move.turnRight(brick);
            end

        end

    end
end