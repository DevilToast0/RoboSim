% create class variables
classdef sensors
    methods(Static)

        % all functions here (accessable publicly by other classes)
        function [colorString, colorVal] = getColor(brick)

            % sets the color sensor color mode. This changes what colors it
            % looks for and the output for each color
            % 3 is the port on the brick, 2 is the mode 
            brick.SetColorMode(3, 2);

            % creates and sets a variable equal to the color the sensor
            % is reading
            colorVal = brick.ColorCode(3);

            % switch case statement (fancy if else statement) to connect
            % the color value and corresponding string value of color.
            switch colorVal
                case 0
                    colorString = 'NULL';
                case 1
                    colorString = 'Black';
                case 2
                    colorString = 'Blue';
                case 3
                    colorString = 'Green';
                case 4
                    colorString = 'Yellow';
                case 5
                    colorString = 'Red';
                case 6
                    colorString = 'White';
                case 7
                    colorString = 'Brown';
            end
        end

        % function to get the distance of the ultrasonic sensor to the wall 
        function [distanceVal] = getDistance(brick)

            % ensures the brick is stopped before reading value
            brick.StopAllMotors();
            
            % gets value of distance (in centemeters)
            distanceVal = brick.UltrasonicDist(4);
        end

        % checks if there is a wall in front of the ultrasonic sensor.
        % returns true or false value (true if wall, false if not)
        function [boolWall] = isWall(brick)

            % stop car
            brick.StopAllMotors();
            
            % get distance
            wallDistance = brick.UltrasonicDist(4);

            % if the wall is not within 50 cm there is a wall
            if (wallDistance > 50)
                boolWall = false;
            else
                boolWall = true;
            end
        end
        
        % checks if the touch sensors 
        function [touch] = touchSensors(brick)

            brick.StopAllMotors();

            % returns a 0 or 1 (false/true respectivly) 
            touch = brick.TouchPressed(1);
        end
    end
end