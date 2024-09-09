clc;
%% step= 1
k_values = [0.2,1.2, 2.2,3.2,4.2,5.2,6.2,7.2,8.2 ];
ncc_values = zeros(size(k_values));

for i = 1:length(k_values)
    % Load and preprocess the first image
    im = imread(sprintf('D:\\LED\\hinh\\k.%g.png', k_values(i)));
    newIm1 = rgb2gray(imresize(im, [512, 512]));

    % Load and preprocess the second image
    im1 = imread(sprintf('D:\\LED\\hinh\\k.%g.png', k_values(i) + 1.0));
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
