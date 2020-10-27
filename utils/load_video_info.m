function [seq, ground_truth] = load_video_info(video_path, first_frame)

if nargin < 2
    first_frame = 1;
end
ground_truth = dlmread([video_path '/groundtruth_rect.txt']);

seq.format = 'otb';
seq.len = size(ground_truth, 1);
seq.init_rect = ground_truth(1,:);

img_path = [video_path '/img/'];

if exist([img_path num2str(first_frame, '%04i.png')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%04i.png']);
elseif exist([img_path num2str(first_frame, '%04i.jpg')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%04i.jpg']);
elseif exist([img_path num2str(first_frame, '%04i.bmp')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%04i.bmp']);
elseif exist([img_path num2str(first_frame, '%05i.png')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%05i.png']);
elseif exist([img_path num2str(first_frame, '%05i.jpg')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%05i.jpg']);
elseif exist([img_path num2str(first_frame, '%05i.bmp')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%05i.bmp']);
elseif exist([img_path num2str(first_frame, '%06i.png')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%06i.png']);
elseif exist([img_path num2str(first_frame, '%06i.jpg')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%06i.jpg']);
elseif exist([img_path num2str(first_frame, '%06i.bmp')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path '%06i.bmp']);
elseif exist([img_path 'img' num2str(first_frame, '%06i.png')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path, 'img', '%06i.png']);
elseif exist([img_path 'img' num2str(first_frame, '%06i.jpg')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path, 'img', '%06i.jpg']);
elseif exist([img_path 'img' num2str(first_frame, '%06i.bmp')], 'file')
    img_files = num2str((first_frame:first_frame+seq.len-1)', [img_path, 'img', '%06i.bmp']);
else
    error('No image files to load.')
end

seq.s_frames = cellstr(img_files);

end

