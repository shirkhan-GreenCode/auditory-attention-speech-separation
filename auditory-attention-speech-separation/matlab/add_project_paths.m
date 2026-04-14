function add_project_paths()
% Add project paths for the Auditory Attention Modeling repository.

root_dir = fileparts(mfilename('fullpath'));

addpath(root_dir);
addpath(fullfile(root_dir, 'src'));
addpath(fullfile(root_dir, 'legacy'));
addpath(genpath(fullfile(root_dir, 'external', 'nsltools')));
addpath(fullfile(root_dir, 'data', 'audio'));
addpath(fullfile(root_dir, 'data', 'templates'));
addpath(fullfile(root_dir, 'results'));

fprintf('Project paths added successfully.\n');
end