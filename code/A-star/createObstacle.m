function obstacles = createObstacle(motionSpace, obstaclesInfo)
	% 生成障碍物
	obstacles = struct;
	motionRange = motionSpace.end - motionSpace.start;
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
		cube.length = getSize(motionRange(1));
		cube.width = getSize(motionRange(1));
		cube.height = getSize(motionRange(1));
	end

	function sphere = createSphere()
		% 生成球体
		sphere = getPosition();
		sphere.r = getSize(motionRange(2));
	end

	function cylinder = createCylinder()
		% 生成圆柱体
		cylinder = getPosition();
		cylinder.h = getSize(motionRange(1));
		cylinder.r = getSize(motionRange(1));
	end

	function obstacle = getPosition()
		% 生成随机三维坐标
		obstacle.x = rand(1) * motionRange(1);
		obstacle.y = rand(1) * motionRange(2);
		obstacle.z = rand(1) * motionRange(3);
	end

	function size = getSize(range)
		% 生成随机尺寸
		size = (rand(1) + 0.1) * range * obstaclesInfo.size;
	end
	
end