close;
clear;
clc;

config = loadConfig();
config.obstacles = createObstacle(config.motionRange, config.obstaclesInfo);

disp('地图已生成，保存至config.mat');

save config config