%   The follow program perform next stages (in the loop for all the images):
%
%   1 - open the test image from graphics file;
%
%   2 - apply 10 binarization algorithms for every image;
%
%   3 - Calculate and print the table with applied traditional metrics for
%   binarization algorithms, according to Ground Truth;
%
%   4 - Calculate and print the table with applied statistically-based
%   metrics for binarization algorithms (without Ground Truth);
%
%   5 - Calculate the order of classifiers from best to worsed by using
%   Reference Method (without Ground Truth);
%
%   6 - Calculate how good not-traditionally used evaluation systems 
%   (Pseudo-metrics and proposed Reference method ) are good by 
%   calculating (average values through dataset):
%   - Average sequence alignment cost between the order of classifiers 
%   - Average word-edit distance between the order of classifiers  
%   - Average correlation of algorithm`s order between the order given by 
%   F-Measure and statistically-based approaches
%   - Average correlation between traditionally-used metrics (F1-score, 
%   PSNR, NRM, NCC) and statistically-based pseudo-metrics

clear all; close all; clc;

fprintf('Time: %02s \n', datestr(now, 'HH:MM:SS')); fprintf('\n');
disp('DIBCO dataset 2009');

% number of images you want to test
NumIm = 10; %DIBCO09 dataset consist of 10 images - 5 printed and 5 - handwritten

% path for test images
ImPath = sprintf('C:/From DropBox/Code and Description/Data_For_Test/DIBCO09/');

for NumOfImage = 1:NumIm
	fprintf('Case number %d in progress...\n', NumOfImage);

    % Opening and classifying curent image 
    ImName = sprintf('%d.bmp', NumOfImage);
    GTName = sprintf('%d.tiff', NumOfImage);

    TestImage = imread(sprintf('%s%s', ImPath, ImName));
    GTImage = imread(sprintf('%s%s', ImPath, GTName));

    [TableOfNames, ArrOfValues] = TenBinClassifiers(TestImage, GTImage);

    %% Evaluation metrics 

    % Ground-Truth based evaluation metrics
    fprintf('\n All the clasifiers, ranged according to traditionally-based metrics (Ground-Truth based):\n');
    ComparizeGTTable = ComparisingWithGT(GTImage, TableOfNames, ArrOfValues);
    disp(sortrows(ComparizeGTTable,'F1_score','descend'));

    % Statistically-based evaluation metrics
    fprintf('\n All the clasifiers, ranged according to statistically based metrics:\n');
    StatEvaluationTable = StatMeasure(TableOfNames, ArrOfValues);
    disp(sortrows(StatEvaluationTable,'St_F1_score','descend'));

    % Reference method
    fprintf('\n Now "Reference Method" are performing (and using every image as a reference):\n');
    ReferenceArr = CompByRef(ArrOfValues, length(TableOfNames));

    %% Tables construction and extraction of classifiers order
    initial_code(:,1) = (['A','B','C','D','E','F','G','H','I','J']);
    abc2(:,1) = 1:10;
    
    ReferenceTable = table(ReferenceArr(:, length(TableOfNames) + 1), initial_code,...
        'RowNames', TableOfNames); %abc2,

    SortedStatTable = sortrows(StatEvaluationTable, 'St_F1_score', 'descend');
    SortedGTTable = sortrows(ComparizeGTTable, 'F1_score', 'descend');
    SortedAltRef = sortrows(ReferenceTable, 'Var1', 'descend');

    Word_GT_FM(:) = SortedGTTable.initial_code;
    Word_Ps_FM(:) = SortedStatTable.initial_code;
    Word_AltRef(:) = SortedAltRef.initial_code;

    SortedGTTable.num = abc2(:); SortedGTTable = sortrows(SortedGTTable, 'initial_code', 'ascend');
    SortedStatTable.num = abc2(:); SortedStatTable = sortrows(SortedStatTable, 'initial_code', 'ascend');
    SortedAltRef.num = abc2(:); SortedAltRef = sortrows(SortedAltRef, 'initial_code', 'ascend');

    %% Comparing words distance and sequence alignment cost between the applied evaluation methods
    WordDist(1, NumOfImage) = SeqAlignCost(Word_Ps_FM, Word_GT_FM);
    WordDist(2, NumOfImage) = SeqAlignCost(Word_AltRef, Word_GT_FM);

    SeqenceCost(1, NumOfImage) = EditDistance(Word_Ps_FM,Word_GT_FM);
    SeqenceCost(2, NumOfImage) = EditDistance(Word_AltRef,Word_GT_FM);

    %% Correlation of marks
    OrdCorr(1, NumOfImage) = corr2(SortedGTTable.num, SortedStatTable.num); % OrdCorrPsFM
    OrdCorr(2, NumOfImage) = corr2(SortedGTTable.num, SortedAltRef.num); % OrdCorrAltRef

    PlaineCorr(1, NumOfImage) = corr2(ComparizeGTTable.F1_score, StatEvaluationTable.St_F1_score);
    PlaineCorr(2, NumOfImage) = corr2(ComparizeGTTable.CrossCorr, StatEvaluationTable.StCrossCorr);
    PlaineCorr(3, NumOfImage) = corr2(ComparizeGTTable.PSNR, StatEvaluationTable.StPSNR);
    PlaineCorr(4, NumOfImage) = corr2(ComparizeGTTable.NRM, StatEvaluationTable.StNRM);

    clear NewRefAltArr

    fprintf('Case number %d complete\n', NumOfImage);
    fprintf('Time: %02s \n\n', datestr(now, 'HH:MM:SS'));
end

%% Comparing applied methods of classifier evaluation and results displaying  
GetDifference(NumIm, WordDist, SeqenceCost); 
GetCorrelation(NumIm, OrdCorr, PlaineCorr);