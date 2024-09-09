clc;
im= imread("D:\LED\hinh\k.0.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.0.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc=abs((corr2(newIm2, newIm1))*100)
ncc1=(corr2(newIm1, newIm2))

%%%%
im= imread("D:\LED\hinh\k.1.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.1.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc2=abs((corr2(newIm2, newIm1))*100)
ncc3=(corr2(newIm1, newIm2))

%%%%%
im= imread("D:\LED\hinh\k.2.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.2.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc4=abs((corr2(newIm2, newIm1))*100)
ncc5=(corr2(newIm1, newIm2))

%%%
im= imread("D:\LED\hinh\k.3.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.3.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc6=abs((corr2(newIm2, newIm1))*100)
ncc7=(corr2(newIm1, newIm2))

%%%
im= imread("D:\LED\hinh\k.4.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.4.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc8=abs((corr2(newIm2, newIm1))*100)
ncc9=(corr2(newIm1, newIm2))

%%%
im= imread("D:\LED\hinh\k.5.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.5.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc10=abs((corr2(newIm2, newIm1))*100)
ncc11=(corr2(newIm1, newIm2))

%%%
im= imread("D:\LED\hinh\k.6.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.6.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc12=abs((corr2(newIm2, newIm1))*100)
ncc13=(corr2(newIm1, newIm2))

%%%
im= imread("D:\LED\hinh\k.7.2.png");
newIm1=rgb2gray(imresize(im, [512, 512]));
figure(1);
imshow(newIm1);

im1=imread("D:\LED\hinh\k.7.7.png");
newIm2=rgb2gray(imresize(im1,[512, 512]));
figure(2);
imshow(newIm2);
ncc14=abs((corr2(newIm2, newIm1))*100)
ncc15=(corr2(newIm1, newIm2))

%%%%
k = [0.2,0.7,1.2,1.7,2.2, 2.7,3.2, 3.7,4.2, 4.7, 5.2, 5.7, 6.2, 6.7,7.2,7.7];
ncc = [ncc1,ncc3, ncc5, ncc7, ncc9, ncc11,ncc13,ncc15];

figure(3);
plot(k, ncc);
xlabel('k(W/m.k)');
ylabel('NCC(%)');
title(' NCC and k');
grid on;
