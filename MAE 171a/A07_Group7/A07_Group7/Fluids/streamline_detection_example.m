% Need image processing toolbox
clc;
clear all;
close all;

img_filename = 'OG Circle 1.jpg'; % image filename in same directory

myrgb = imread(img_filename); % open image

myrgb = fliplr(flipud(myrgb)); % reorient image

 croprgb=imcrop(myrgb,[1200 900 2300 1300]); % crop
% croprgb = img_filename;

[centers,radii] = imfindcircles(croprgb,[300 500],'Sensitivity',0.99,...
    'ObjectPolarity','dark'); % find disc center and radii


rgbref=[80 140 140]; % reference color
clrdist=50; % color distance

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


cropbinary=imcrop(binary,[1 130 size(binary,2) 350]); 
% crop again around streamline

[row,col] = find(cropbinary); % find the rows and columns that are = 1
x=[1:length(binary(1,:))]; % define a continuous x vector

[C,ia,ic]=unique(col); % find the unique elements along x (columns)
unqrow=row(ia); % reduce the rows to only unique elements
unqcol=col(ia); % reduce the columns to only unique elements

s = spline(unqcol,unqrow,x); % fit a spline
s2 = s+130; % compensate for 2nd crop
s_smooth=smooth(s2,100); % smooth the spline


% plotting
figure(001)
imshow(croprgb); 
hold on
viscircles(centers,radii);
plot(centers(1),centers(2),'xr','MarkerSize',20,'LineWidth',3);
plot(x,s2,'or')
plot(x,s_smooth,'.b')

pause(2)

figure(002)
imshow(cropbinary)
hold on
plot(x,s,'or')

pause(2)

figure(003)
imshow(binary)
hold on
viscircles(centers,radii);
plot(centers(1),centers(2),'xr','MarkerSize',20,'LineWidth',3);
plot(x,s_smooth,'.b')


