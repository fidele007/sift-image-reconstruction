clear all;
close all;

function img = stiching(I, x, y, r, im_patch)
  img = I;
  [dx dy r] = size(im_patch);
%  disp(size(im_patch));
%  disp(size(I(floor(x-dx/2):floor(x+dx/2 - 1), floor(y-dy/2):floor(y+dy/2 - 1), :)));
  for xx=1:dx
    for yy=1:dy
      if sum(im_patch(xx, yy) > 0)
        img(floor(x-dx/2 - 1 + xx), floor(y-dy/2 -1 + yy), :) = im_patch(xx, yy, :);
      endif
    endfor
  endfor
endfunction


img = imread("a.jpg");
p_1 = imread("patch_1.jpg");
imshow(img);
title("Original image");

figure;
n_img = stiching(img, 500, 100, 20, p_1);
title("Patch image");
imshow(n_img);
