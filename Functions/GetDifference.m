function GetDifference(NumIm, Ps_FM_Distance, Alt_Ref_Distance, EditPS_FM_distance, EditARef_distance)
%   asd

    AvPsFMDistance = sum(Ps_FM_Distance, 'omitnan') / NumIm;
    AvAltRefDistance = sum(Alt_Ref_Distance, 'omitnan') / NumIm;
    fprintf('\n\nAverage sequence alignment cost between order given by\n F-Measure and Pseudo F-Measure: %.4g \n', AvPsFMDistance);
    fprintf('Average sequence alignment cost between order given by\n F-Measure and Reference Method: %.4g \n', AvAltRefDistance);

    AvRefWordDistance = sum(EditPS_FM_distance, 'omitnan') / NumIm;
    AvPsFMWordDistance = sum(EditARef_distance, 'omitnan') / NumIm;
    fprintf('\n\nAverage word-edit distance between order given by\n F-Measure and Pseudo F-Measure: %.4g \n', AvRefWordDistance);
    fprintf('Average word-edit distance between order given by\n F-Measure and Reference Method: %.4g \n', AvPsFMWordDistance);

end
