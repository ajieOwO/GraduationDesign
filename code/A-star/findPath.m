function path = findPath(range, obstacles)
	% 寻路

	list = struct;				% 所有节点


	list(1, 1, 1).x = 1;	% x坐标
	list(1, 1, 1).y = 1;	%	y坐标
	list(1, 1, 1).z = 1;	% z坐标
	list(1, 1, 1).from = [1 1 1];	% 父节点坐标
	list(1, 1, 1).cost = 0;	% 开销
	list(1, 1, 1).expectCost = (3 * (range - 1) ^ 2) ^ 0.5;	% 预计剩余开销
	list(1, 1, 1).status = 2;	% 节点状态。1：关闭；2：开启
	list(1, 1, 1).index = 1;	% 在openList中的索引

	list(1, 1, 2).status = 0;	% 创建一个空节点，防止list结构体维度下降
	openList = [1 1 1];
	% 初始化起点
	
	path = [];
	% 初始化结果

	while size(openList, 1) > 0
		% 打开的节点不为空时，保持循环

		cost = [];
		for k = 1 : 1 : size(openList, 1)
			node = list(openList(k, 1), openList(k, 2), openList(k, 2));
			if node.status == 2
				cost = [cost; [node.cost + node.expectCost] node.x node.y node.z];
			% else
				% node
			end
		end
		if size(cost, 1) == 1
			node = list(cost(2), cost(3), cost(4));
		else
			[tmp, index] = sort(cost(:, 1), 1, 'ascend');
			best = cost(index(1), 2 : 4);
			node = list(best(1), best(2), best(3));	% 获取节点
		end
		%	获取代价总和最小的节点索引

		if node.x == range && node.y == range && node.z == range
			while true
				path = [path; node.x node.y node.z];
				if(node.x == 1 && node.y == 1 && node.z == 1)
					return
				end
				node = list(node.from(1), node.from(2), node.from(3));
			end
		end

		openList(node.index, :)	= [];% 从打开的列表中删除此节点

		for k = node.index : 1 : size(openList, 1)
			p = openList(k, :);
			ele = list(p(1), p(2), p(3));
			ele.index = i;
		end
		% 矫正后续节点的索引

		list(node.x, node.y, node.z).status = 1;	% 关闭此节点
		list(node.x, node.y, node.z).index = 0;	% 清空此节点的索引

		for x = node.x - 1 : 1 : node.x + 1
			if x > 0 && x <= range
				for y = node.y - 1 : 1 : node.y + 1
					if y > 0 && y <= range
						for z = node.z - 1 : 1 : node.z + 1
							if z > 0 && z <= range
								if x == node.x && y == node.y && z == node.z	% 新节点坐标重复
									continue;	% 跳过此节点
								end

								if min((size(list)) - [x y z]) >= 0	% 若未超出list范围
									if list(x, y, z).status	% 若节点已存在
										continue;	% 跳过此节点
									end
								end
							
								list(x, y, z).x = x;	% x坐标
								list(x, y, z).y = y;	%	y坐标
								list(x, y, z).z = z;	% z坐标
								if isObstacle(list(x, y, z), obstacles)	% 若此节点在障碍物中
									list(x, y, z).status = 1;	% 关闭此节点
								else	% 若节点不在障碍物中
									openList = [openList; [x y z]];	% 打开此节点
									if(x == 1 && y == 1 && z == 2)
										list(x, y, z).status;
									end
									list(x, y, z).from = [node.x node.y node.z];	% 父节点坐标
									list(x, y, z).cost = node.cost + ((node.x - x) ^ 2 + (node.y - y) ^ 2 + (node.z - z) ^ 2) ^ 0.5;	% 开销
									list(x, y, z).expectCost = ((range - x) ^ 2 + (range - z) ^ 2 + (range - z) ^ 2) ^ 0.5;	% 预计剩余开销
									list(x, y, z).status = 2;	% 节点状态。1：关闭；2：开启
									list(x, y, z).index = size(openList, 1);	% 在openList中的索引
								end
							end
						end
					end
				end
			end
		end
	end
end

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