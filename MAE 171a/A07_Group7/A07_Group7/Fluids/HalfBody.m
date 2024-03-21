clear; close all; clc;

img_file= 'OG Half Body 6_line.jpg';
myrgb = imread(img_file);
imrgb = (myrgb);
figure()
imshow(imrgb)


rgbref=[0 100 100];
clrdist=100;

tempvec=zeros(1,3); % temporary holding vector 
binary=zeros(size(imrgb,1),size(imrgb,2)); % blank binary matrix

for i = 1:size(imrgb,1) % loop through all elements of cropped image
    for j = 1:size(imrgb,2)
        tempvec(1)=imrgb(i,j,1);
        tempvec(2)=imrgb(i,j,2);
        tempvec(3)=imrgb(i,j,3);
        if norm(tempvec-rgbref) < clrdist 
            % check if the color is within color distance
            binary(i,j)=1; % if so, set to 1
        end
    end
end
airfoilBinary = binary;
% figure()
% imshow(binary),title('binary 1');

img_file= 'ColorBoosted_Half_Body_6_line.jpg';
croprgb = imread(img_file);
myrgb = croprgb;
imrgb = (croprgb);
cropbinary=imcrop(binary,[1 1 size(binary,2) 1100]); 
rgbref=[0 0 0];
clrdist=60;


tempvec=zeros(1,3); % temporary holding vector 
binary=zeros(size(myrgb,1),size(myrgb,2)); % blank binary matrix

for i = 1:size(myrgb,1) % loop through all elements of cropped image
    for j = 1:size(croprgb,2)
        tempvec(1)=croprgb(i,j,1);
        tempvec(2)=croprgb(i,j,2);
        tempvec(3)=croprgb(i,j,3);
        if norm(tempvec-rgbref) < clrdist 
            % check if the color is within color distance
            binary(i,j)=1; % if so, set to 1
        end
    end
end

img_file= 'OG Half Body 6.jpg';
croprgb = imread(img_file);
myrgb = croprgb;
imrgb = (croprgb);
cropbinary2=imcrop(imrgb,[1 1 size(binary,2) 1100]); 
rgbref=[0 0 0];
clrdist=80;

tempvec=zeros(1,3); % temporary holding vector 
binary2 = zeros(size(imrgb,1),size(imrgb,2));
for i = 1:size(myrgb,1) % loop through all elements of cropped image
    for j = 1:size(croprgb,2)
        tempvec(1)=croprgb(i,j,1);
        tempvec(2)=croprgb(i,j,2);
        tempvec(3)=croprgb(i,j,3);
        if norm(tempvec-rgbref) < clrdist 
            % check if the color is within color distance
            binary2(i,j)=1; % if so, set to 1
        end
    end
end
% figure()

binarycomb = binary2+airfoilBinary;
% imshow(binary),title('Image 2');
% figure()
% binary = binary
% imshow(binary),title('Binary');

% [row,col] = find(binary); % find the rows and columns that are = 1
% x=[1:length(binary(1,:))]; % define a continuous x vector
% 
% [C,ia,ic]=unique(col); % find the unique elements along x (columns)
% unqrow=row(ia); % reduce the rows to only unique elements
% unqcol=col(ia); % reduce the columns to only unique elements
 
hold off
% figure()
% imshow(airfoilBinary)
se = strel('disk', 3);
binary = imdilate(binary,se);
flippedOut = xor(binary,1);
binary = binarycomb.*flippedOut;
% binary = imgaussfilt(binary, 1);
% binary = bwareaopen(binary, 1);
binary = imclose(binary, strel('line', 20, 00));
% binary = imclose(binary, strel('line', 5, 90));
figure()
imshow(binary);


resultImage = binary;
boundary = bwtraceboundary(resultImage, [73, 1], 'N');
secboundary = bwtraceboundary(resultImage, [218, 1], 'N');
thiboundary = bwtraceboundary(resultImage, [238, 1], 'N');
fouboundary = bwtraceboundary(resultImage, [307, 2], 'N');
fivboundary = bwtraceboundary(resultImage, [457, 1], 'N');
sixboundary = bwtraceboundary(resultImage, [577, 1], 'N');
sevboundary = bwtraceboundary(resultImage, [673, 1], 'N');
eigboundary = bwtraceboundary(resultImage, [812, 1], 'N');
ninboundary = bwtraceboundary(resultImage, [930, 1], 'N');
tenboundary = bwtraceboundary(resultImage, [1046, 1], 'N');
eleboundary = bwtraceboundary(resultImage, [1160, 1], 'N');
tweboundary = bwtraceboundary(resultImage, [1282, 1], 'N');
thiboundary = bwtraceboundary(resultImage, [1397, 1], 'N');
frtboundary = bwtraceboundary(resultImage, [1513, 1], 'N');

axis equal;
hold on;
boundary1(:,2)= boundary(1:length(boundary)/2-60,2);
boundary1(:,1) = smooth(boundary(1:length(boundary)/2-60,1),0.1,'rloess');
boundary2(:,2) = flip(boundary(length(boundary)/2-60:end-150,2));
boundary2(:,1) = smooth(flip(boundary(length(boundary)/2-60:end-150,1)),.1,'rloess');

boundary = secboundary;
boundary3(:,2)= boundary(1:length(boundary)/2+200,2);
boundary3(:,1) = smooth(boundary(1:length(boundary)/2+200,1),0.1,'rloess');

