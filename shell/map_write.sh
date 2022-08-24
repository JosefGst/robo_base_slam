#!/bin/bash
rosservice call /finish_trajectory 0
rosservice call /write_state "filename: '${HOME}/ros/robo_base_ws/src/robo_base_slam/maps/cartographer3d.pbstream'"
rosrun cartographer_ros cartographer_pbstream_to_ros_map -map_filestem=${HOME}/ros/robo_base_ws/src/robo_base_slam/maps/cartographer3d -pbstream_filename=${HOME}/ros/robo_base_ws/src/robo_base_slam/maps/cartographer3d.pbstream -resolution=0.05