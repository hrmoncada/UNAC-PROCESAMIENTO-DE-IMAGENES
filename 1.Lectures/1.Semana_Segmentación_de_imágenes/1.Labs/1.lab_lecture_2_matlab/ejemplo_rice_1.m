f=imread('rice.png');
figure(1), imshow(f,[]) 
% Notar el background no uniforme 
L=graythresh(f);
BW1=im2bw(f,L);
figure(2), imshow(BW1,[]) 
% Notar que en la parte inferior los granos
% no son correctamente segmentados
se=strel('disk',10);
fo=imopen(f,se);
figure(3), imshow(fo,[])
% La figura es una aproximacion 
% del background
f2=imsubtract(f,fo);
figure(4), imshow(f2,[])
% Notar que se uniformizo 
% el background
L2=graythresh(f2);
BW2=im2bw(f2,L2);
figure(5), imshow(BW2,[])
% Notar que ahora la segmentacion 
% de los granos de la parte inferior
% es correcta
f3=imtophat(f,se);
figure(6), imshow(f3,[])
% imtophat realiza la apertura y 
% substraccion de la imagen 
% original en un solo paso
L3=graythresh(f3);
BW3=im2bw(f3,L3);
figure(7), imshow(BW3,[])
[BB,LL] = bwboundaries(BW3,'noholes');
figure(8), imshow(label2rgb(LL, @jet, [.5 .5 .5]))
hold on
for k = 1:length(BB)
    boundary = BB{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
