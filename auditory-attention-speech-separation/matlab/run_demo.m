function outputs = run_demo()
%RUN_DEMO Demonstration script for the auditory attention pipeline.

add_project_paths();

audio_file    = fullfile('data', 'audio', 'beshno.wav');
template_file = fullfile('data', 'templates', 'templat.mat');
frame_ms      = 32;
fs            = 44100;
cluster_count = 100;
results_dir   = fullfile('results');

if ~exist(results_dir, 'dir')
    mkdir(results_dir);
end

outputs = run_attention_pipeline(audio_file, template_file, frame_ms, fs, cluster_count, results_dir);
disp('Demo finished successfully.');
end