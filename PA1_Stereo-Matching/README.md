# Stereo_Matching
Vehicle Vision System Lecture Mid-Term Assignment

main.m 파일을 run하면 최종 figure 결과로 뜨는 이미지는 0번 이미지의 Raw Image, Undistortion Image, 
Image 쌍의 Feature Points Matching, Image Rectification, 두 종류의 방법으로 시행한 Disparity Map을 확인할 수 있다.

이미지 쌍의 피쳐 포인트 매칭 결과에서 yellow box는 harris corner의 결과이고, blue box는 sift로 descriptor를 추출한 후 매칭된 결과이다.
이것을 더이상 보고싶지 않다면 35번 Line의 get_correspondence_points함수의 마지막 파라미터를 0으로 바꾸면 display 되지 않는다.

나머지 Raw Image, Undistortion Image, Image Rectification 결과 또한 보고싶지 않다면 각 66, 68, 76번 Line을 주석처리하면 된다.

0번 이미지 쌍이 아닌 다른 이미지의 disparity map을 확인해보고 싶다면 62번 Line의 select_Image('Input Iamge Number') 
여기에 1을 입력하면 0번 이미지가 28을 입력하면 마지막인 27번 이미지 쌍을 disparity map을 구할 것이다.

Workspace에 저장되는 이미지는 Image1, Image2는 unsync_unrect된 0번 이미지이고, undistortImage1, undistortImage2는 왜곡 보정된 0번 이미지이다.
또한 I1Rect, I2Rect는 rectification된 0번 이미지이다.

Workspace에 저장되는 변수로, 0~27번 이미지의 매칭쌍을 모두 concatenate한 m1_concat, m2_concat 쌍이 있고, F와 E는 각각 Fundamental Matrix, Essential Matrix이다.
R, t는 Essential Matrix를 분해해서 나온 Rotation Matrix와 traslation이고, R_rect는 rectification을 위한 Matrix이다.


※사용한 MATLAB official toolbox
image processing toolbox
statistics and machine learning toolbox
Deep Learning Toolbox 
Computer Vision Toolbox



