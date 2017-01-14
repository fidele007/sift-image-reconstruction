clear all;
close all;

function C = crop(I, x, y, r)
  [n_row n_col n_cha] = size(I);
  [xx, yy] = ndgrid((1:n_row)-y,(1:n_col)-x);
  mask = uint8((xx.^2/9 + yy.^2/4) < r^2);
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

img=imread('../cat.jpg');

crop = crop(img, 500, 600, 100);
figure; imshow(get_patch(crop));