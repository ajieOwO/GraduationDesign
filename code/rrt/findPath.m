function path = findPath(range, obstacles, step)
	% 寻路

	path = [range range range];

	node = [1 1 1];
	parent = [0];
	% 初始化节点

	cd '../';

	while true
		point = rand(1, 3) * range;	% 随机一个节点

		distance = node - point;
		[tmp, index] = sort(sum(distance .* distance, 2));
		% 计算与所有节点的距离并排序

		nearest = node(index(1), :);	% 获取最近节点
		diff = (point - nearest) / tmp(1) ^ 0.5;	% 计算步长
		reachable = true;	% 初始化为可达
		for k = 1 : step	% 将路径离散化并进行障碍物判断
			tmp = nearest + diff * k;
			if isObstacle(struct('x', tmp(1), 'y', tmp(2), 'z', tmp(3)), obstacles)	% 若为障碍物
				reachable = false;	% 不可达
				break	% 结束判断
			end
		end

		if reachable	% 若路径可达
			newNode = nearest + diff * 10;
			node = [node ; newNode];
			parent = [parent index(1)];
			% 保存此节点

			distance = [range range range] - newNode;
			sum(distance .* distance)
			if sum(distance .* distance) < step ^ 2	% 若到达目标点附近
				key =  length(parent);
				while true
					path = [path; node(key, :)];
					key = parent(key);
					if key == 0
						break;
					end
				end

				path

				cd './rrt';
				return;
			end
		end

		
	end

end
