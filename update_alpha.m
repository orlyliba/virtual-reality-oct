% script to update alpha in png files

inFolder = '';

outFolder = '';

alphaScale = 0.5; % scaling factor for alpha


inFiles = dir([inFolder '*.png']);

for k=1:length(inFiles)
    
	[a, map, alphamap] = imread([inFolder inFiles(k).name]);

	alphamap = uint8(double(alphamap)*alphaScale);
    
    imwrite(a, [outFolder inFiles(k).name], 'png', 'Alpha', alphamap);

end