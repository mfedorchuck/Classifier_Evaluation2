classdef class13
%	class13 - class of all output arguments
%	All the results (how good are evaluation method) will be collected here

properties
    NumIm = 0;
    PsFm = 0;
    Ref = 0;
end

methods 
    function WordDist = class13(NumIm, Ps_FM_Distance, Alt_Ref_Distance)
        % Calculation average word edit distance and print it
        if (nargin > 0)
            WordDist.PsFm = sum(Ps_FM_Distance, 'omitnan') / NumIm;
            WordDist.Ref = sum(Alt_Ref_Distance, 'omitnan') / NumIm;
        end
    end    
end % public methods

end