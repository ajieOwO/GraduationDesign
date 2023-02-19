function obstacles = createObstacle(motionSpace, obstaclesNum)
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
	cube = getPosition(motionRange);
	cube.length = getSize(motionRange(1));
	cube.width = getSize(motionRange(1));
	cube.height = getSize(motionRange(1));
end

function sphere = createSphere(motionRange)
	sphere = getPosition(motionRange);
	sphere.r = getSize(motionRange(2));
end

function cylinder = createCylinder(motionRange)
	cylinder.h = getSize(motionRange(1));
	cylinder.r = getSize(motionRange(1));
end

function obstacle = getPosition(motionRange)
	obstacle.x = rand(1) * motionRange(1);
	obstacle.y = rand(1) * motionRange(2);
	obstacle.z = rand(1) * motionRange(3);
end

function size = getSize(range)
	size = (rand(1) + 0.1) * range / 5;
end