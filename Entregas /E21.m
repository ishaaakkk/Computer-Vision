%% E21 - Ishak Felfoul, Ferran Mesas 
image = imread('coins.png');
figure, imshow(image), title('Input')

[centres, radis, metric] = imfindcircles(image, [15,30]);
hold on
viscircles(centres(1:5,:),radis(1:5),'EdgeColor','g')

%% Entrega.

image = imread('rabbit.jpg');
figure, imshow(image), title('Input')
cont = edge(image, 'canny');
figure, imshow(cont), title('Contour')
[files, cols] = find(cont);
[miday, midax] = size(image);
T_hough = zeros(miday,midax);
N_coords = size(files);

for coord=1:N_coords
    rq = 58^2;
    y = files(coord);
    x = cols(coord);
    for a = x-58:x+58
        aux = (x - a)^2;
        if a >= 1 && a <= midax && aux <= rq
            sol1 = round(y - sqrt(rq - aux));
            sol2 = round(y + sqrt(rq - aux));
            if (1 <= sol1 && sol1 <= miday)
                T_hough(a, sol1) = T_hough(a, sol1) + 1;
            end
            if (1 <= sol2 && sol2 <= miday)
                T_hough(a, sol2) = T_hough(a, sol2) + 1;
            end
        end 
    end
end
r = 58;
figure, mesh(T_hough),title('Hough')
[valorMax,i] = max(T_hough(:));
[Cord1,Cord2] = ind2sub(size(T_hough), i);
centre1 = Cord1;
centre2 = Cord2;
figure, imshow(image), title('res')
hold on
viscircles([centre1,centre2],r,'EdgeColor','g'); 




