close all
clear
clc

%% -- IN ------------------------------------------------------------------
folder = 'Cap02_DIPUM_images';

%% ------------------------------------------------------------------------
f = imread('cameraman.tif');
whos f
figure; imshow(f);
figure; imshow(f,[]);
impixelinfo

%% ------------------------------------------------------------------------
figure; imshow(f,[50 200]);

%% --- Ampliar rango dinámico ---------------------------------------------
% h = imread('patient10_run1.tif');
h = imread('xray-chest.png');
hgray = rgb2gray(h);
figure; imshow(h);
figure; imshow(h,[]);

%% --- Grabar imagen ------------------------------------------------------
%imfinfo cameraman.tif
X = imread('bubbles.png');
Xgray=rgb2gray(X);
imwrite(Xgray,'bubbles50.jpeg','q',50);
imwrite(Xgray,'bubbles25.jpeg','q',25);
imwrite(Xgray,'bubbles10.jpeg','q',10);
imwrite(Xgray,'bubbles05.jpeg','q',5);
X05=imread('bubbles05.jpeg');
X50=imread('bubbles50.jpeg');
K05=imfinfo('bubbles05.jpeg');
K50=imfinfo('bubbles50.jpeg');
X05_bytes=K05.Width*K05.Height*K05.BitDepth/8;
X50_bytes=K50.Width*K50.Height*K50.BitDepth/8;
X05_Compressed_bytes=K05.FileSize;
X50_Compressed_bytes=K50.FileSize;
X05_Compression_ratio=X05_bytes/X05_Compressed_bytes;
X50_Compression_ratio=X50_bytes/X50_Compressed_bytes;

%% --- Métricas -----------------------------------------------------------
%X2 = imread('cameraman05.jpeg');

X2 = imread('bubbles05.jpeg');
RMSE  = sqrt(sum(sum((double(Xgray) - double(X2)).^2)))/sqrt(numel(Xgray))
%RMSEf = norm(double(X) - double(X2),'fro')/sqrt(numel(X))

%% ------------------------------------------------------------------------
X = imread('cameraman.tif');
Xfud = flipud(X);
figure; imshow(Xfud);
Xflr=fliplr(X);
figure; imshow(Xflr);

%% --- Histograma ---------------------------------------------------------
hist(double(X(:)))
