clear all; clc

base_path = '/Volumes/Data/projects/ibis/analysis/data';
folder_pattern = fullfile(base_path, '/IN*');
folders = dir(folder_pattern);
subjects = {folders.name};

for i = 1:length(subjects)
    subject = char(subjects(i));
    outputPath = strcat('/Volumes/Data/projects/ibis/analysis/DPARSF/FunRaw/', subject);
    subjectFolder = fullfile(base_path, subject);
    funFolder = fullfile(subjectFolder, 'RESTING-STATE');
    sprintf('Processing subject: %s', subject);
    if isfolder(funFolder) && not(isfolder(outputPath))
        mkdir(outputPath);
        try
            fileList = dir(fullfile(funFolder,'*.nii'));
            firstFile = fileList(1);
            
            % Get JSON files for TR readout
            jsonFiles = dir(fullfile(funFolder, '*.json'));
            json = jsonFiles(1);
            jsonFile = fullfile(json.folder, json.name);
            tr_val = get_TRval(jsonFile);
            
            prefix = split(firstFile.name, '_');
            prefix = string(prefix(1));
            volumes = [];
            for j = 1:length(fileList)
                file = fileList(j);
                filename = fullfile(file.folder, file.name);
                volumes = [volumes; filename];
                volumes = cellstr(volumes);
            end
            outputFilename = char(strcat(prefix, "_RESTING-STATE.nii"));
            outputLocation = fullfile(outputPath, outputFilename);

            spm('defaults', 'FMRI');
            conversion_4D = conversion_job(volumes, outputLocation, tr_val);
            spm_jobman('run', conversion_4D);
        catch
        end
    else
        sprintf('No rs-fMRI for subject: %s', subject);
        continue
    end
end

