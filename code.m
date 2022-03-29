%General template convert to edges, only need to do once
[template,map]=imread('templateFinal.jpg');
figure,imshow(template)
w = waitforbuttonpress;
close
I = rgb2gray(template);
I = double(I);
I = I - min(I(:));
I = I./max(I(:));
templateConverted = imresize(I,.5);
figure,imshow(templateConverted)
w = waitforbuttonpress;
close
templateEdges = edge(templateConverted);

%General hand convert, only need to do once
[hand,map]=imread('hand5.jpg'); %Change to hand1-5 for other runs
figure,imshow(hand)
w = waitforbuttonpress;
close
I = rgb2gray(hand);
I = double(I);
I = I - min(I(:));
I = I./max(I(:));
handConverted = imresize(I,.5);

%-------------------------------------------------------------------------
%F1
%Thumb
%Thumb finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopeThumb = (yy(50) - yy(150))/(xx(50) - xx(150));

%Thumb finger top joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeThumb)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VThumbTop = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VThumbTop = [VThumbTop; handConverted(ver(i),hor(i))];
    end
end

%Thumb width
figure,plot(VThumbTop)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VThumbTop(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VThumbTop(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F1ThumbWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%-------------------------------------------------------------------------
%F2 and F3
%Index
%Index finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopeIndex = (yy(50) - yy(150))/(xx(50) - xx(150));

%Index finger top joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeIndex)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VIndexTop = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VIndexTop = [VIndexTop; handConverted(ver(i),hor(i))];
    end
end

%Index finger top width = F2
figure,plot(VIndexTop)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VIndexTop(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VIndexTop(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F2IndexTopWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%Index finger middle joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeIndex)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VIndexMiddle = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VIndexMiddle = [VIndexMiddle; handConverted(ver(i),hor(i))];
    end
end

%Index finger middle width = F3
figure,plot(VIndexMiddle)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VIndexMiddle(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VIndexMiddle(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F3IndexMiddleWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%-------------------------------------------------------------------------
%F4 and F5
%Mid
%Mid finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopeMid = (yy(50) - yy(150))/(xx(50) - xx(150));

%Mid finger top joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeMid)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VMidTop = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VMidTop = [VMidTop; handConverted(ver(i),hor(i))];
    end
end

%Mid finger top width = F4
figure,plot(VMidTop)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VMidTop(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VMidTop(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F4MidTopWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%Mid finger middle joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeMid)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VMidMiddle = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VMidMiddle = [VMidMiddle; handConverted(ver(i),hor(i))];
    end
end

%Mid finger middle width = F5
figure,plot(VMidMiddle)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VMidMiddle(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VMidMiddle(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F5MidMiddleWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%-------------------------------------------------------------------------
%F6 and F7
%Ring
%Ring finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopeRing = (yy(50) - yy(150))/(xx(50) - xx(150));

%Ring finger top joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeRing)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VRingTop = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VRingTop = [VRingTop; handConverted(ver(i),hor(i))];
    end
end

%Ring finger top width = F6
figure,plot(VRingTop)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VRingTop(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VRingTop(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F6RingTopWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%Ring finger middle joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopeRing)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VRingMiddle = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VRingMiddle = [VRingMiddle; handConverted(ver(i),hor(i))];
    end
end

%Ring finger middle width = F7
figure,plot(VRingMiddle)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VRingMiddle(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VRingMiddle(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F7RingMiddleWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%-------------------------------------------------------------------------
%F8
%Pinky
%Pinky finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopePinky = (yy(50) - yy(150))/(xx(50) - xx(150));

%Pinky finger top joint
figure,imshow(handConverted),hold on,plot(xx,yy,'b')
[x,y]=ginput(1);
close
jointDistance = sqrt( (x-xx).^2 + (y-yy).^2 );
[md,idx]=min(jointDistance);
hor = [1:size(handConverted,2)];
ver = (-1/slopePinky)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(xx,yy,'b'),plot(xx(idx),yy(idx),'r*'),plot(hor,ver,'r')
w = waitforbuttonpress;
close
VPinkyTop = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VPinkyTop = [VPinkyTop; handConverted(ver(i),hor(i))];
    end
end

%Pinky finger top width = F8
figure,plot(VPinkyTop)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VPinkyTop(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VPinkyTop(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F8PinkyTopWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%-------------------------------------------------------------------------
%F9
%Index finger height
%Index finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
slopeIndex = (yy(50) - yy(150))/(xx(50) - xx(150));

%Knuckle line for intersept
figure,imshow(templateEdges)
[x2,y2]=ginput(2);
close all
x2 = round(x2); y2 = round(y2);
T2 = templateEdges( min(y2):max(y2), min(x2):max(x2) );
[k2,l2]=find(T2);
kk2 = min(y2)+k2; ll2 = min(x2)+l2;
p2 = polyfit(ll2,kk2,1);
xx2 = [1:size(templateConverted,1)];
yy2 = polyval(p2,xx2);

%Intersection
[xi,yi] = polyxpoly(xx,yy,xx2,yy2);
figure,imshow(templateConverted),hold on,plot(xx,yy,'b'),plot(xx2,yy2,'g')
w = waitforbuttonpress;
close

%Height and intensity vals
figure,imshow(templateConverted),hold on,plot(xx,yy,'b')
[xv,yv] = ginput(1)
close
xv = round(xv);
VIndexHeight = [];
for i = 1:xv,
    VIndexHeight = [VIndexHeight; handConverted(i,xv)];
end
figure,plot(VIndexHeight)
[xLeft,tmpLeft]=ginput(1);
close
xLeft = round(xLeft);
lX = xi; lY = yi; rX = 0; rY = 0;
for v = xLeft:1500
   if VIndexHeight(v,1) < 0.4
       rX = xv;
       rY = v;
       break
   end
end

F9IndexHeight = sqrt( (lX-rX).^2 + (lY-rY).^2 );
F9IndexHeight = round(F9IndexHeight);

%-------------------------------------------------------------------------
%F10
%Mid finger height
%Mid finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
slopeMid = (yy(50) - yy(150))/(xx(50) - xx(150));

%Intersection
[xi,yi] = polyxpoly(xx,yy,xx2,yy2);
figure,imshow(templateConverted),hold on,plot(xx,yy,'b'),plot(xx2,yy2,'g')
w = waitforbuttonpress;
close

%Height and intensity vals
figure,imshow(templateConverted),hold on,plot(xx,yy,'b')
[xv,yv] = ginput(1)
close
xv = round(xv);
VMidHeight = [];
for i = 1:xv,
    VMidHeight = [VMidHeight; handConverted(i,xv)];
end
figure,plot(VMidHeight)
[xLeft,tmpLeft]=ginput(1);
close
xLeft = round(xLeft);
lX = xi; lY = yi; rX = 0; rY = 0;
for v = xLeft:1500
   if VMidHeight(v,1) < 0.4
       rX = xv;
       rY = v;
       break
   end
end

F10MidHeight = sqrt( (lX-rX).^2 + (lY-rY).^2 );
F10MidHeight = round(F10MidHeight);

%-------------------------------------------------------------------------
%F11
%Ring finger height
%Ring finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
slopeRing = (yy(50) - yy(150))/(xx(50) - xx(150));

%Intersection
[xi,yi] = polyxpoly(xx,yy,xx2,yy2);
figure,imshow(templateConverted),hold on,plot(xx,yy,'b'),plot(xx2,yy2,'g')
w = waitforbuttonpress;
close

%Height and intensity vals
figure,imshow(templateConverted),hold on,plot(xx,yy,'b')
[xv,yv] = ginput(1)
close
xv = round(xv);
VRingHeight = [];
for i = 1:xv,
    VRingHeight = [VRingHeight; handConverted(i,xv)];
end
figure,plot(VRingHeight)
[xLeft,tmpLeft]=ginput(1);
close
xLeft = round(xLeft);
lX = xi; lY = yi; rX = 0; rY = 0;
for v = xLeft:1500
   if VRingHeight(v,1) < 0.4
       rX = xv;
       rY = v;
       break
   end
end

F11RingHeight = sqrt( (lX-rX).^2 + (lY-rY).^2 );
F11RingHeight = round(F11RingHeight);

%-------------------------------------------------------------------------
%F12
%Pinky finger height
%Pinky finger template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
slopePinky = (yy(50) - yy(150))/(xx(50) - xx(150));

%Intersection
[xi,yi] = polyxpoly(xx,yy,xx2,yy2);
figure,imshow(templateConverted),hold on,plot(xx,yy,'b'),plot(xx2,yy2,'g')
w = waitforbuttonpress;
close

%Height and intensity vals
figure,imshow(templateConverted),hold on,plot(xx,yy,'b')
[xv,yv] = ginput(1)
close
xv = round(xv);
VPinkyHeight = [];
for i = 1:xv,
    VPinkyHeight = [VPinkyHeight; handConverted(i,xv)];
end
figure,plot(VPinkyHeight)
[xLeft,tmpLeft]=ginput(1);
close
xLeft = round(xLeft);
lX = xi; lY = yi; rX = 0; rY = 0;
for v = xLeft:1500
   if VPinkyHeight(v,1) < 0.4
       rX = xv;
       rY = v;
       break
   end
end

F12PinkyHeight = sqrt( (lX-rX).^2 + (lY-rY).^2 );
F12PinkyHeight = round(F12PinkyHeight);

%-------------------------------------------------------------------------
%F13
%Knuckles
%Knuckles  template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopeKnuckles = (yy(50) - yy(150))/(xx(50) - xx(150));

%Knuckles hand
hor = [1:size(handConverted,2)];
ver = (slopeKnuckles)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(hor,ver,'r')
w = waitforbuttonpress;
close
VKnuckles = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VKnuckles = [VKnuckles; handConverted(ver(i),hor(i))];
    end
end

%Knuckles width
figure,plot(VKnuckles)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VKnuckles(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VKnuckles(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F13PKnucklesWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

%-------------------------------------------------------------------------
%F14
%Backhand
%Backhand  template
figure,imshow(templateEdges)
[x,y]=ginput(2);
close all
x = round(x); y = round(y);
T = templateEdges( min(y):max(y), min(x):max(x) );
[k,l]=find(T);
kk = min(y)+k; ll = min(x)+l;
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.')
w = waitforbuttonpress;
close
p = polyfit(ll,kk,1);
xx = [1:size(templateConverted,1)];
yy = polyval(p,xx);
figure,imshow(templateConverted),hold on,plot(ll,kk,'r.'),plot(xx,yy,'b')
w = waitforbuttonpress;
close
slopeBackhand = (yy(50) - yy(150))/(xx(50) - xx(150));

%Backhand hand
hor = [1:size(handConverted,2)];
ver = (slopeBackhand)*( hor - xx(idx) ) + yy(idx); ver = round(ver);
figure,imshow(handConverted),hold on,plot(hor,ver,'r')
w = waitforbuttonpress;
close

VBackhand = [];
for i = 1:length(hor),
    if (ver(i)>=1)&(ver(i)<=size(handConverted,1)),
        VBackhand = [VBackhand; handConverted(ver(i),hor(i))];
    end
end

%Backhand width
figure,plot(VBackhand)
[xLeft,tmpLeft]=ginput(1);
[xRight,tmpRight]=ginput(1);
xLeft = round(xLeft); xRight = round(xRight);
close
lX = 0; lY = 0; rX = 0; rY = 0;
for v = xLeft:xRight
   if VBackhand(v,1) < 0.4
       lX = hor(v);
       lY = ver(v);
       break
   end
end
for v = xRight:-1:xLeft
   if VBackhand(v,1) < 0.4
       rX = hor(v);
       rY = ver(v);
       break
   end
end
F14BackhandWidth = sqrt( (lX-rX).^2 + (lY-rY).^2 );

