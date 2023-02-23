clear;
close;
clc;

config = loadConfig();
config.obstacles = createObstacle(config.motionRange, config.obstaclesInfo);
path = findPath(config.motionRange, config.obstacles);
drawMap(config, path);