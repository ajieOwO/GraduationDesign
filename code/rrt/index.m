clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'rrt算法静态避障演示';
config.step = 0.1;	% 步长

cd '../';
drawMap(config);
cd './rrt';

path = findPath(config.motionRange, config.obstacles, config.step * config.motionRange);
plot3(path(:, 1), path(:, 2), path(:, 3), 'r', 'lineWidth', 2);
drawnow;
