clear all;
close all;
clc;

StartingFrame = 1;
EndingFrame = 448;

Xcentroid = [];
Ycentroid = [];

for k = StartingFrame : EndingFrame-1
k
%pos1 = imread('ant/img008.jpg');
%pos2 = imread('ant/img009.jpg');

pos1 = imread(['ant/img',sprintf('%2.3d',k),'.jpg']);
pos2 = imread(['ant/img',sprintf('%2.3d',k+1),'.jpg']);

diff1 = abs(pos1-pos2);
hsv = rgb2hsv(diff1);
I = hsv(:,:,3);
Ithresh = I > 0.048;

%imshow(Ithresh);

SE = strel('disk',1,0);
BW = imopen(Ithresh,SE);

[labels,number] = bwlabel(BW,8);

if number > 0

Istats = regionprops(labels,'basic','Centroid');

[values,index] = sort([Istats.Area],'descend');

[maxVal, maxIndex] = max([Istats.Area]);

Xcentroid = [Xcentroid Istats(maxIndex).Centroid(1)];
Ycentroid = [Ycentroid Istats(maxIndex).Centroid(2)];
     
end
end

close all;
pos1 = imread('ant/img008.jpg');
imshow(pos1);
hold on;
plot(Xcentroid,Ycentroid);




