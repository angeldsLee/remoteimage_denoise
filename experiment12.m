%  中值法去噪
f=imread('D:/pictures/design/sense/2.jpg');
f=rgb2gray(f);
f2=f(201:456,301:556);
figure;
subplot(221),imshow(f2),title('original image');
b=f2;
b1=double(b);
g=imnoise2('gaussian',size(b,1),size(b,2),0,20);
h=g+b1;
subplot(222),imshow(uint8(h)),title('denoised image');
a=medfilt2(h,[3 3],'symmetric');
subplot(223),imshow(a,[]),title('denoised with 3 * 3');
a1=medfilt2(h,[5 5],'symmetric');
subplot(224),imshow(a1,[]),title('denoised with 5 * 5');