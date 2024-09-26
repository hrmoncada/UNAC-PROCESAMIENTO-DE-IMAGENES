f=imread('Fig1113(a).tif');
figure(1), imshow(f,[])
fd=im2double(f);
h=fspecial('gaussian',25,15);
g=imfilter(fd,h,'replicate');
figure(2), imshow(g,[])
gg=im2bw(g,1.5*graythresh(g));
figure(3), imshow(gg,[])
[BB,LL] = bwboundaries(gg,'noholes');
LLRGB=im2double(label2rgb(LL, @jet, [.5 .5 .5]));
figure(4), imshow(LLRGB,[])
hold on
for k = 1:length(BB)
    boundary = BB{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
esqueleto=bwmorph(gg,'skel',Inf);
figure(5), imshow(esqueleto,[])
esqueleto2=bwmorph(esqueleto,'spur',30);
figure(6), imshow(esqueleto2,[])
esque2=im2double(cat(3,esqueleto2,esqueleto2,esqueleto2));
XX=imadd(LLRGB,esque2);
figure(7), imshow(XX,[])
hold on
for k = 1:length(BB)
    boundary = BB{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end