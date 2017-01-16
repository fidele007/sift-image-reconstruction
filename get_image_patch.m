function X = get_image_patch(n_img, n_sift, r=10, C, ref_img)
    n_fich = strcat('../siftgeo/', num2str(n_img), '.siftgeo');
    n_file = strcat('../jpg/', num2str(n_img), '.jpg');
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
      X = stitch(ref_img, C(2), C(1), X, r);
    else
      disp("ici");
      X=ref_img;
    endif
endfunction