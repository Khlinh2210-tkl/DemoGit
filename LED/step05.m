clc;
k_values = [0.2, 0.7, 1.2, 1.7, 2.2, 2.7, 3.2, 3.7, 4.2, 4.7, 5.2, 5.7, 6.2, 6.7, 7.2, 7.7,8.2];
ncc_values = zeros(size(k_values));

for i = 1:length(k_values)
    % Load and preprocess the first image
    im = imread(sprintf('D:\\LED\\hinh\\k.%g.png', k_values(i)));
    newIm1 = rgb2gray(imresize(im, [512, 512]));

    % Load and preprocess the second image
    im1 = imread(sprintf('D:\\LED\\hinh\\k.%g.png', k_values(i) + 0.5));
    newIm2 = rgb2gray(imresize(im1, [512, 512]));

    % Compute NCC
    ncc_values(i) = abs(corr2(newIm2, newIm1)) * 100;
end

% Plotting
figure(3);
plot(k_values, ncc_values, 'o-', 'LineWidth', 1.5, 'MarkerSize', 8);
xlabel('k (W/m.K)');
ylabel('NCC (%)');
title('NCC vs k');
grid on;
