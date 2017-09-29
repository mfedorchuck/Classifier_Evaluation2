function GetDifference(NumIm, WordDist, SeqenceCost)
%   Function that compute and print Word-edit distance and Seqence-alignment
%   cost between the order of classifiers given by: 
%   1. Traditionally-used F-measure and pseudo F-measure
%   2. Traditionally-used F-measure and Reference method

    PsFMDistance = sum(WordDist(1,:), 'omitnan') / NumIm;
    RefDistance = sum(WordDist(2,:), 'omitnan') / NumIm;
    
    FMSeqenceCost = sum(SeqenceCost(1,:), 'omitnan') / NumIm;
    RefSeqenceCost = sum(SeqenceCost(2,:), 'omitnan') / NumIm;
    
    fprintf('\n\nAverage word-edit distance between order given by\n');
    fprintf('F-Measure and Pseudo F-Measure: %.4g \n', PsFMDistance);
    fprintf('F-Measure and Reference Method: %.4g \n', RefDistance);
    
    fprintf('\n\nAverage sequence alignment cost between order given by\n');
    fprintf('F-Measure and Pseudo F-Measure: %.4g \n', FMSeqenceCost);
    fprintf('F-Measure and Reference Method: %.4g \n', RefSeqenceCost);
end