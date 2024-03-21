clear; close all; clc;

img_file= 'OG Airflow 2.jpg';
myrgb = imread(img_file);
imrgb = (myrgb);
figure(1)
imshow(imrgb)


rgbref=[0 126 167];
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

figure()
imshow(airfoilBinary);

%% Section 2 with the leading edge slat

img_file= '20240315_101320.jpg';
myrgb = imread(img_file);
imrgb = (myrgb);
figure(1)
imshow(imrgb)


rgbref=[0 126 167];
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

figure()
imshow(airfoilBinary);