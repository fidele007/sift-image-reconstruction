function bestSifts = get_best_sifts(imageSift, numFiles)

  % Get SIFT for the first numFiles in the image database
  siftFiles = glob('../siftgeo/*.siftgeo');
  allSifts = cell(numFiles,2);
  for i=1:numFiles
    [~, name] = fileparts(siftFiles{i});
    [exSift ~] = siftgeo_read(['../siftgeo/' name '.siftgeo']);
    allSifts(i,1) = str2num(name);
    allSifts(i,2) = exSift;
  endfor

  [sifts, meta] = siftgeo_read(imageSift);

  bestSifts = [];
  for i=1:size(sifts,1)
    best_name = 0;
    best_region = 0;
    best_d = 0;
    for j=1:size(allSifts,1)
      d = pdist2(allSifts{j,2},sifts(i,:));
      if (max(d) > best_d)
        best_d = max(d);
        best_region = find(d==max(d))(1);
        best_name = allSifts{j,1};
      endif
    endfor

    bestSifts = [bestSifts ; best_name best_region];
  endfor
  % save the bestSifts matrix for possible reuse
  save bestSifts.mat bestSifts

endfunction