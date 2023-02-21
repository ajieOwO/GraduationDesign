function obstacles = createObstacle(motionRange, obstaclesInfo)
	% 生成障碍物
	obstacles = struct;
	obstacles.cube = [];
	obstacles.sphere = [];
	obstacles.cylinder = [];
	
	for i = 1:obstaclesInfo.cubeNum
		obstacles.cube = [obstacles.cube createCube()];
	end
	for i = 1:obstaclesInfo.sphereNum
		obstacles.sphere = [obstacles.sphere createSphere()];
	end
	for i = 1:obstaclesInfo.cylinderNum
		obstacles.cylinder = [obstacles.cylinder createCylinder()];
	end
	

	function cube = createCube()
		% 生成立方体
		cube = getPosition();
		cube.length = getSize();
		cube.width = getSize();
		cube.height = getSize();
	end

	function sphere = createSphere()
		% 生成球体
		sphere = getPosition();
		sphere.r = getSize();
	end

	function cylinder = createCylinder()
		% 生成圆柱体
		cylinder = getPosition();
		cylinder.h = getSize();
		cylinder.r = getSize();
	end

	function obstacle = getPosition()
		% 生成随机三维坐标
		obstacle.x = rand(1) * motionRange;
		obstacle.y = rand(1) * motionRange;
		obstacle.z = rand(1) * motionRange;
	end

	function size = getSize()
		% 生成随机尺寸
		size = (rand(1) + 0.1) * motionRange * obstaclesInfo.size;
	end
	
end