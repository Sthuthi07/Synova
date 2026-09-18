function cfg = config()

% ==============================
% DATA FOLDERS
% ==============================

cfg.data.raw = "data/raw";
cfg.data.processed = "data/processed";
cfg.data.train = "data/train";
cfg.data.validation = "data/validation";
cfg.data.test = "data/test";


% ==============================
% MODEL FOLDERS
% ==============================

cfg.models.quality = "models/quality";
cfg.models.vessel = "models/vessel";
cfg.models.lesions = "models/lesions";
cfg.models.grading = "models/grading";


% ==============================
% RESULT FOLDERS
% ==============================

cfg.results.quality = "results/quality";
cfg.results.segmentation = "results/segmentation";
cfg.results.lesions = "results/lesions";
cfg.results.grading = "results/grading";
cfg.results.explainability = "results/explainability";
cfg.results.reports = "results/reports";


% ==============================
% IMAGE SETTINGS
% ==============================

cfg.image.targetSize = [512 512];


% ==============================
% DR LEVELS
% ==============================

cfg.drLevels = {
    "Level 0 - No DR"
    "Level 1 - Mild NPDR"
    "Level 2 - Moderate NPDR"
    "Level 3 - Severe NPDR"
    "Level 4 - Proliferative DR"
    };


% ==============================
% REFERABLE DR
% ==============================

cfg.referableLevel = 2;


% ==============================
% PROJECT TARGETS
% ==============================

cfg.target.sensitivity = 0.90;
cfg.target.specificity = 0.85;
cfg.target.reviewTimeSeconds = 30;

end