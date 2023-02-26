clear;
close;
clc;

load('../config.mat');	% 加载配置文件

config.title = 'ACO算法静态避障演示';
config.aoc.antNum = 50;	% 蚂蚁数量
config.aoc.Iterations = 200;	% 迭代次数

path = findPath(config.motionRange, config.obstacles, config.aco);

cd '../';
drawMap(config, path);