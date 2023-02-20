clear;
close;
clc;

config = loadConfig();
config.obstacles = createObstacle(config.motionSpace, config.obstaclesInfo);
drawMap(config);
findPath(config.motionSpace, config.obstacles);