function boolen = isObstacle(position, obstacles)
	% 此坐标是否为障碍物
	boolen = false;
	for k = 1 : length(obstacles.cube)
		if abs(position.x - obstacles.cube(k).x) <= obstacles.cube(k).length
			if abs(position.y - obstacles.cube(k).y) <= obstacles.cube(k).width
				if abs(position.z - obstacles.cube(k).z) <= obstacles.cube(k).height
					boolen = true;
					return;
				end
			end
		end
	end
	% 此坐标是否在立方体障碍物内

	for k = 1 : length(obstacles.sphere)
		x = (obstacles.sphere(k).x - position.x) ^ 2;
		y = (obstacles.sphere(k).y - position.y) ^ 2;
		z = (obstacles.sphere(k).z - position.z) ^ 2;
		if x + y + z <= obstacles.sphere(k).r ^ 2
			boolen = true;
			return;
		end
	end
	% 此坐标是否在球体障碍物内

	for k = 1 : length(obstacles.cylinder)
		x = (obstacles.cylinder(k).x - position.x) ^ 2;
		y = (obstacles.cylinder(k).y - position.y) ^ 2;
		h = position.z - obstacles.cylinder(k).z;
		if x + y <= obstacles.cylinder(k).r ^ 2
			if h >= 0 && h <= obstacles.cylinder(k).h
				boolen = true;
				return;
			end
		end
	end
	% 此坐标是否在圆柱体障碍物内
end