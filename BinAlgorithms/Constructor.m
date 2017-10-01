function [BinName, output_arr] = Constructor( varargin )
%CONSTRUCTOR 
%   Merging N same size arrays for further usage
%   [BINNAME] - Vector with names of given arrays

Numvarargs = length(varargin); 
ImageIn = varargin{1};
[N, M] = size(ImageIn);
output_arr = zeros(Numvarargs, N, M); 
BinName = cell(Numvarargs, 1);

for i = 1:Numvarargs
    output_arr(i,:,:) = varargin{i};
    BinName{i,1} = sprintf('%s', inputname(i));
end