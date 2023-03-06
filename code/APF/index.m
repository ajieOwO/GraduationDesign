clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'APF算法静态避障演示';
config.apf.Ka = 0.0001;	% 引力场正比例系数
config.apf.m = 2;	 			% 引力势场因子
config.apf.range = 30;	% 斥力势场范围
config.apf.Kr = 100;		% 斥力场正比例系数
config.apf.step = 0.01;	% 寻路步长

path = findPath(config.motionRange, config.obstacles, config.apf);

cd '../';
drawMap(config, path);
cd './apf';