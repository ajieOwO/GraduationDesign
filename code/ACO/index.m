clear;
close;
clc;

load('../config.mat');	% 加载配置文件
config.title = 'ACO算法静态避障演示';
config.aco.antNum = 50;	% 蚂蚁数量
config.aco.Iterations = 100;	% 迭代次数
config.aco.excitation = 0.5;	% 扰动系数
path = findPath(config.motionRange, config.obstacles, config.aco);


cd '../';
drawMap(config, path);