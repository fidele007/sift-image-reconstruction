% Crop image to get patch
function C = crop(I, x, y, r=1, A)
    [n_row n_col n_cha] = size(I);

    [xx, yy] = ndgrid((1:n_row),(1:n_col));
    % mask = uint8((xx.^2/9 + yy.^2/4) < r^2);
    val = ( A(1, 1) .* (xx .- x) .* (xx - x) .+ 2 .* A(1, 2) .* (xx .- x) .* (yy .- y) );
    val = val + A(2, 2) .* (yy .- y) .* (yy .- y);
    mask = uint8(val <= 1);
    C = uint8(zeros(n_row, n_col));

    for i=1:n_cha
      C(:,:,i) = I(:,:,i).*mask;
    endfor
endfunction

% Get image from cropped matrix
function P = get_patch(I)
    n_cha = size(I,3);
    for i=1:n_cha
      tmp = I(:,:,i);
      tmp(~any(tmp,2),:) = []; %remove 0 rows
      tmp(:,~any(tmp,1)) = []; % remove 0 columns
      P(:,:,i) = tmp;
    endfor
endfunction

function X = getImagePatch(n_img, n_sift, r=10, C, ref_img)
    n_fich = strcat('siftgeo/', num2str(n_img), '.siftgeo');
    n_file = strcat('jpg/', num2str(n_img), '.jpg');
    f = imread(n_file);
    [sifts_p, meta_p] = siftgeo_read(n_fich);
    S = size(f);
    l = size(meta_p);
    if (n_sift <= l(1))
      X_s = meta_p(n_sift,1:2);
      x_s = max([floor(X_s(1) - r / 2), 1]);
      x_e = min([floor(X_s(1) + r / 2 - 1), S(1)]);
      y_s = max([floor(X_s(2) - r / 2), 1]);
      y_e = min([floor(X_s(2) + r / 2 - 1), S(2)]);
      X = f(x_s:x_e, y_s:y_e, :);
      X = stiching(ref_img, C(1), C(2), X, r);
    else
      disp("ici");
      X=ref_img;
    endif
endfunction

% Read reference sift and image
[sifts, meta] = siftgeo_read('building/building.siftgeo');
img=imread('building/building.jpg');
[a, b] = size(meta);

% Read best sift matrice
best_sift = load("building/bestSifts_building.mat");
[nb t] = size(best_sift);

% Find & replace patch image corresponding to sift descriptor
for i=1:nb
  X = meta(i,1:3);
  img=getImagePatch(best_sift(i , 1), best_sift(i , 2), sqrt(X(3)), X, img);
endfor

figure;
imshow(img);
