% FIGURE 8 SCRIPT

run ConnectToEV3.m; 

disp("INITIALIZING...");
loops = 0;
brick.MoveMotor('A', 25);
brick.MoveMotor('B', -25);
pause(.6);
brick.StopAllMotors("Brake");
pause(2);
%forward
brick.MoveMotor('A', 100);
brick.MoveMotor('B', 100);
pause (1.8);

while loops < 3
    
    %turn left
    brick.MoveMotor('A', 83);
    brick.MoveMotor('B', 100);
    pause (6.6);

    %forward
    brick.MoveMotor('A', 100);
    brick.MoveMotor('B', 100);
    pause (4);

    %turn right
    brick.MoveMotor('A', 100);
    brick.MoveMotor('B', 83);
    pause (6.6);
    
    

    %forward
    brick.MoveMotor('A', 100);
    brick.MoveMotor('B', 100);
    if (loops == 2)
        pause(2.5);
        brick.StopAllMotors('Brake');
    end
    pause(4);

    loops = loops + 1;
end

disp("complete");