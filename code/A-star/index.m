clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'A*算法静态避障演示';

path = findPath(config.motionRange, config.obstacles);

cd '../';
drawMap(config, path);