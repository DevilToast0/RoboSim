% %GUIDE!!!! NOT TO BE USED FOR FSE 100 CLASS !!!!!

global key
InitKeyboard();

brick.SetColorMode(4, 2); % set sensor 4 to colorCode

startMoving = 0;

numRightTurns = 0;
numLeftTurns = 0;

while 1
    pause(0.1);
    distance = brick.UltrasonicDist(3); % gather the distance data
    color = brick.ColorCode(4); % gather the color data
    touch = brick.TouchPressed(1);
    touch2 = brick.TouchPressed(2);
    
    switch key
        
        case 'uparrow' % on the up arrow, the auto-driving will begin
            
            while(startMoving == 0)
                
                distance = brick.UltrasonicDist(3);
                color = brick.ColorCode(4);
                touch = brick.TouchPressed(1);
                disp(touch);
                touch2 = brick.TouchPressed(2);
                
                
                
                if (distance > 20 && color ~= 5 && touch ~= 1 && touch2 ~= 1 && color ~= 3)
                    
                    brick.MoveMotor('A', 50);
                    brick.MoveMotor('B', 48.6465);
                    numRightTurns = 0;
                    numLeftTurns = 0;
                    
                    
                    distance = brick.UltrasonicDist(3);
                    disp(distance);
                    
                elseif (distance > 20 && color == 3)
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    startMoving = 1;
                      
                                  
                    
                elseif touch
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    pause(1);
                    brick.MoveMotor('A', -20);
                    brick.MoveMotor('B', -18.6465);
                    pause(0.2);
                    brick.MoveMotor('A', 25);
                    pause(0.2);
                    
                    distance = brick.UltrasonicDist(3);
                    touch = brick.TouchPressed(1);
                    touch2 = brick.TouchPressed(2);
                    disp(distance);
                    startMoving = 1;
                    
                elseif touch2
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    pause(1);
                    brick.MoveMotor('A', -20);
                    brick.MoveMotor('B', -18.6465);
                    pause(0.2);
                    brick.MoveMotor('B', 25);
                    pause(0.2);
                    
                    distance = brick.UltrasonicDist(3);
                    touch = brick.TouchPressed(1);
                    touch2 = brick.TouchPressed(2);
                    disp(distance);
                    startMoving = 1;
                    
                    
                    
                    
                elseif (distance > 20 && color == 5)
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    pause(3);
                    brick.MoveMotor('A', 50);
                    brick.MoveMotor('B', 48.6465);
                    pause(1);
                    
                    distance = brick.UltrasonicDist(3);
                    touch = brick.TouchPressed(1);
                    touch2 = brick.TouchPressed(2);
                    
                elseif (distance < 20)
                    
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    % turn right
                    pause(1);
                    brick.MoveMotor('A', -28);
                    brick.MoveMotor('B', 26.6465);
                    pause(0.875);
                    brick.StopMotor('A');
                    brick.StopMotor('B');
                    numRightTurns = 1;
                    pause(0.5);
                    distance = brick.UltrasonicDist(3);
                    disp(distance);
                    pause(0.5);
                    
                    distance = brick.UltrasonicDist(3);
                    disp(distance);
                    touch = brick.TouchPressed(1);
                    touch2 = brick.TouchPressed(2);
                    
                    
                    if (distance < 20)
                        
                        % turn to the left 180 degrees
                        
                        brick.MoveMotor('A',  -49.1); % -49.1
                        brick.MoveMotor('B', 45.9125); % 45.9125
                        pause(0.675);
                        brick.StopMotor('A');
                        brick.StopMotor('B');
                        
                        distance = brick.UltrasonicDist(3);
                        disp(distance);
                        touch = brick.TouchPressed(1);
                        touch2 = brick.TouchPressed(2);
                        
                        
                        if (distance < 20)
                            
                            % turn backwards (around 3pi/2)
                            pause(1);
                            brick.MoveMotor('A', 26.6465);
                            brick.MoveMotor('B', -28);
                            pause(0.675);
                            brick.StopMotor('A');
                            brick.StopMotor('B');
                            
                            
                            distance = brick.UltrasonicDist(3);
                            startMoving = 1;
                            touch = brick.TouchPressed(1);
                            touch2 = brick.TouchPressed(2);
                            
                            
                        end
                        
                        
                        
                        
                        
                    end
                end
            end
            
            
            
        case 'q'
            
            disp('Quit Program');
            brick.StopMotor('A');
            brick.StopMotor('B');
            break;
            
        case 'r'
            
            disp('Restart');
            disp('Make sure to press the ''Up Arrow''');
            startMoving = 0;
            
            
    end % end of switch statement
    
end % end of while loop


CloseKeyboard();