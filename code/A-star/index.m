clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'A*算法静态避障演示';
cd '../';
drawMap(config);
cd './A-star';

path = findPath(config.motionRange, config.obstacles);
plot3(path(:, 1), path(:, 2), path(:, 3), 'r', 'lineWidth', 2);
drawnow;
