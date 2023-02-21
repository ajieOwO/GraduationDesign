clear;
close;
clc;

config = loadConfig();
config.obstacles = createObstacle(config.motionRange, config.obstaclesInfo);
drawMap(config);
findPath(config.motionRange, config.obstacles);