boundary = thiboundary;
boundary4(:,2) = boundary(length(boundary)/2+300:end,2);
boundary4(:,1) = smooth(boundary(length(boundary)/2+300:end,1),.1,'rloess');

boundary = fouboundary;
boundary5(:,2) = flip(boundary(length(boundary)/2+250:end,2));
boundary5(:,1) = smooth(flip(boundary(length(boundary)/2+250:end,1)),.1,'rloess');
boundary6(:,2) = boundary(1:length(boundary)/2,2);
boundary6(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = fivboundary;
boundary7(:,2) = flip(boundary(length(boundary)/2:end,2));
boundary7(:,1) = smooth(flip(boundary(length(boundary)/2:end,1)),.1,'rloess');
boundary8(:,2) = boundary(1:length(boundary)/2,2);
boundary8(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = sixboundary;
boundary9(:,2) = flip(boundary(length(boundary)/2+410:end,2));
boundary9(:,1) = smooth(flip(boundary(length(boundary)/2+410:end,1)),.1,'rloess');
boundary10(:,2) = boundary(1:length(boundary)/2+410,2);
boundary10(:,1) = smooth(boundary(1:length(boundary)/2+410,1),.1,'rloess');

boundary = sevboundary;
boundary11(:,2) = flip(boundary(length(boundary)/2-200:end-250,2));
boundary11(:,1) = smooth(flip(boundary(length(boundary)/2-200:end-250,1)),.1,'rloess');
boundary12(:,2) = boundary(1:length(boundary)/2-350,2);
boundary12(:,1) = smooth(boundary(1:length(boundary)/2-350,1),.1,'rloess');

boundary = eigboundary;
boundary13(:,2) = flip(boundary(length(boundary)/2+600:end,2));
boundary13(:,1) = smooth(flip(boundary(length(boundary)/2+600:end,1)),.1,'rloess');
boundary14(:,2) = boundary(1:1400,2);
boundary14(:,1) = smooth(boundary(1:1400,1),.1,'rloess');

boundary = ninboundary;
boundary15(:,2) = flip(boundary(length(boundary)/2+600:end,2));
boundary15(:,1) = smooth(flip(boundary(length(boundary)/2+600:end,1)),.1,'rloess');
boundary16(:,2) = boundary(1:length(boundary)/2,2);
boundary16(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = tenboundary;
boundary17(:,2) = flip(boundary(length(boundary)/2:end,2));
boundary17(:,1) = smooth(flip(boundary(length(boundary)/2:end,1)),.1,'rloess');
boundary18(:,2) = boundary(1:length(boundary)/2,2);
boundary18(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = eleboundary;
boundary19(:,2) = flip(boundary(length(boundary)/2:end,2));
boundary19(:,1) = smooth(flip(boundary(length(boundary)/2:end,1)),.1,'rloess');
boundary20(:,2) = boundary(1:length(boundary)/2,2);
boundary20(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = tweboundary;
boundary21(:,2) = flip(boundary(length(boundary)/2:end,2));
boundary21(:,1) = smooth(flip(boundary(length(boundary)/2:end,1)),.1,'rloess');
boundary22(:,2) = boundary(1:length(boundary)/2,2);
boundary22(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = thiboundary;
boundary23(:,2) = flip(boundary(length(boundary)/2:end,2));
boundary23(:,1) = smooth(flip(boundary(length(boundary)/2:end,1)),.1,'rloess');
boundary24(:,2) = boundary(1:length(boundary)/2,2);
boundary24(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');

boundary = frtboundary;
boundary25(:,2) = flip(boundary(length(boundary)/2:end,2));
boundary25(:,1) = smooth(flip(boundary(length(boundary)/2:end,1)),.1,'rloess');
boundary26(:,2) = boundary(1:length(boundary)/2,2);
boundary26(:,1) = smooth(boundary(1:length(boundary)/2,1),.1,'rloess');


img_file= 'OG Half Body 6.jpg';
myrgb = imread(img_file);
imrgb = (myrgb);
imshow(imrgb)

plot(smooth(boundary1(:,2),.2), smooth(boundary1(:,1),0.2), 'r', 'LineWidth', 2);
plot(smooth(boundary2(:,2),.2), smooth(boundary2(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary3(:,2),.9), smooth(boundary3(:,1),0.2), 'r', 'LineWidth', 2);
plot(smooth(boundary4(:,2),.8), smooth(boundary4(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary5(:,2),.2), smooth(boundary5(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary6(:,2),.2), smooth(boundary6(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary7(:,2),.2), smooth(boundary7(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary8(:,2),.2), smooth(boundary8(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary9(:,2),.2), smooth(boundary9(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary10(:,2),.9), smooth(boundary10(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary11(:,2),.2), smooth(boundary11(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary12(:,2),.9), smooth(boundary12(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary13(:,2),.1), smooth(boundary13(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary14(:,2),.5), smooth(boundary14(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary15(:,2),.1), smooth(boundary15(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary16(:,2),.5), smooth(boundary16(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary17(:,2),.1), smooth(boundary17(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary18(:,2),.5), smooth(boundary18(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary19(:,2),.1), smooth(boundary19(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary20(:,2),.5), smooth(boundary20(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary21(:,2),.1), smooth(boundary21(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary22(:,2),.5), smooth(boundary22(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary23(:,2),.1), smooth(boundary23(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary24(:,2),.5), smooth(boundary24(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary25(:,2),.1), smooth(boundary25(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary26(:,2),.5), smooth(boundary26(:,1),.1), 'r', 'LineWidth', 2);

