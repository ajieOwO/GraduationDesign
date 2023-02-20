function obstacles = createObstacle(motionSpace, obstaclesNum)
	% 生成障碍物
	obstacles = struct;
	motionRange = motionSpace.end - motionSpace.start;
	obstacles.cube = [];
	obstacles.sphere = [];
	obstacles.cylinder = [];
	
	for i = 1:obstaclesNum.cube
		obstacles.cube = [obstacles.cube createCube(motionRange)];
	end
	for i = 1:obstaclesNum.sphere
		obstacles.sphere = [obstacles.sphere createSphere(motionRange)];
	end
	for i = 1:obstaclesNum.cylinder
		obstacles.cylinder = [obstacles.cylinder createCylinder(motionRange)];
	end
	
end

function cube = createCube(motionRange)
	% 生成立方体
	cube = getPosition(motionRange);
	cube.length = getSize(motionRange(1));
	cube.width = getSize(motionRange(1));
	cube.height = getSize(motionRange(1));
end

function sphere = createSphere(motionRange)
	% 生成球体
	sphere = getPosition(motionRange);
	sphere.r = getSize(motionRange(2));
end

function cylinder = createCylinder(motionRange)
	% 生成圆柱体
	cylinder = getPosition(motionRange);
	cylinder.h = getSize(motionRange(1));
	cylinder.r = getSize(motionRange(1));
end

function obstacle = getPosition(motionRange)
	% 生成随机三维坐标
	obstacle.x = rand(1) * motionRange(1);
	obstacle.y = rand(1) * motionRange(2);
	obstacle.z = rand(1) * motionRange(3);
end

function size = getSize(range)
	% 生成随机尺寸
	size = (rand(1) + 0.1) * range / 5;
end