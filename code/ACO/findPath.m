function path = findPath(range, obstacles, aco)
	path = [];
	cd '../';

	pheromone = zeros(3, 3, 3, range ^ 3);	% 初始化信息素矩阵
	list = [];	% 初始化蚂蚁路径

	for m = 1 : 1 : aco.antNum	% 每只蚂蚁单独计算
		ant = [];	% 当前蚂蚁的路径
		current = [1 1 1];	% 初始化蚂蚁当前所处节点
		for n = 1 : 1 : range ^ 3	% 进行下一步的路径尝试，最长不可能超过节点总数
			currentPheromone = ;
			% 获取当前节点的信息素矩阵

			tmp = rand(3, 3, 3) .* pheromone(:, :, :, getIndex(current));
			% 对随机数矩阵加信息素浓度权重

			nearList = [];	% 候选节点
			
			for a = 1 : 1 : 3
				for b = 1 : 1 : 3
					for c = 1 : 1 : 3
						% 遍历周围所有节点
						if a == 2 && b == 2 && c == 2
							continue;	% 排除当前节点
						end

						node = current + [a b c];
						if min(node) < 1 || max(node) > range
							continue;	% 排除不存在节点
						end
						if isObstacle(struct('x', node(1), 'y', node(2), 'z', node(3)))
							continue;	% 排除不可达节点
						end
						if ismember(getIndex(node))
							continue;	% 排除已经过节点
						end

						% realPheromone = max(tmp(a, b, c), )

						nearList = [nearList; [tmp(a, b, c), node]];
					end
				end
			end
			% 找到

		end
	end

	function index = getIndex(position)
		% 根据坐标值获取索引值
		index = sum(position - [1 1 1] .* [range ^ 2, range, 1]) + 1
	end

	function position = getPosition(index)
	end
end