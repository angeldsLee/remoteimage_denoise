%  均值法去噪
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
w=ones(5);gd=imfilter(h,w);
subplot(223),imshow(gd,[]),title('denoised with 5 * 5');
w1=ones(7);gd1=imfilter(h,w1);
subplot(224),imshow(gd1,[]),title('denosied with 7 * 7');
