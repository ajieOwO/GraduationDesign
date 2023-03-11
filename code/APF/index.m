clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'APF算法静态避障演示';
config.apf.Ka = 0.001;	% 引力场正比例系数
config.apf.m = 2;	 			% 引力势场因子
config.apf.range = 5;	% 斥力势场范围
config.apf.Kr = 1;		% 斥力场正比例系数
config.apf.step = 0.1;	% 寻路步长

cd '../';
drawMap(config);
cd './apf';

path = findPath(config.motionRange, config.obstacles, config.apf);
plot3(path(:, 1), path(:, 2), path(:, 3), 'r', 'lineWidth', 2);
drawnow;
