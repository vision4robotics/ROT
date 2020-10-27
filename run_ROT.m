function results = run_ROT(seq, res_path, bSaveImage)

% Feature specific parameters
hog_params.cell_size = 4;
hog_params.compressed_dim = 10;

cn_params.tablename = 'CNnorm';
cn_params.useForGray = false;
cn_params.cell_size = 4;
cn_params.compressed_dim = 3;

% Which features to include
params.t_features = {
    struct('getFeature',@get_fhog,'fparams',hog_params),...
    struct('getFeature',@get_table_feature, 'fparams',cn_params),...
};

% Global feature parameters1s
params.t_global.normalize_power = 2;    % Lp normalization with this p
params.t_global.normalize_size = true;  % Also normalize with respect to the spatial size of the feature
params.t_global.normalize_dim = true;   % Also normalize with respect to the dimensionality of the feature

% Image sample parameters
params.search_area_shape = 'square';    % The shape of the samples
params.search_area_scale = 4.5;         % The scaling of the target size to get the search area
params.min_image_sample_size = 150^2;   % Minimum area of image samples
params.max_image_sample_size = 200^2;   % Maximum area of image samples

% Detection parameters
params.newton_iterations = 5;           % The number of Newton iterations used for optimizing the detection score
params.clamp_position = false;          % Clamp the target position to be inside the image

% Learning parameters
params.output_sigma_factor = 1/16;		% Label function sigma

% Scale parameters for the translation model
% Only used if: params.use_scale_filter = false
params.number_of_scales = 7;            % Number of scales to run the detector
params.scale_step = 1.01;               % The scale factor

% Scale filter parameters
% Only used if: params.use_scale_filter = true
params.use_scale_filter = true;         % Use the fDSST scale filter or not (for speed)
params.scale_sigma_factor = 1/16;       % Scale label function sigma
params.scale_learning_rate = 0.025;		% Scale filter learning rate
params.number_of_scales_filter = 17;    % Number of scales
params.number_of_interp_scales = 33;    % Number of interpolated scales
params.scale_model_factor = 1.0;        % Scaling of the scale model
params.scale_step_filter = 1.03;        % The scale factor for the scale filter
params.scale_model_max_area = 32*16;    % Maximume area for the scale sample patch
params.scale_feature = 'HOG4';          % Features for the scale filter (only HOG4 supported)
params.s_num_compressed_dim = 'MAX';    % Number of compressed feature dimensions in the scale filter
params.lambda = 1e-2;					% Scale filter regularization
params.do_poly_interp = true;           % Do 2nd order polynomial interpolation to obtain more accurate scale

% Initialize
params.seq = seq;

% ROT relevant parameters
params.learning_rate = 0.033;
params.admm_iterations = 3;
params.mu = 10;
params.beta = 10;
params.mu_max = 100000;
params.gamma = 0.02;

% Regularizaiton window
params.reg_window_max = 1e4;           % The maximum value of the regularization window
params.reg_window_min = 1e-4;          % the minimum value of the regularization window

% Visualization
params.print_screen = 0;
params.visualization = 0;               % Visualiza tracking and detection scores
params.disp_fps = 0;

% Run tracker
results = tracker(params);
