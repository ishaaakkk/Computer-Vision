%% E19 Ishak Felfoul, Ferran Mesas 

im=imread('rabbit.jpg');
corners=detectHarrisFeatures(im);
imshow(im),title('corners')
hold on 
plot(corners)


im_obj=imread('coke.jpg');
figure,imshow(im_obj)
im_obj=rgb2gray(im_obj);

im_esc=rgb2gray(imread("anunci.jpg"));
figure,imshow(im_esc),title("escena")

kp_obj=detectSIFTFeatures(im_obj);
figure,imshow(im_obj),title("100 keypoints")
hold on 
plot(selectStrongest(kp_obj,100));
[feat_obj,kp_obj]=extractFeatures(im_obj,kp_obj);

kp_esc=detectSIFTFeatures(im_esc);
figure,imshow(im_esc),title("500 keypoints")
hold on 
plot(selectStrongest(kp_esc,500));
[feat_esc,kp_esc]=extractFeatures(im_esc,kp_esc);

pairs=matchFeatures(feat_obj,feat_esc, "MatchThreshold",10);

matched_kp_obj=kp_obj(pairs(:,1),:);
matched_kp_esc=kp_esc(pairs(:,2),:);
figure;
showMatchedFeatures(im_obj,im_esc,matched_kp_obj,matched_kp_esc,"montage")
title("aparellamants putatius")


%matching 
[tform,truepos]=estimateGeometricTransform2D(matched_kp_obj, matched_kp_esc, "affine");
true_kp_obj=matched_kp_obj(truepos,:);
true_kp_esc=matched_kp_esc(truepos,:);
figure;
showMatchedFeatures(im_obj,im_esc,true_kp_obj, true_kp_esc, "montage")
title("true matches")

[miday,midax]=size(im_obj);
box_obj=[1,100;midax,100;midax,miday;1,miday;1,100];
figure,imshow(im_obj),title('bounding box')
hold on 
line(box_obj(:,1),box_obj(:,2),'color','y');

newbox_obj=transformPointsForward(tform,box_obj);
figure,imshow(im_esc),title('detected object')
hold on; 
line(newbox_obj(:,1),newbox_obj(:,2),'color','y');




