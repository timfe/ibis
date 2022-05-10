# Instructions
```01_extract_data.ipynb```
- Helper file to extract .zip and .rar files and also instantly change the folder names to the respective pseudonyms (eg. ```IN01234N13```).
- Input: 
  - inputDir -> String: Path to folder that contains the zip (and/or rar) files.
  - outputDir -> String: Prefered folder where the DICOM folders are stored.

```02_create_nifti.ipynb```
- Helper file to convert DICOMs to NIFTIs using dcm2niix
- PLEASE NOTE: THE SCRIPT DELETES ALL FOLDERS EXCEPT ""RESTING-STATE"" AND ""sT1W_3D_TFE_SENSE"" TO SAVE DISK SPACE !!!!
- Also enables automatic transfer of the T1w Images to the target folder for DPABI: ```T1Img```. Note: This is commented and thus deactivated by default.
- Input: 
  - base_path -> String: Path to DICOMS which is the outputDir from ```01_extract_data.ipynb```.
  - outputPath -> String: Target folder for the converted NIFTIs.

```03_conversion.m```
- MATLAB script to convert the 3D rs-fMRI files to one 4D image.
- Input:  
  - base_path -> String: Path to NIFTIs which is the outputPath from ```02_create_nifti.ipynb```.
  - outputPath -> String: Target folder for the converted NIFTIs. This should also be the base folder for DPABI Toolbox ending ```FunImg```

Continue in DPABI: 
- Make sure the 4D functional images are saved in a folder ```funImg``` and the T1w structural images are saved in ```T1Img```. This is MANDATORY!
- These folders should contain one folder per subject
- See [this document](http://d.rnet.co/Course/V3.0EN/4_R-fMRI_Data_Processing_DPARSFA.pdf) on [rfmri.org/Course](http://rfmri.org/Course) for more information.
