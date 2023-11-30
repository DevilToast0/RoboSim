% ConnectToEV3.m
% MAKE SURE PATH IS SET TO MatLab/EV3!!

% DISCONNECT

% Try catch statement:
% Try catch tries to run the code inside of the 'try' bracket. 
% If it has an error it will print it out in the 'catch' statement.
% The code tries to disconnect the brick. If there is not brick connected
% it will return an error. (This is on purpose). If there is a brick
% connected it will disconnect the brick so it can reconnect it.
try
   DisconnectBrick(brick);

   disp("DISCONNECTED");

catch exception

end

disp("--------------------------------------");

% CONNECT

% connects the brick to matlabs.
brick = Brick('ioType','wifi','wfAddr','127.0.0.1','wfPort',5555,'wfSN','0016533dbaf5');

% happy connection tone!
brick.playTone(100, 2000, 1000);

disp("CONNECTED");