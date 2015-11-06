function finaldenoise(f)
% f=rgb2gray(f);
% f1=imnoise(f, 'gaussian');
f = double(f);
g = imnoise2('gaussian',size(f,1),size(f,2),0,25);
f1 = f + g;
% maxval=max(max(f1)); minval=min(min(f1));
% f1=f1./((maxval-minval)/256);
[c,s] = wavedec2(f1,3,'db8');   % 三层分解
%  cA3=appcoef2(c,s)     %  近似系数
% 返回各层分解水平的水平、垂直、对角线方向的细节矩阵
[cH3,cV3,cD3] = detcoef2('all',c,s,3);
c3 = [cH3,cV3,cD3];
[cH2,cV2,cD2] = detcoef2('all',c,s,2);
c2 = [cH2,cV2,cD2];
[cH1,cV1,cD1] = detcoef2('all',c,s,1);
c1 = [cH1,cV1,cD1];
% 通用阈值，Donoho和Johnstone   thr=delta*sqrt(2*log(n));
delta = median(abs(cD1(:)))/0.6745; % 含噪图像噪声方差的鲁邦估计法
thr1c = delta*thselect(c,'minimaxi');% 选择阈值法 ：极小极大法
%thr1c=delta*3.5;   % 置信区间法-3deltra~3delta      
thr1c3 = delta*thselect(c3,'sqtwolog');    
thr1c2 = delta*thselect(c2,'sqtwolog');
thr1c1 = delta*thselect(c1,'sqtwolog');
n = [1 2 3];
p = [thr1c1 thr1c2 thr1c3];
dnc0 = wthcoef2('h',c,s,n,p,'s');  
dnc0 = wthcoef2('v',dnc0,s,n,p,'s');    
dnc0 = wthcoef2('d',dnc0,s,n,p,'s');     
dnf0 = waverec2(dnc0,s,'db8');  

origif=cacupsnr(f1,f)
% figure,subplot(221),imshow(uint8(f)),title('original image');axis square;
% subplot(222),imshow(uint8(f1)),title('nosied image');axis square;
% 
% dnc1=wthresfunc(c,s,'hard',thr1c); 
% dnf1=waverec2(dnc1,s,'db8');
% subplot(223),imshow(dnf1,[]),title('hard denoised');axis square;
% VSf1=cacupsnr(dnf1,f)
% 
% dnc2=wthresfunc(c,s,'soft',thr1c);
% dnf2=waverec2(dnc2,s,'db8');
% subplot(224),imshow(dnf2,[]),title('soft denoised');axis square;
% VSf2=cacupsnr(dnf2,f)
figure;
imshow(uint8(f));
axis square;
figure;
imshow(uint8(f1));
axis square;

 dnc1=wthresfunc(c,s,'hard',thr1c); 
 dnf1=waverec2(dnc1,s,'db8');
 VSf1=cacupsnr(dnf1,f)
 figure,imshow(dnf1,[]);axis square;
 dnc2=wthresfunc(c,s,'soft',thr1c);
 dnf2=waverec2(dnc2,s,'db8');
 VSf2=cacupsnr(dnf2,f)
 figure;
 imshow(dnf2,[]);
 axis square;

% dnc3=wthresfunc(c,s,'upsoft',thr1c);
% dnf3=waverec2(dnc3,s,'db8');
% figure;subplot(221),imshow(uint8(f)),title('original image');axis square;
% subplot(222),imshow(uint8(f1)),title('nosied image');axis square;
% 
% subplot(223),imshow(dnf3,[]),title('upsoft denosied');axis square;
% VSf3=cacupsnr(dnf3,f)
% 
% dnc4=wthresfunc(c,s,'hfsmsoft',thr1c);
% dnf4=waverec2(dnc4,s,'db8');
% subplot(224),imshow(dnf4,[]),title('hfsmsoft denoised');axis square;
% VSf4=cacupsnr(dnf4,f)

% dnc5=wthresfunc(c,s,'qiyisoft',thr1c);
% dnf5=waverec2(dnc5,s,'db8');
% figure,subplot(221),imshow(uint8(f)),title('original image');axis square;
% subplot(222),imshow(uint8(f1)),title('nosied image');axis square;
% 
% subplot(223),imshow(dnf5,[]),title('qiyisoft denoised');axis square;
% VSf5=cacupsnr(dnf5,f)

