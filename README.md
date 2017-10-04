# Classifier_Evaluation2
Two statistically-based approaches for evaluation of a set of classifiers

The Main.m is a program which perform traditional evaluation metrics and  two statistically-based approaches for classifiers evaluation.


The program performs next stages (in the loop - for all the images):

1 - open the test image from graphics file;

2 - apply 10 binarization algorithms for every image;

3 - Calculate and print the table with applied traditional metrics for
binarization algorithms, according to Ground Truth;

4 - Calculate and print the table with applied statistically-based
metrics for binarization algorithms (without Ground Truth);

5 - Calculate the order of classifiers from best to worsed by using
Reference Method (without Ground Truth);

And, in the end:

6 - Calculate how good not-traditionally used evaluation systems 
(Pseudo-metrics and proposed Reference method ) are good by 
calculating (average values through dataset):

   - Average sequence alignment cost between the order of classifiers 
   - Average word-edit distance between the order of classifiers  
   - Average correlation of algorithm`s order between the order given by 
		F-Measure and statistically-based approaches
   - Average correlation between traditionally-used metrics (F1-score, 
		PSNR, NRM, NCC) and statistically-based pseudo-metrics