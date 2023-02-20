function config = loadConfig()
	%	加载配置
	config = struct;

	config.title = 'A*算法静态避障演示';

	config.motionSpace.start = [0 0 0];
	config.motionSpace.end = [1000 1000 1000];
	% 设置运动空间范围
	
	config.obstaclesNum.cube = 3;			% 立方体
	config.obstaclesNum.sphere = 2;		% 圆柱体
	config.obstaclesNum.cylinder = 3;	% 球体
	% 设置障碍物数量
	
	config.color.alpha = 0.7;
	config.color.obstacleSurface = 'green';
	% 设置颜色和透明度
end