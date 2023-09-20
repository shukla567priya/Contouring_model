% Parameters
sigma = 5;
beta = 12;
inhibitionFactor = 1.48;
highthresh = 0.007;


% List of file names
file_names = {
    'elephants.jpg',
    'golfcart.jpg',
    'gnu.jpg',
    'hyena.jpg',
    'tire.jpg',
    'elephant.jpg',
    'elephant_3.jpg',
    'elephant_2.jpg',
    'buffalo.jpg',
    'elephants_2.jpg',
    'elephant_4.jpg',
    'gazelle.jpg',
    'turtle.jpg',
    'goat.jpg',
    'buffalo_2.jpg',
    'goat_7.jpg',
    'goat_8.jpg',
    'lions.jpg',
    'goat_4.jpg',
    'bear_2.jpg',
    'gnu_2.jpg',
    'tiger.jpg',
    'goat_2.jpg',
    'gazelle_2.jpg',
    'rino_2.jpg',
    'brush.jpg',
    'rino_3.jpg',
    'rino.jpg',
    'bear.jpg',
    'goat_3.jpg',
    'basket.jpg',
    'goat_5.jpg',
    'bear_3.jpg',
    'bear_5.jpg',
    'goat_6.jpg',
    'bears.jpg',
    'bear_4.jpg',
    'bear_6.jpg',
    'bear_8.jpg',
    'bear_7.jpg'
};
%list of file names for ground truth
additional_file_names = {
    'golfcart_gt_binary.jpg',
    'gnu_gt_binary.jpg',
    'hyena_gt_binary.jpg',
    'tire_gt_binary.jpg',
    'elephant_gt_binary.jpg',
    'elephant_3_gt_binary.jpg',
    'elephant_2_gt_binary.jpg',
    'buffalo_gt_binary.jpg',
    'elephants_2_gt_binary.jpg',
    'elephant_4_gt_binary.jpg',
    'gazelle_gt_binary.jpg',
    'turtle_gt_binary.jpg',
    'goat_gt_binary.jpg',
    'buffalo_2_gt_binary.jpg',
    'goat_7_gt_binary.jpg',
    'goat_8_gt_binary.jpg',
    'lions_gt_binary.jpg',
    'goat_4_gt_binary.jpg',
    'bear_2_gt_binary.jpg',
    'gnu_2_gt_binary.jpg',
    'tiger_gt_binary.jpg',
    'goat_2_gt_binary.jpg',
    'gazelle_2_gt_binary.jpg',
    'rino_2_gt_binary.jpg',
    'brush_gt_binary.jpg',
    'rino_3_gt_binary.jpg',
    'rino_gt_binary.jpg',
    'bear_gt_binary.jpg',
    'goat_3_gt_binary.jpg',
    'basket_gt_binary.jpg',
    'goat_5_gt_binary.jpg',
    'bear_3_gt_binary.jpg',
    'bear_5_gt_binary.jpg',
    'goat_6_gt_binary.jpg',
    'bears_gt_binary.jpg',
    'bear_4_gt_binary.jpg',
    'bear_6_gt_binary.jpg',
    'bear_8_gt_binary.jpg',
    'bear_7_gt_binary.jpg'
};


% Initialize arrays to store F-measure for both scenarios
fMeasureCORFArray = zeros(1, numel(file_names));
fMeasureGaborArray = zeros(1, numel(file_names));
imageNames = cell(1, numel(file_names));

% Loop through each image file
for idx = 1:numel(file_names)-1
    % Load the image and ground truth binary
    image = imread(file_names{idx});
    groundTruthBinary = imread(additional_file_names{idx});
    
    % Extract the image name without the ".jpg" extension
    [~, imageName, ~] = fileparts(file_names{idx});
    imageNames{idx} = imageName;
    
    % Apply CORF contour detection
    [binmapCORF, ~] = CORFContourDetection(image, sigma, beta, inhibitionFactor, highthresh);
    
    % Apply CallGabor
    outputGabor = CallGabor(image);
    
    % Calculate true positives, false positives, and false negatives for CORF
    truePositivesCORF = sum(groundTruthBinary(:) & binmapCORF(:));
    falsePositivesCORF = sum(~groundTruthBinary(:) & binmapCORF(:));
    falseNegativesCORF = sum(groundTruthBinary(:) & ~binmapCORF(:));
    
    % Calculate true positives, false positives, and false negatives for Gabor
    truePositivesGabor = sum(groundTruthBinary(:) & outputGabor(:));
    falsePositivesGabor = sum(~groundTruthBinary(:) & outputGabor(:));
    falseNegativesGabor = sum(groundTruthBinary(:) & ~outputGabor(:));
    
    % Calculate precision and recall for both scenarios
    precisionCORF = truePositivesCORF / (truePositivesCORF + falsePositivesCORF);
    recallCORF = truePositivesCORF / (truePositivesCORF + falseNegativesCORF);
    precisionGabor = truePositivesGabor / (truePositivesGabor + falsePositivesGabor);
    recallGabor = truePositivesGabor / (truePositivesGabor + falseNegativesGabor);
    
    % Calculate F-measure for both scenarios
    fMeasureCORF = (2 * precisionCORF * recallCORF) / (precisionCORF + recallCORF);
    fMeasureGabor = (2 * precisionGabor * recallGabor) / (precisionGabor + recallGabor);
    
    % Store F-measure for both scenarios in arrays
    fMeasureCORFArray(idx) = fMeasureCORF;
    fMeasureGaborArray(idx) = fMeasureGabor;
end
figure;
%plot the point graph
plot(fMeasureCORFArray, 'o-', 'DisplayName', 'CORF');
hold on;
plot(fMeasureGaborArray, 's-', 'DisplayName', 'Gabor');
hold off;
xlabel('Image Names');
ylabel('F-Measure');
legend('Location', 'Best');
xticks(1:length(imageNames));
xticklabels(imageNames);
title('F-Measure Comparison between CORF and Gabor for Different Images');
grid on;
% Plot the values of measureCORF and measureGabor bar graph
% figure;
% bar([fMeasureCORFArray; fMeasureGaborArray]');
% xlabel('Image Names');
% ylabel('F-Measure');
% legend('CORF', 'Gabor');
% xticklabels(imageNames);
% title('F-Measure Comparison between CORF and Gabor for Different Images');
% grid on;
