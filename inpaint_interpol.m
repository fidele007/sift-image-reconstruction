I = double(imread('res.jpg'));
I = I/255;
[n_row n_col n_char] = size(I);

I(I<0.1) = NaN;

for i=1:n_char
  V(:,:,i) = inpaint_nans(I(:,:,i),1);
endfor

figure; imshow(V);