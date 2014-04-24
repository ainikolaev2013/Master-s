%Record the spectra for the given stacks

dataDirk = './data/16/K';
dataDiri = './data/16/I';

listk=dir ('./data/16/K/*.mat');
listi=dir ('./data/16/I/*.mat');

resultsDir='./output/16';

for iterator =1:numel(listk)
disp (listk(iterator).name)

load(fullfile(dataDirk, listk(iterator).name), 'Gdown_stack');


dataf=spectrum_cell(squeeze(Gdown_stack(:,15,41,1)));


fig=plot([2:200]/800*25, abs(dataf(3:200+1)), 'r');
title([(listk(iterator).name)  ' channel 1'])
  saveas(fig, fullfile(resultsDir,['K-' (listk(iterator).name) '-15-41.fig']));




end;


for iterator =1:numel(listi)
disp (listi(iterator).name)

load(fullfile(dataDiri, listi(iterator).name), 'Gdown_stack');


dataf=spectrum_cell(squeeze(Gdown_stack(:,22,33,1)));


fig=plot([2:200]/800*25, abs(dataf(3:200+1)), 'r');
title([(listi(iterator).name)  ' channel 1'])
  saveas(fig, fullfile(resultsDir,['I-' (listi(iterator).name) '-22-33.fig']));




end;