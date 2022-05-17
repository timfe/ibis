clear all; clc

base_path = '/Volumes/Data/projects/ibis/analysis/DPARSF_test/N13';

subjectsDir = dir((fullfile(base_path, 'FunImgAR', 'IN*')));

subjects = {subjectsDir.name};

%if length(ref_folders) == length(src_folders)
    for i = 1:length(subjects)
        subject = char(subjects(i));
        ref_folder_pattern = fullfile(base_path, '**', subject,'mean*.nii');
        sub_ref = dir(ref_folder_pattern);

        src_folder_pattern = fullfile(base_path, 'T1Img', subject, '/2*.nii');
        sub_src = dir(src_folder_pattern);
        ref = fullfile(sub_ref.folder,sub_ref.name);
        src = fullfile(sub_src.folder,sub_src.name);

        spm('defaults', 'fMRI');
        coregistration = coreg_job(src, ref);
        spm_jobman('run', coregistration);

        % Move files to T1ImgCoreg as defined by DPARSF Toolbox
        targetPath = char(fullfile(base_path, 'T1ImgCoreg', subject));
        coregisteredDir = dir(fullfile(base_path, 'T1Img', subject, '*.nii'));
        coregisteredFile = fullfile(coregisteredDir.folder, coregisteredDir.name);
        mkdir(targetPath);
        copyfile(coregisteredFile, targetPath);
    end
%end