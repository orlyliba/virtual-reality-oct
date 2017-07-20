% vol2obj_vessels
% Convert a Tif stack of angiography into png, mat and obj files
%
% Orly Liba, June 2017
%

clc; clear; close all;
FileTif='';
outputFileName = '';
outputPath = '';

%%
vol = double(readTiff(FileTif));
vol = permute(vol,[2 3 1]);

for K=1:size(vol,3)
    vol(:,:,K) = medfilt2(vol(:,:,K),[3 3]);
    fileName = sprintf([outputFileName '%04d.png'],K-1);
    alphamap = vol(:, :, K)/255*1.5;
    alphamap(alphamap>1) = 1;
    alphamap(alphamap<0.2) = 0;
    frame = vol(:,:,K);
    frame = frame*2;
    frame(frame>255) = 255;
%     alphamap(alphamap > eps) = 0.5;    
    frame = hsv2rgb(10/360*ones(size(vol(:,:,K))),ones(size(vol(:,:,K))),frame);
    imwrite(uint8(frame), [outputPath fileName], 'png', 'Alpha', alphamap);   
end

%%
pixSize = 4; % um, lateral
stepSizeZ = 4; % um, axial
FOVSizeY = size(vol,1)*pixSize;
FOVSizeX = size(vol,2)*pixSize;
nFramesZ = size(vol,3);

GenerateObjFunc(nFramesZ,FOVSizeX,FOVSizeY,stepSizeZ,outputPath,outputFileName);