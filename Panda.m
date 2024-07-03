%Simple script to quickly demo use of CalCamArm.m
dataDirName = "panda_2";

%path to images of checkerboards
imageFolder = "./" + dataDirName + "/images";
%loading arm transformations
load("./" + dataDirName + "/arm_mat.mat");
%checkerboard square widths in mm
squareSize = 11;

%run calibration
outPath = "./"+"output/"+dataDirName;
diary diary.txt
[TBaseAA, TBase, TEnd, cameraParams, TBaseStd, TEndStd, pixelErr] = CalCamArm(convertStringsToChars(imageFolder), armMat, squareSize,'maxBaseOffset',2,'savepath', convertStringsToChars(outPath));

%print results
fprintf('\nOur camera to base with swapped orientation and position angle axis is\n')
disp(TBaseAA);
save(sprintf('%s/calib_ctr.mat',outPath), 'TBaseAA')

fprintf('\nFinal camera to arm base transform is\n')
disp(TBase);

fprintf('Final end effector to checkerboard transform is\n')
disp(TEnd);

fprintf('Final camera matrix is\n')
disp(cameraParams.IntrinsicMatrix');

fprintf('Final camera radial distortion parameters are\n')
disp(cameraParams.RadialDistortion);

fprintf('Final camera tangential distortion parameters are\n')
disp(cameraParams.TangentialDistortion);

movefile("diary.txt", outPath)