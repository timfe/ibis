%-----------------------------------------------------------------------
% Job saved on 31-Mar-2017 11:39:36 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6470)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
function matlabbatch = conversion_job(volumes, outputLocation, tr_val)

    matlabbatch{1}.spm.util.cat.vols = volumes;
    matlabbatch{1}.spm.util.cat.name = char(outputLocation);
    matlabbatch{1}.spm.util.cat.dtype = 4;
    matlabbatch{1}.spm.util.cat.RT = tr_val;
