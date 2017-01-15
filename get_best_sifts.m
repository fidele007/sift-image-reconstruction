NUM_DESC = 1125;

function bestSifts = get_best_sifts(imageSift)

[sifts, meta] = siftgeo_read(imageSift);

% for each descriptor, search its nearest neighbor in the external database
siftFiles = glob('../siftgeo/*.siftgeo');
bestSifts = []
allSifts = load('allSifts.mat');

for i=1:size(sifts,1)
  d = pdist2(allSifts,sifts(i,:));
  best_ind = find(d==max(d))(1);
  [~, name] = fileparts(siftFiles{ceil(best_ind/NUM_DESC)});
  best_name = str2num(name);
  best_region = mod(best_ind, NUM_DESC);
  if (best_region == 0)
    best_region = NUM_DESC
  endif

  bestSifts = [bestSifts ; best_name best_region];
endfor

save bestSifts.mat bestSifts

endfunction
