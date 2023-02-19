clear;
close;
clc;

config = loadConfig();
config.obstacles = createObstacle(config.motionSpace, config.obstaclesNum);
drawMap(config);