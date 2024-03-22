clear; close all; clc;

%% Section 1 without slat
img_file= 'OG Airflow 2.jpg';
myrgb = imread(img_file);
imrgb = (myrgb);
figure(1)
imshow(imrgb)
% 
% 
rgbref=[0 126 167];
clrdist=100;
% 
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
% imshow(airfoilBinary);
verticalLines = imclose(binary, strel('line', 10, 00));
verticalLines = imclose(verticalLines, strel('line', 10, 90));

figure()
imshow(verticalLines);
resultImage = verticalLines;
boundary = bwtraceboundary(resultImage, [1959, 2025], 'S');
secboundary = bwtraceboundary(resultImage, [468, 998], 'S');
% 
% 
axis equal;
hold on;
boundary1(:,2)= boundary(1:2300,2);
boundary1(:,1) = smooth(boundary(1:2300,1),0.1,'rloess');

boundary = secboundary;
boundary2(:,2)= boundary(1:2300,2);
boundary2(:,1) = smooth(boundary(1:2300,1),0.1,'rloess');

img_file= 'OG Airflow 2.jpg';
myrgb = imread(img_file);
imrgb = (myrgb);
imshow(imrgb)

plot(smooth(boundary1(:,2),.2), smooth(boundary1(:,1),0.2), 'r', 'LineWidth', 2);
plot(smooth(boundary2(:,2),.2), smooth(boundary2(:,1),0.2), 'r', 'LineWidth', 2);

%Number of points in each streamline
streamline1 = boundary1;
streamline2 = boundary2;
num_points1 = size(streamline1, 1);
num_points2 = size(streamline2, 1);

% Initialize array to store offsets
offsets = zeros(num_points1, 1);

% Loop through points on the first streamline
for i = 1:num_points1
    % Current point on the first streamline
    point1 = streamline1(i, :);

    % Calculate distances to all points on the second streamline
    distances = sqrt(sum((streamline2 - point1).^2, 2));

    % Find the closest point on the second streamline
    [~, closest_index] = min(distances);

    % Calculate the offset (perpendicular distance) between the two points
    offset = norm(point1 - streamline2(closest_index, :));

    % Store the offset
    offsets(i) = offset;
end
% 
figure()
% Plot offsets along the length of the first streamline
plot(1:num_points1, smooth(flip(offsets),0.2));
xlabel('Distance along Streamline 1');
ylabel('Offset');
% title('Offsets between Streamline 1 and Streamline 2');

% boundary1 = smooth(boundary1(:,2),.2);
% boundary2 = smooth(boundary2(:,2),.2);
% 
% difference = boundary1-boundary2;

%% Section 2 with the leading edge slat
% img_file= '20240315_101320.jpg';
% myrgb = imread(img_file);
% imrgb = (myrgb);
% figure(1)
% imshow(imrgb)
% 
% 
% rgbref=[0 100 100];
% clrdist=85;
% 
% tempvec=zeros(1,3); % temporary holding vector 
% binary=zeros(size(imrgb,1),size(imrgb,2)); % blank binary matrix
% 
% for i = 1:size(imrgb,1) % loop through all elements of cropped image
%     for j = 1:size(imrgb,2)
%         tempvec(1)=imrgb(i,j,1);
%         tempvec(2)=imrgb(i,j,2);
%         tempvec(3)=imrgb(i,j,3);
%         if norm(tempvec-rgbref) < clrdist 
%             % check if the color is within color distance
%             binary(i,j)=1; % if so, set to 1
%         end
%     end
% end
% airfoilBinary = binary;
% 
% % figure()
% % imshow(airfoilBinary);
% verticalLines = imclose(binary, strel('line', 10, 00));
% verticalLines = imclose(verticalLines, strel('line', 8, 90));
% 
% figure()
% 
% imshow(verticalLines);
% resultImage = verticalLines;
% boundary = bwtraceboundary(resultImage, [2222, 2260], 'S');
% secboundary = bwtraceboundary(resultImage, [573, 781], 'N');
% 
% 
% axis equal;
% hold on;
% boundary1(:,2)= boundary(1:2500,2);
% boundary1(:,1) = smooth(boundary(1:2500,1),0.1,'rloess');
% 
% boundary = secboundary;
% boundary2(:,2)= smooth(boundary(1:5000,2),0.3,'rloess');
% boundary2(:,1) = smooth(boundary(1:5000,1),0.3,'rloess');
% 
% img_file= '20240315_101320.jpg';
% myrgb = imread(img_file);
% imrgb = (myrgb);
% imshow(imrgb)
% 
% plot(smooth(boundary1(:,2),.2), smooth(boundary1(:,1),0.2), 'r', 'LineWidth', 2);
% plot(smooth(boundary2(1:end-1000,2),.2), smooth(boundary2(1:end-1000,1),0.2), 'r', 'LineWidth', 2);
% 
% 
% % Number of points in each streamline
% streamline1 = boundary1(200:end,:);
% streamline2 = boundary2(1:end-1000,:);
% num_points1 = size(streamline1, 1);
% num_points2 = size(streamline2, 1);
% 
% % Initialize array to store offsets
% offsets = zeros(num_points1, 1);
% 
% % Loop through points on the first streamline
% for i = 1:num_points1
%     % Current point on the first streamline
%     point1 = streamline1(i, :);
% 
%     % Calculate distances to all points on the second streamline
%     distances = sqrt(sum((streamline2 - point1).^2, 2));
% 
%     % Find the closest point on the second streamline
%     [~, closest_index] = min(distances);
% 
%     % Calculate the offset (perpendicular distance) between the two points
%     offset = norm(point1 - streamline2(closest_index, :));
% 
%     % Store the offset
%     offsets(i) = offset;
% end
% 
% figure()
% % Plot offsets along the length of the first streamline
% plot(1:num_points1, smooth(flip(offsets(1:end)),.2));
% xlabel('Distance along Streamline 1');
% ylabel('Offset');
% % title('Offsets between Streamline 1 and Streamline 2');
