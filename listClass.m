classdef moveList
    properties
        movements = [];
    end

    methods
        function this = moveList(addVal)
            this.movements[movements.end+1] = addVal;
        end
    end 
end