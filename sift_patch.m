% This function returns an elliptic image patch knowing its SIFT

function P = sift_patch(I, x, y, A)
  % get ellipse equation
  [v e] = eig(A); % return eigen vectors and eigen values
  a = 1/sqrt(e(1));
  b = 1/sqrt(e(4));
  [n_row n_col n_cha] = size(I);
  [yy, xx] = ndgrid((1:n_row)-y,(1:n_col)-x);
  mask = uint8((xx.^2 + yy.^2) < 100);
  size(mask)
  % mask = uint8(((xx.^2)./a^2 + (yy.^2)./b^2) < 1);

  C = uint8(zeros(n_row, n_col));
  for i=1:n_cha
    C(:,:,i) = I(:,:,i).*mask;
  endfor

  % keep only the patch and remove the others
  for i=1:n_cha
    tmp = C(:,:,i);
    tmp(~any(tmp,2),:) = []; %remove 0 rows
    tmp(:,~any(tmp,1)) = []; % remove 0 columns
    P(:,:,i) = tmp;
  endfor
endfunction