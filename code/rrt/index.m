clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'rrt算法静态避障演示';
config.step = 5;	% 步长

path = findPath(config.motionRange, config.obstacles, config.step);

cd '../';
drawMap(config, path);