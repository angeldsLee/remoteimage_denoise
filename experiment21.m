% 软、硬阈值法去噪

function experiment21(f)
f=double(f);
g=imnoise2('gaussian',size(f,1),size(f,2),0,15);
f1=f+g;
[c,s]=wavedec2(f1,3,'coif4');   %小波分解
[cH3,cV3,cD3]=detcoef2('all',c,s,3);c3=[cH3,cV3,cD3];
[cH2,cV2,cD2]=detcoef2('all',c,s,2);c2=[cH2,cV2,cD2];
[cH1,cV1,cD1]=detcoef2('all',c,s,1);c1=[cH1,cV1,cD1];
delta=median(abs(cD1(:)))/0.6745; % 标准差估计
thr1c=delta*thselect(c,'minimaxi');     
 n=[1 2 3 ];p=[thr1c thr1c thr1c ];

origif=cacupsnr(f1,f)
figure,subplot(221),imshow(uint8(f));  title('original image');axis square;
subplot(222),imshow(uint8(f1));  title('nosied image');axis square;

dnc1=wthresfunc(c,s,'hard',thr1c); 
dnf1=waverec2(dnc1,s,'coif4');
subplot(223),imshow(dnf1,[]);  title('hard denoised');axis square;
VSf1=cacupsnr(dnf1,f)

dnc2=wthresfunc(c,s,'soft',thr1c);
dnf2=waverec2(dnc2,s,'coif4');
subplot(224),imshow(dnf2,[]);  title('soft denoised');axis square;
VSf2=cacupsnr(dnf2,f)


