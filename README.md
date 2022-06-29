# robo_base

## Required Packages
- robo_base_bringup
- robo_base_description
- robo_base_gazebo

## Launch Simulation World
starts the simulation in Gazebo  
`roslaunch robo_base_gazebo robo_base_house.launch`   

## SLAM 
to start gmapping  
`roslaunch robo_base_slam robo_base_slam.launch`  
start rtabmapping  
`roslaunch robo_base_slam robo_base_slam.launch slam_methods:=rtab_velodyne `  

## save map
PS: don't close gazebo and rviz before you haven't saved the map  
cd into folder where you want to save the map  
`rosrun map_server map_saver -f <map_name>`  
when using rtabmap the map is automatically save at ==".ros/rtabmap.db"==  


