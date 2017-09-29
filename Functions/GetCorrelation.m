function GetCorrelation(NumIm, OrdCorr, PlaineCorr)
%     PlaineCorrPsNCC, PlaineCorrPsPSNR, PlaineCorrPsNRM)
% Function that compute and print the correlation between the marks of
%classifiers given by traditionally-used metrics and new
%statistically-based pseudo-metrics

AvgCorrelationOfPsFM = sum(OrdCorr(1,:), 'omitnan') / NumIm;
AvgCorrCorrAltRefGT = sum(OrdCorr(2,:), 'omitnan') / NumIm;
fprintf('\n\nAverage correlation of algorithm`s order between order given by\n F-Measure and Pseudo F-Measure: %.4g \n', AvgCorrelationOfPsFM);
fprintf('Average correlation of algorithm`s order between order given by\n F-Measure and Reference Method: %.4g \n', AvgCorrCorrAltRefGT);

AvgCorrPsFM = sum(PlaineCorr(1,:), 'omitnan') / NumIm;
AvgCorrPsNCC = sum(PlaineCorr(2,:), 'omitnan') / NumIm;
AvgCorrPsPSNR = sum(PlaineCorr(3,:), 'omitnan') / NumIm;
AvgCorrPsNRM = sum(PlaineCorr(4,:), 'omitnan') / NumIm;

fprintf('\n\nAverage correlation and standad deviation of Pseudo-Metrics and GT-based metrics (between the values):\n\n');
fprintf('Pseudo F-Measure\tPseudo NCC\t\tPseudo PSNR\t\tPseudo NRM\n');

fprintf('%.4g\t\t\t\t%.4g\t\t\t%.4g\t\t\t%.4g\n', AvgCorrPsFM,...
    AvgCorrPsNCC, AvgCorrPsPSNR, AvgCorrPsNRM);
fprintf('%.4g\t\t\t\t%.4g\t\t\t%.4g\t\t\t%.4g\n\n', std(PlaineCorr(1,:)),...
    std(PlaineCorr(2,:)), std(PlaineCorr(3,:)), std(PlaineCorr(4,:)));