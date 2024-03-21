clear; close all; clc;

img_file= 'Airflow1.png';
myrgb = imread(img_file);
imrgb = (myrgb);
figure(1)
imshow(imrgb)


rgbref=[0 0 0];
clrdist=50;

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


img_file= 'AirflowOG.jpg';
croprgb = imread(img_file);
myrgb = croprgb;
imrgb = (croprgb);
cropbinary=imcrop(binary,[1 1 size(binary,2) 1100]); 
rgbref=[0 50 100];
clrdist=200;


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

cropbinary2=imcrop(binary,[1 1 size(binary,2) 1100]); 
rgbref=[0 255 255];
clrdist=100;

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

binary = binary + binary2;

[row,col] = find(binary); % find the rows and columns that are = 1
x=[1:length(binary(1,:))]; % define a continuous x vector

[C,ia,ic]=unique(col); % find the unique elements along x (columns)
unqrow=row(ia); % reduce the rows to only unique elements
unqcol=col(ia); % reduce the columns to only unique elements

imshow(airfoilBinary)
se = strel('disk', 4);
airfoilBinary = imdilate(airfoilBinary,se);
flippedOut = xor(airfoilBinary, 1);
binary = binary.*flippedOut;
binary = imgaussfilt(binary, 1);
% binary = bwareaopen(binary, 1);
figure(2)
imshow(binary)

% Morphological operations
se = strel('disk', 2);  % Adjust the size of the structuring element

% binaryMatrixSmoothed = bwareaopen(binary, 1000);  % Adjust the size parameter as needed
% % figure(2)
% imshow(binaryMatrixSmoothed)
% % binary = binaryMatrixSmoothed;

edgeImage = edge(binary, 'log');
figure(003);
imshow(edgeImage), title('Edge-Detected Image');
binaryImage = edgeImage;
% Apply Gaussian smoothing to reduce noise
binaryImage = bwareaopen(binaryImage, 20);
verticalLines = imclose(binaryImage, strel('line', 10, 00));
verticalLines = imclose(verticalLines, strel('line', 2, 90));
% verticalLines = bwareaopen(binaryImage, 200);
verticalLines = imclose(verticalLines, strel('line', 5, 00));
% verticalLines = xor(verticalLines,1);
se = strel('line', 10, 90);
se2 = strel('line', 100, 00);
vert = imopen(verticalLines, se);
hori = imopen(verticalLines, se2);

verticalLines = verticalLines-vert-hori;
verticalLines = bwareaopen(verticalLines, 30);
verticalLines = imclose(verticalLines, strel('line', 5, 00));
se = strel('disk', 2);
verticalLines = imdilate(verticalLines, se);

cleanedImage = verticalLines;
% cleanedImage = verticalLines;
resultImage = cleanedImage;
% resultImage = binaryImage;
% Display the original binary image and the result
% imshow(croprgb);
imshow(resultImage);

boundary = bwtraceboundary(resultImage, [289, 191], 'N');
secboundary = bwtraceboundary(resultImage, [405, 89], 'N');
% secboundary = bwtraceboundary(resultImage, [267, 771], 'N');
% thrboundary = bwtraceboundary(resultImage, [268, 6], 'N');
% fouboundary = bwtraceboundary(resultImage, [395, 2], 'N');
% fifboundary = bwtraceboundary(resultImage, [496, 2], 'N');
% sixboundary = bwtraceboundary(resultImage, [598, 2], 'N');
% sevboundary = bwtraceboundary(resultImage, [712, 2], 'N');
% eigboundary = bwtraceboundary(resultImage, [820, 68], 'N');
% ninboundary = bwtraceboundary(resultImage, [929, 2], 'N');
% tenboundary = bwtraceboundary(resultImage, [949, 1771], 'N');
% eleboundary = bwtraceboundary(resultImage, [1067, 207], 'N');
% tweboundary = bwtraceboundary(resultImage, [1051, 1795], 'N');
% thiboundary = bwtraceboundary(resultImage, [1154, 1786], 'N');
% frtboundary = bwtraceboundary(resultImage, [1239, 176], 'N');
% fftboundary = bwtraceboundary(resultImage, [1348, 90], 'N');

axis equal;
hold on;
boundary1(:,2)= boundary(1:end,2);
boundary1(:,1) = smooth(boundary(1:end,1),0.05,'rloess');
% boundary2(:,2) = flip(boundary(length(boundary)/2:end-200,2));
% boundary2(:,1) = smooth(flip(boundary(length(boundary)/2:end-200,1)),.1,'rloess');

boundary = secboundary;
boundary3(:,2)= boundary(1:length(boundary)/2-199,2);
boundary3(:,1) = smooth(boundary(1:length(boundary)/2-199,1),0.1,'rloess');



plot(smooth(boundary1(:,2),.05), smooth(boundary1(:,1),0.05), 'r', 'LineWidth', 2);
% plot(smooth(boundary2(:,2),.2), smooth(boundary2(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary3(:,2),.05), smooth(boundary3(:,1),0.05), 'r', 'LineWidth', 2);

