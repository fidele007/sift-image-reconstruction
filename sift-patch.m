[sifts, meta] = siftgeo_read('cat.siftgeo');

function C = crop(I, x, y, r=1, A)
  [n_row n_col n_cha] = size(I);

  [xx, yy] = ndgrid((1:n_row)-y,(1:n_col)-x);
  % mask = uint8((xx.^2/9 + yy.^2/4) < r^2);
  mask = uint8(((A(1)*xx).^2 + (A(4)*yy).^2 + (A(2)+A(3))*(xx.*yy)) < 1);
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

img=imread('cat.jpg');

X = meta(6,1:2); % position
A = meta(6,5:8); % affine matrix
crop = crop(img, X(1), X(2), 100, A);
figure; imshow(get_patch(crop));