NUM_FILES = 100;

% for each descriptor, search its nearest neighbor in the external database
bestSifts = get_best_sifts('building.siftgeo', NUM_FILES);

% Read reference sift and image
[sifts, meta] = siftgeo_read('building.siftgeo');
img=imread('building.jpg');
[a, b] = size(meta);

% Read best sift matrice
best_sift = load('bestSifts_building.mat');
[nb t] = size(best_sift);

final = zeros(size(img));
% Find & replace patch image corresponding to sift descriptor
for i=1:nb
  X = meta(i,1:3);
  final=get_image_patch(best_sift(i , 1), best_sift(i , 2), 2 * sqrt(X(3)), X, final);
  if mod(i, 500)==0
    figure;
    imshow(final/255);
  endif
endfor

figure;
imshow(img);
figure;
imshow(final/255);