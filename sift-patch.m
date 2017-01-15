[sifts, meta] = siftgeo_read('cat.siftgeo');

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
      X = f(floor(X_s(1) - r / 2):floor(X_s(1) + r / 2 - 1), floor(X_s(2) - r / 2):floor(X_s(2) + r / 2 - 1), :);
      X = stiching(ref_img, C(1), C(2), X, r);
      %figure;
      %imshow(X);
    else
      disp("ici");
      X=ref_img;
    endif
endfunction

img=imread('cat.jpg');
%imshow(img);

[a, b] = size(meta);
A = reshape(meta(500,5:8), 2, 2); % affine matrix

best_sift = load("best_sifts.mat");
[nb t] = size(best_sift);

for i=1:nb
  X = meta(i,1:3);
  img=getImagePatch(best_sift(i , 1), best_sift(i , 2), 15, X, img);
endfor

figure;
imshow(img);

% crop = crop(img, X(1), X(2), 100, A);
% imshow(get_patch(crop));
% figure; imshow(sifts);
