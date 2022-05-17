clear all; clc

base_path = '/Volumes/Data/projects/ibis/analysis/DPARSF_test2/N13';

subjectsDir = dir((fullfile(base_path, 'FunImgAR', 'IN*')));

subjects = {subjectsDir.name};


for i = 1:length(subjects)
    subject = char(subjects(i));

    % Move files to T1ImgCoreg as defined by DPARSF Toolbox
    targetPath = char(fullfile(base_path, 'T1ImgCoreg', subject));
    T1Dir = dir(fullfile(base_path, 'T1Img', subject, '*.nii'));
    T1File = fullfile(T1Dir.folder, T1Dir.name);
    mkdir(targetPath);
    copyfile(T1File, targetPath);

    % Estimate Coregister
    ref_folder_pattern = fullfile(base_path, '**', subject,'mean*.nii');
    sub_ref = dir(ref_folder_pattern);

    src_folder_pattern = fullfile(base_path, 'T1ImgCoreg', subject, '/*.nii');
    sub_src = dir(src_folder_pattern);
    ref = fullfile(sub_ref.folder,sub_ref.name);
    src = fullfile(sub_src.folder,sub_src.name);

    spm('defaults', 'fMRI');
    coregistration = coreg_job(src, ref);
    spm_jobman('run', coregistration);
end