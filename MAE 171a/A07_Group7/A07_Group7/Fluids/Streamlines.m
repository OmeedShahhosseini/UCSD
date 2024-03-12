clc;
clear all;
close all;

img_filename = 'OG Circle 1.jpg'; % image filename in same directory

myrgb = imread(img_filename); % open image

% myrgb = fliplr(flipud(myrgb)); % reorient image

 croprgb=imcrop(myrgb,[250 250 1800 1400]); % crop2348x1788

 rgbref=[35 35 150]; % reference color
 clrdist=150; % color distance

 [centers,radii] = imfindcircles(croprgb,[210
240],'Sensitivity',0.99,'ObjectPolarity','dark');

 tempvec=zeros(1,3); % temporary holding vector 
 binary=zeros(size(croprgb,1),size(croprgb,2)); % blank binary matrix

 for i = 1:size(croprgb,1) % loop through all elements of cropped image
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
figure(001)
% N = 1001;
R = radii;
M = zeros(1801, 1401);
M(ceil(centers(1,1)),ceil(centers(1,2))) = 1;
out = bwdist(M) <= R*1;
imagesc(out')
flippedOut = xor(out', 1);


figure(002)
imshow(croprgb); 
hold on
viscircles(centers,radii);
plot(centers(1),centers(2),'xr','MarkerSize',20,'LineWidth',3);
% plot(x,s2,'or')
% plot(x,s_smooth,'.b')

cropbinary=imcrop(binary,[1 1 size(binary,2) 1401]); 
hold off
cropbinary = cropbinary.*flippedOut;
 figure(003)
 imshow(cropbinary)

edgeImage = edge(cropbinary, 'log');

% Find the starting point for tracing (first white pixel in the image)


% Trace the boundary
% boundary = bwtraceboundary(cropbinary, [startRow, startCol], 'N');

figure(004);
% Display the original binary image and the edge-detected image
% subplot(1, 2, 1), imshow(cropbinary), title('Binary Image');
imshow(edgeImage), title('Edge-Detected Image');
% Plot streamlines along the traced boundary
% hold on;
% plot(boundary(:,2), boundary(:,1), 'r', 'LineWidth', 2);
% hold off;

binaryImage = edgeImage;

% Detect vertical lines
verticalLines = imclose(binaryImage, strel('line', 30, 00));
verticalLines = imclose(verticalLines, strel('line', 2, 90));

% Remove small vertical components
cleanedImage = bwareaopen(verticalLines, 1000);

% Set the values of the detected vertical lines to zero
resultImage = cleanedImage;
% resultImage = binaryImage;
% Display the original binary image and the result
imshow(imcrop(croprgb,[1 1 size(binary,2) 1401]));
% imshow(imcrop(resultImage,[1 1 size(binary,2) 1401]));
% Trace the boundary
[startRow, startCol] = find(resultImage, 1);
boundary = bwtraceboundary(resultImage, [67, 2], 'N');
secboundary = bwtraceboundary(resultImage, [180, 2], 'N');
thrboundary = bwtraceboundary(resultImage, [268, 6], 'N');
fouboundary = bwtraceboundary(resultImage, [395, 2], 'N');
fifboundary = bwtraceboundary(resultImage, [496, 2], 'N');
sixboundary = bwtraceboundary(resultImage, [598, 2], 'N');
sevboundary = bwtraceboundary(resultImage, [712, 2], 'N');
eigboundary = bwtraceboundary(resultImage, [820, 68], 'N');
ninboundary = bwtraceboundary(resultImage, [929, 2], 'N');
tenboundary = bwtraceboundary(resultImage, [949, 1771], 'N');
eleboundary = bwtraceboundary(resultImage, [1067, 207], 'N');
tweboundary = bwtraceboundary(resultImage, [1051, 1795], 'N');
thiboundary = bwtraceboundary(resultImage, [1154, 1786], 'N');
frtboundary = bwtraceboundary(resultImage, [1239, 176], 'N');
fftboundary = bwtraceboundary(resultImage, [1348, 90], 'N');
% boundary8 = bwtraceboundary(resultImage, [823, 81], 'N');
% figure()
axis equal;
hold on;
boundary1(:,2)= boundary(1:length(boundary)/2-199,2);
boundary1(:,1) = smooth(boundary(1:length(boundary)/2-199,1),0.1,'rloess');
boundary2(:,2) = flip(boundary(length(boundary)/2:end-200,2));
boundary2(:,1) = smooth(flip(boundary(length(boundary)/2:end-200,1)),.1,'rloess');

boundary = secboundary;
boundary3(:,2)= boundary(1:length(boundary)/2-199,2);
boundary3(:,1) = smooth(boundary(1:length(boundary)/2-199,1),0.1,'rloess');
boundary4(:,2) = flip(boundary(length(boundary)/2:end-200,2));
boundary4(:,1) = smooth(flip(boundary(length(boundary)/2:end-200,1)),.1,'rloess');

boundary = thrboundary;
boundary5(:,2)= boundary(1:length(boundary)/2-199,2);
boundary5(:,1) = smooth(boundary(1:length(boundary)/2-199,1),0.1,'rloess');
boundary6(:,2) = flip(boundary(length(boundary)/2:end-200,2));
boundary6(:,1) = smooth(flip(boundary(length(boundary)/2:end-200,1)),.1,'rloess');

boundary = fouboundary;
boundary7(:,2)= boundary(1:1900,2);
boundary7(:,1) = smooth(boundary(1:1900,1),0.05,'rloess');

boundary = fifboundary;
boundary8(:,2) = flip(boundary(2001:3800,2));
boundary8(:,1) = smooth(flip(boundary(2001:3800,1)),.2,'rloess');
boundary9(:,2)= boundary(1:1900,2);
boundary9(:,1) = smooth(boundary(1:1900,1),0.2,'rloess');

boundary = sixboundary;
boundary10(:,2) = flip(boundary(1900:3500,2));
boundary10(:,1) = smooth(flip(boundary(1900:3500,1)),0.2,'rloess');
boundary11(:,2)= boundary(1:1800,2);
boundary11(:,1) = smooth(boundary(1:1800,1),0.2,'rloess');
% boundary10(:,2)= boundary(1:3800,2);
% boundary10(:,1) = boundary(1:3800,1);

boundary = sevboundary;
boundary12(:,2)= flip(boundary(1000:1600,2));
boundary12(:,1) = flip(boundary(1000:1600,1));
boundary13(:,2)= boundary(1:500,2);
boundary13(:,1) = boundary(1:500,1);

boundary = eigboundary;
boundary14(:,2) = flip(boundary(2200:4100,2));
boundary14(:,1) = smooth(flip(boundary(2200:4100,1)),0.2,'rloess');
boundary15(:,2)= boundary(1:2100,2);
boundary15(:,1) = smooth(boundary(1:2100,1),0.2,'rloess');

boundary = ninboundary;
boundary16(:,2) = flip(boundary(2300:4300,2));
boundary16(:,1) = smooth(flip(boundary(2300:4300,1)),0.2,'rloess');
boundary17(:,2)= boundary(1:2200,2);
boundary17(:,1) = smooth(boundary(1:2200,1),0.2,'rloess');

boundary = tenboundary;
% boundary18(:,2) = flip(boundary(2300:4300,2));
% boundary18(:,1) = smooth(flip(boundary(2300:4300,1)),0.2,'rloess');
boundary18(:,2)= flip(boundary(1:1800,2));
boundary18(:,1) = smooth(flip(boundary(1:1800,1)),0.2,'rloess');

boundary = eleboundary;
% boundary18(:,2) = flip(boundary(2300:4300,2));
% boundary18(:,1) = smooth(flip(boundary(2300:4300,1)),0.2,'rloess');
boundary19(:,2)= boundary(1:2000,2);
boundary19(:,1) = smooth(boundary(1:2000,1),0.2,'rloess');

boundary = tweboundary;
boundary20(:,2)= boundary(1:1900,2);
boundary20(:,1) = smooth(boundary(1:1900,1),0.2,'rloess');
boundary21(:,2) = flip(boundary(2000:3800,2));
boundary21(:,1) = smooth(flip(boundary(2000:3800,1)),0.2,'rloess');

boundary = thiboundary;
boundary22(:,2)= boundary(1:1700,2);
boundary22(:,1) = smooth(boundary(1:1700,1),0.2,'rloess');
% boundary23(:,2) = flip(boundary(2000:3800,2));
% boundary23(:,1) = smooth(flip(boundary(2000:3800,1)),0.2,'rloess');

boundary = frtboundary;
boundary24(:,2)= flip(boundary(1:1800,2));
boundary24(:,1) = smooth(flip(boundary(1:1800,1)),0.2,'rloess');
boundary25(:,2) = flip(boundary(2200:3800,2));
boundary25(:,1) = smooth(flip(boundary(2200:3800,1)),0.2,'rloess');

boundary = fftboundary;
boundary26(:,2)= boundary(1:1800,2);
boundary26(:,1) = smooth(boundary(1:1800,1),0.2,'rloess');

%% Average of boundaries
avg1 = smooth((boundary2(:,1) + boundary3(1:length(boundary2),1))./2, 0.05);
avg2 = smooth((boundary4(1:length(boundary5),1) + boundary5(:,1))./2, 0.1);
avg3 = smooth((boundary6(1:length(boundary7),1) + boundary7(:,1))./2, 0.1);
avg4 = smooth((boundary8(:,1) + boundary9(1:length(boundary8),1))./2, 0.1);
avg5 = smooth((boundary10(:,1) + boundary11(1:length(boundary10),1))./2, 0.1);
avg6 = (boundary12(1:400,1) + boundary13(1:400,1))./2;
avg7 = (boundary14(1:(1600-116),1) + boundary15(117:1600,1))./2;
avg8 = (boundary16(:,1) + boundary17(1:length(boundary16),1))./2;
avg9 = (boundary18(:,1) + boundary19(1:length(boundary18),1))./2;
avg10 = (boundary20(1:length(boundary21),1) + boundary21(:,1))./2;
avg11 = (boundary22(:,1) + boundary24(1:length(boundary22),1))./2;
avg12 = (boundary25(:,1) + boundary26(1:length(boundary25),1))./2;


plot(smooth(boundary1(:,2),.2), smooth(boundary1(:,1),0.2), 'r', 'LineWidth', 2);
plot(smooth(boundary2(:,2),.2), smooth(boundary2(:,1),.1), 'r', 'LineWidth', 2);

%STREAMLINE 1
plot(boundary1(:,2), avg1,'b', 'LineWidth', 4);

plot(smooth(boundary3(:,2),.2), smooth(boundary3(:,1),.2), 'r', 'LineWidth', 2);
plot(smooth(boundary4(:,2),.2), smooth(boundary4(:,1),.2), 'r', 'LineWidth', 2);

%STREAMLINE 2
plot(boundary5(:,2), avg2,'b', 'LineWidth', 4);

plot(smooth(boundary5(:,2),.2), smooth(boundary5(:,1),.2), 'r', 'LineWidth', 2);
plot(smooth(boundary6(:,2),.2), smooth(boundary6(:,1),.2), 'r', 'LineWidth', 2);

%STREAMLINE 3
plot(boundary7(:,2), avg3,'b', 'LineWidth', 4);

plot(smooth(boundary7(:,2),.1), smooth(boundary7(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary8(:,2),.2), smooth(boundary8(:,1),.05), 'r', 'LineWidth', 2);

%STREAMLINE 4
plot(boundary8(:,2), avg4,'b', 'LineWidth', 4);

plot(smooth(boundary9(:,2),.2), smooth(boundary9(:,1),.05), 'r', 'LineWidth', 2);
plot(smooth(boundary10(:,2),.2), smooth(boundary10(:,1),.2), 'r', 'LineWidth', 2);

%STREAMLINE 5
plot(boundary10(:,2), avg5,'b', 'LineWidth', 4);

plot(smooth(boundary11(:,2),.2), smooth(boundary11(:,1),.08), 'r', 'LineWidth', 2);
plot(smooth(boundary12(:,2),.2), smooth(boundary12(:,1),.08), 'r', 'LineWidth', 2);

%STREAMLINE 6
plot(boundary13(1:400,2), avg6,'b', 'LineWidth', 4);

plot(smooth(boundary13(:,2),.2), smooth(boundary13(:,1),.08), 'r', 'LineWidth', 2);
plot(smooth(boundary14(:,2),.2), smooth(boundary14(:,1),.08), 'r', 'LineWidth', 2);

%STREAMLINE 7
plot(smooth(boundary14(1:(1600-116),2),.2), smooth(avg7,.08),'b', 'LineWidth', 4);

plot(smooth(boundary15(:,2),.2), smooth(boundary15(:,1),.08), 'r', 'LineWidth', 2);
plot(smooth(boundary16(:,2),.2), smooth(boundary16(:,1),.1), 'r', 'LineWidth', 2);

%STREAMLINE 8
plot(smooth(boundary16(:,2),.2), smooth(avg8,.08),'b', 'LineWidth', 4);

plot(smooth(boundary17(:,2),.2), smooth(boundary17(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary18(:,2),.2), smooth(boundary18(:,1),.1), 'r', 'LineWidth', 2);

%STREAMLINE 9
plot(smooth(boundary18(:,2),.2), smooth(avg9,.08),'b', 'LineWidth', 4);

plot(smooth(boundary19(:,2),.2), smooth(boundary19(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary20(:,2),.2), smooth(boundary20(:,1),.1), 'r', 'LineWidth', 2);

%STREAMLINE 10
plot(smooth(boundary21(:,2),.2), smooth(avg10,.08),'b', 'LineWidth', 4);

plot(smooth(boundary21(:,2),.2), smooth(boundary21(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary22(:,2),.2), smooth(boundary22(:,1),.1), 'r', 'LineWidth', 2);

%STREAMLINE 11
plot(smooth(boundary22(:,2),.2), smooth(avg11,.08),'b', 'LineWidth', 4);

% plot(smooth(boundary23(:,2),.2), smooth(boundary23(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary24(:,2),.2), smooth(boundary24(:,1),.1), 'r', 'LineWidth', 2);
plot(smooth(boundary25(:,2),.2), smooth(boundary25(:,1),.1), 'r', 'LineWidth', 2);

%STREAMLINE 12
plot(smooth(boundary25(:,2),.2), smooth(avg12,.08),'b', 'LineWidth', 4);

plot(smooth(boundary26(:,2),.2), smooth(boundary26(:,1),.1), 'r', 'LineWidth', 2);

% plot(boundary7(:,2), boundary7(:,1), 'r', 'LineWidth', 2);
% plot(boundary22(:,2), boundary22(:,1), 'r', 'LineWidth', 2);
% plot(boundary23(:,2), boundary23(:,1), 'r', 'LineWidth', 2);




hold off;