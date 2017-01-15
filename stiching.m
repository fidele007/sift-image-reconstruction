function img = stiching(I, x, y, im_patch, dr)
  img = I;
  [dx dy r] = size(im_patch);
  %disp(size(im_patch));
  %disp(size(I(floor(x-dx/2):floor(x+dx/2 - 1), floor(y-dy/2):floor(y+dy/2 - 1), :)));
  for xx=1:dx
    for yy=1:dy
      a = floor(x-dx/2 - 1 + xx);
      b = floor(y-dy/2 -1 + yy);
      %disp(a);
      %disp(b);
%      if (((a > floor(dr/2+1)) && (a < floor(dx - dr/2)) && (b > upper(dr/2+1)) && (b < floor(dy - dr/2 - 1))))
        img(a, b,:) = im_patch(xx, yy, :);
%      endif
    endfor
  endfor
endfunction


%img = imread("a.jpg");
%p_1 = imread("patch_1.jpg");
%imshow(img);
%title("Original image");

%figure;
%n_img = stiching(img, 500, 100, 20, p_1);
%title("Patch image");
%imshow(n_img);
