function output = callGabor(image)
%addpath('./img/');
% Load the image
%image = imread('rino.pgm'); % Replace 'your_image.jpg' with the path to your image

% Load the image
%image = imread('your_image.jpg'); % Replace 'your_image.jpg' with the path to your image

% Convert the image to grayscale if it's not already
if size(image, 3) == 3
    image_gray = rgb2gray(image);
else
    image_gray = image;
end

% Define Gabor filter parameters
lambda = 20;        % Wavelength of the sinusoidal factor
theta = 90;          % Orientation of the Gabor filter (in degrees)
psi = 0;            % Phase offset of the sinusoidal factor
gamma = 0.5;        % Spatial aspect ratio (controls the ellipticity of the filter)
sigma = 5;          % Standard deviation of the Gaussian envelope
size_filter = 15;   % Size of the filter kernel (should be odd)

% Create the Gabor filter
gb = gabor2D(lambda, theta, psi, gamma, sigma, size_filter);

% Convolve the image with the Gabor filter
filtered_image = imfilter(double(image_gray), gb, 'conv');

% Create a contour boundary map
contour_map = edge(abs(filtered_image), 'Canny'); % You can use other edge detection methods too
contour_map = 1-contour_map;


% Display the contour boundary map
%figure;
%imshow(contour_map);
%title('Contour Boundary Map');

% Function to create a 2D Gabor filter
function gb = gabor2D(lambda, theta, psi, gamma, sigma, size_filter)
    % Generate a 2D grid of coordinates
    [x, y] = meshgrid(-floor(size_filter/2):floor(size_filter/2), -floor(size_filter/2):floor(size_filter/2));
    
    % Rotation
    x_theta = x * cos(theta) + y * sin(theta);
    y_theta = -x * sin(theta) + y * cos(theta);
    
    % Calculate the Gabor function
    gb = exp(-0.5 * (x_theta.^2 + gamma^2 * y_theta.^2) / sigma^2) .* cos(2 * pi / lambda * x_theta + psi);
end
output = contour_map;

end