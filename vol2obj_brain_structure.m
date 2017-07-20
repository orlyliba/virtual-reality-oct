% vol2obj_structure
% Convert a Tif stack of structure into png, mat and obj files
%
% Orly Liba, June 2017
%

clc; clear; close all;
FileTif='';
outputFileName = '';
outputPath = '/';
mkdir(outputPath)

%%
vol = double(readTiff(FileTif));
vol = permute(vol,[2 3 1]);

for K=1:size(vol,3)    
    fileName = sprintf([outputFileName '%04d.png'],K-1);        
    %%
    frame = vol(:,:,K);        
    alphamap = frame/255;
    alphamap = alphamap - 0.2;
    alphamap(alphamap<0) = 0;
    alphamap(alphamap>0.2) = 0.2;
    alphamap = alphamap./max(alphamap(:)); 
    % figure; imagesc(alphamap); axis image
    %%
    imwrite(uint8(frame), [outputPath fileName], 'png', 'Alpha', alphamap);   
end

%%
pixSize = 4; % um, lateral
stepSizeZ = 4; % um, axial
FOVSizeY = size(vol,1)*pixSize;
FOVSizeX = size(vol,2)*pixSize;
nFramesZ = size(vol,3);

GenerateObjFunc(nFramesZ,FOVSizeX,FOVSizeY,stepSizeZ,outputPath,outputFileName);