
 sigma = 5;
 beta = 12;
 inhibitionFactor = 1.48;
 highthresh = 0.007;

  addpath('./image/');
  % Create an empty numeric array
  %imagearray = [rino.jpg, elephants.jpg,gnu.jpg, hyena.jpg];
  %gtarray = [rino_gt_binary.jpg, elephants_gt_binary.jpg, gnu_gt_binary.jpg, hyena_gt_binary.jpg];
  %gaborarray = [];
  %corfarray = [];
  %precisionarray= [];
  %recallarray = [];
  %farray = [];

  % Initialize a cell array to store the loaded images
  %loadedImages = cell(1, numel(imagearray));
  % Loop through the image file names and read each image
 
  % Add elements to the array
  %gtarray = [numericArray, 1, 2, 3];
  imageRino = imread('rino.jpg');
 imageRinoContour = imread('rino_gt_binary.jpg');
 imageElephants = imread('elephants.jpg');
 imageElephantsContour = imread('elephants_gt_binary.jpg');
 imageGnu = imread('gnu.jpg');
 imageGnuContour = imread('gnu_gt_binary.jpg');
 imageHyena = imread('hyena.jpg');
 imageHyenaContour = imread('hyena_gt_binary.jpg');
  [binmaprino, corfresponserino] = CORFContourDetection(imageRino,sigma,beta,inhibitionFactor,highthresh);
  [binmapelephant, corfresponserelephant] = CORFContourDetection(imageElephants,sigma,beta,inhibitionFactor,highthresh);
  [binmapgnu, corfresponsegnu] = CORFContourDetection(imageGnu,sigma,beta,inhibitionFactor,highthresh);
  [binmaphyena, corfresponseheyna] = CORFContourDetection(imageHyena,sigma,beta,inhibitionFactor,highthresh);

outputRino = CallGabor(imageRino);
outputElephants = CallGabor(imageElephants);
outputGnu = CallGabor(imageGnu);
outputHyena = CallGabor(imageHyena);

Create a 4x4 subplot grid and display images
figure; % Create a new figure

% First Row
subplot(4, 4, 1);
imshow(imageRino);
title('imageRino');

subplot(4, 4, 2);
imshow(imageElephants);
title('imageElephants');

subplot(4, 4, 3);
imshow(imageGnu);
title('imageGnu');

subplot(4, 4, 4);
imshow(imageHyena);
title('imageHyena');

% Second Row
subplot(4, 4, 5);
imshow(imageRinoContour);
title('imageRinoContour');

subplot(4, 4, 6);
imshow(imageElephantsContour);
title('imageElephantsContour');

subplot(4, 4, 7);
imshow(imageGnuContour);
title('imageGnuContour');

subplot(4, 4, 8);
imshow(imageHyenaContour);
title('imageHyenaContour');

% Third Row
subplot(4, 4, 9);
imshow(outputRino);
title('gaborrino');


subplot(4, 4, 10);
imshow(outputElephants);
title('gaboroutputElephants');

subplot(4, 4, 11);
imshow(outputGnu);
title('gaboroutputGnu');

subplot(4, 4, 12);
imshow(outputHyena);
title('gaborHyena');

% Fourth Row
subplot(4, 4, 13);
imshow(binmaprino);
title('corfrino');

subplot(4, 4, 14);
imshow(binmapelephant);
title('corfelephant');

subplot(4, 4, 15);
imshow(binmapgnu);
title('corfgnu');

subplot(4, 4, 16);
 imshow(binmaphyena);
 title('corfhyena');
