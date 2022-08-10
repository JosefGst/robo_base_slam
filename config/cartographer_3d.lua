-- Copyright 2016 The Cartographer Authors
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--      http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.

include "map_builder.lua"
include "trajectory_builder.lua"

options = {
  map_builder = MAP_BUILDER,
  trajectory_builder = TRAJECTORY_BUILDER,
  map_frame = "map",
  tracking_frame = "base_footprint",
  published_frame = "odom",
  odom_frame = "odom",
  provide_odom_frame = false,
  publish_frame_projected_to_2d = false,
  use_odometry = true,
  use_nav_sat = false,
  use_landmarks = false,
  num_laser_scans = 0,
  num_multi_echo_laser_scans = 0,
  num_subdivisions_per_laser_scan = 1,
  num_point_clouds = 1,
  lookup_transform_timeout_sec = 1.,
  submap_publish_period_sec = 0.3,
  pose_publish_period_sec = 5e-3,
  trajectory_publish_period_sec = 30e-3,
  rangefinder_sampling_ratio = 1.,
  odometry_sampling_ratio = 0.5,
  fixed_frame_pose_sampling_ratio = 1.,
  imu_sampling_ratio = 1.,
  landmarks_sampling_ratio = 1.,
}

TRAJECTORY_BUILDER_3D.num_accumulated_range_data = 1 --160

MAP_BUILDER.use_trajectory_builder_3d = true
-- MAP_BUILDER.num_background_threads = 4
POSE_GRAPH.optimization_problem.huber_scale = 5e2
-- POSE_GRAPH.optimize_every_n_nodes = 10 --320
-- POSE_GRAPH.constraint_builder.sampling_ratio = 0.03
-- POSE_GRAPH.optimization_problem.ceres_solver_options.max_num_iterations = 10
-- POSE_GRAPH.constraint_builder.min_score = 0.62
-- POSE_GRAPH.constraint_builder.global_localization_min_score = 0.66


-----------------TUNE THESE PARAMETERS FOR LOW LATENCY-------------------------------

------------Global SLAM------------
POSE_GRAPH.optimize_every_n_nodes = 10 -- Decrease
MAP_BUILDER.num_background_threads = 16 -- Increase up to number of cores
POSE_GRAPH.global_sampling_ratio = 0.003 -- Decrease
POSE_GRAPH.constraint_builder.sampling_ratio = 0.04 -- Decrease
POSE_GRAPH.constraint_builder.min_score = 0.85 -- Increase
POSE_GRAPH.constraint_builder.global_localization_min_score = 0.7
POSE_GRAPH.global_constraint_search_after_n_seconds = 30 -- Increase
TRAJECTORY_BUILDER_2D.ceres_scan_matcher.ceres_solver_options.max_num_iterations = 5 -- Decrease

---------Global/Local SLAM---------
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.min_num_points = 100 -- Decrease
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_range = 10. -- Decrease
TRAJECTORY_BUILDER_2D.adaptive_voxel_filter.max_length = 1.0 -- Increase
TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.min_num_points = 50 -- Decrease
TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.max_range = 10. -- Decrease
TRAJECTORY_BUILDER_2D.loop_closure_adaptive_voxel_filter.max_length = 1.8 -- Increase
TRAJECTORY_BUILDER_2D.voxel_filter_size = 0.05 -- Increase
-- TRAJECTORY_BUILDER_2D.submaps.resolution=0.05 -- Increase
TRAJECTORY_BUILDER_2D.submaps.num_range_data = 35 -- Decrease
TRAJECTORY_BUILDER_2D.max_range = 10. -- Decrease

------------------------------------------------------------------------
TRAJECTORY_BUILDER_3D.low_resolution_adaptive_voxel_filter.min_num_points = 100 -- Decrease
TRAJECTORY_BUILDER_3D.low_resolution_adaptive_voxel_filter.max_range = 10 -- Decrease
TRAJECTORY_BUILDER_3D.low_resolution_adaptive_voxel_filter.max_length = 1.0 -- Decrease

return options
