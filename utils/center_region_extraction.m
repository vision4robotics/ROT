function center_region_window = center_region_extraction(use_sz, target_sz)

center_region_window = zeros(use_sz);
target_region_sz = floor(target_sz);

target_sz_y_interval = [1, target_region_sz(1)] - floor((target_region_sz(1)+1)/2);
target_sz_x_interval = [1, target_region_sz(2)] - floor((target_region_sz(2)+1)/2);

center = floor((use_sz + 1)/ 2) + mod(use_sz + 1,2);
target_sz_y_region = center(1) + (target_sz_y_interval(1):target_sz_y_interval(2));
target_sz_x_region = center(1) + (target_sz_x_interval(1):target_sz_x_interval(2));

center_region_window(target_sz_y_region, target_sz_x_region) = 1;