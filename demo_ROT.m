% This demo script runs the Region-Oriented Tracker (ROT).

close all;

% Add paths
setup_paths();

% Load video information
video_path = './sequences/Surfing06';
[seq, ground_truth] = load_video_info(video_path);

% Run ROT
results = run_ROT(seq);

close all;