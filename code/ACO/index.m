clear;
close;
clc;

load('../config.mat');	% 加载配置文件
config.title = 'ACO算法静态避障演示';
config.aco.antNum = 5;	% 蚂蚁数量
config.aco.Iterations = 100;	% 迭代次数

cd '../';
drawMap(config);
cd './ACO/';

path = findPath(config.motionRange, config.obstacles, config.aco);

plot3(path(:, 1), path(:, 2), path(:, 3), 'r', 'lineWidth', 2);
disp(['length=', num2str(length(path))]);
drawnow;

