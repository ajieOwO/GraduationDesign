clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'APF算法静态避障演示';
config.apf.Ka = 1;	% 引力场正比例系数
config.apf.m = 2;	 	% 引力势场因子
config.apf.range = 10;	% 斥力势场范围
config.apf.Kr = 100000;	% 斥力场正比例系数
config.apf.step = 1;	% 寻路步长

path = findPath(config.motionRange, config.obstacles, config.apf);

cd '../';
drawMap(config, path);
cd './apf';