function path = findPath(range, obstacles)
	% 寻路
	for i = 1 : 50;
		position.x = rand(1) * (range.end(1) - range.start(1));
		position.y = rand(1) * (range.end(2) - range.start(2));
		position.z = rand(1) * (range.end(3) - range.start(3));
		color = 'green';
		if isObstacle(position, obstacles)
			color = 'red';
		end
		plot3(position.x, position.y, position.z, '*', 'Color', color);
	end
end

function boolen = isObstacle(position, obstacles)
	% 此坐标是否为障碍物
	boolen = false;
	for i = 1 : length(obstacles.cube)
		if abs(position.x - obstacles.cube(i).x) <= obstacles.cube(i).length
			if abs(position.y - obstacles.cube(i).y) <= obstacles.cube(i).width
				if abs(position.z - obstacles.cube(i).z) <= obstacles.cube(i).height
					boolen = true;
					return;
				end
			end
		end
	end
	% 此坐标是否在立方体障碍物内

	for i = 1 : length(obstacles.sphere)
		x = (obstacles.sphere(i).x - position.x) ^ 2;
		y = (obstacles.sphere(i).y - position.y) ^ 2;
		z = (obstacles.sphere(i).z - position.z) ^ 2;
		if x + y + z <= obstacles.sphere(i).r ^ 2
			boolen = true;
			return;
		end
	end
	% 此坐标是否在球体障碍物内

	for i = 1 : length(obstacles.cylinder)
		x = (obstacles.cylinder(i).x - position.x) ^ 2;
		y = (obstacles.cylinder(i).y - position.y) ^ 2;
		h = position.z - obstacles.cylinder(i).z;
		if x + y <= obstacles.cylinder(i).r ^ 2
			if h >= 0 && h <= obstacles.cylinder(i).h
				boolen = true;
				return;
			end
		end
	end
	% 此坐标是否在圆柱体障碍物内
end