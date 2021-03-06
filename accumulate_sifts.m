% Store all SIFT and its metadata of the external image database

siftFiles = glob('../siftgeo/*.siftgeo');
allSifts = [];
allMeta = [];

for i=1:100
  [~, name] = fileparts(siftFiles{i});
  [exSift, exMeta] = siftgeo_read(['../siftgeo/' name '.siftgeo']);
  allSifts = [allSifts;exSift];
  allMeta = [allMeta; exMeta];
endfor

save allSifts.mat allSifts
save allMeta.mat allMeta
