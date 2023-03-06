function path = findPath(range, obstacles, apf)
	% 寻路
	% path = [0 0 0];
	cd '../';

	path = [];
	node = [1 1 1];

	while true
		attracction = getAttracction(node(1), node(2), node(3));
		repulsion = getRepulsion(node(1), node(2), node(3));
		force = attracction + repulsion;
		diff = atan(force);
		node = node + diff / norm(diff) * apf.step;
		path = [path; node];
		if max(abs(node - [range range range])) < apf.step
			break;
		end
	end

	cd './APF';
	
	function attracction = getAttracction(x, y, z)
		% 计算吸引力

		diff = [range range range] - [x y z];	% 当前坐标与引力源差值
		distance = norm(diff);	% 与引力源距离
		force = apf.Ka * distance	^ apf.m;	% 引力强度
		attracction = force * (diff / norm(diff));	% 计算引力矢量值
	end

	function repulsion = getRepulsion(x, y, z)
		% 计算斥力
		repulsion = [0, 0, 0];

		for k = 1 : length(obstacles.cube)
			repulsion = repulsion + getCubeRepulsion(obstacles.cube(k));
		end

		for k = 1 : length(obstacles.sphere)
			repulsion = repulsion + getSphere(obstacles.sphere(k));
		end

		for k = 1 : length(obstacles.cylinder)
			repulsion = repulsion + getCylinder(obstacles.cylinder(k));
		end
		

		function force = getCubeRepulsion(cube)
			% 计算立方体带来的斥力
			diff = [x, y, z] - [cube.x, cube.y, cube.z];	% 计算中心坐标差值
			if abs(diff(1)) > cube.length
				surfaceDiff(1) = diff(1) - sign(diff(1)) * cube.length;
			else
				surfaceDiff(1) = 0;
			end
			if abs(diff(2)) > cube.width
				surfaceDiff(2) = diff(2) - sign(diff(2)) * cube.width;
			else
				surfaceDiff(2) = 0;
			end
			if abs(diff(3)) > cube.height
				surfaceDiff(3) = diff(3) - sign(diff(3)) * cube.height;
			else
				surfaceDiff(3) = 0;
			end
			% 计算表面差值

			force = getForce(surfaceDiff);
		end

		function force = getSphere(sphere)
			% 计算球体带来的斥力
			diff = [x, y, z] - [sphere.x, sphere.y, sphere.z];	% 中心坐标差值
			surfaceDiff = diff - diff / norm(diff) * sphere.r; % 计算表面差值

			force = getForce(surfaceDiff);
		end

		function force = getCylinder(cylinder)
			% 计算圆柱体带来的斥力
			diff = [x, y, z] - [cylinder.x, cylinder.y, cylinder.z + cylinder.h / 2];	% 计算中心坐标差值
			if norm(diff(1 : 2)) > cylinder.r
				surfaceDiff = diff - [diff(1 : 2) / norm(diff(1 : 2)) * cylinder.r, 0];
			else
				surfaceDiff = [0 0 0];
			end
			if abs(diff(3)) > cylinder.h / 2;
				surfaceDiff(3) = diff(3) - sign(diff(3)) * (cylinder.h / 2);
			else
				surfaceDiff(3) = 0;
			end
			% 计算表面差值

			force = getForce(surfaceDiff);
		end

		function force = getForce(diff)
			% 根据坐标差计算斥力
			distance = norm(diff);	% 与引力源距离
			if  distance > apf.range	% 超出作用范围
				force = 0;	% 无引力
			else	% 在作用范围内
				force = apf.Kr * (1 / distance - 1 / apf.range)	^ 2 / distance ^ 2;
			end
			force = force * diff / norm(diff);	% 计算斥力矢量值
		end
	end

end

