function config = loadConfig()
	%	加载配置
	config = struct;

	config.title = 'A*算法静态避障演示';

	config.motionSpace.start = [0 0 0];
	config.motionSpace.end = [1000 1000 1000];
	% 设置运动空间范围
	
	config.obstaclesInfo.cubeNum = 3;			% 立方体数量
	config.obstaclesInfo.sphereNum = 2;		% 球体数量
	config.obstaclesInfo.cylinderNum = 3;	% 圆柱体数量
	config.obstaclesInfo.size = 0.2;			% 障碍物最大尺寸（相对于运动空间）
	% 设置障碍物数量
	
	config.color.alpha = 0.7;
	config.color.obstacleSurface = 'green';
	% 设置颜色和透明度
end