function path = findPath(range, obstacles, aco)
	path = [];
	cd '../';
	
	target = getIndex([range range range]);	% 目标点的索引

	pheromone = zeros(3, 3, 3, range ^ 3);	% 初始化信息素矩阵

	for m = 1 : 1 : aco.antNum	% 每只蚂蚁单独计算
		ant = getIndex([1 1 1]);	% 蚂蚁的路径
		for n = 1 : 1 : range ^ 3	% 进行下一步的路径尝试，最长不可能超过节点总数

			current = ant(n);	% 获取蚂蚁当前所处节点索引
			if current == target	% 蚂蚁到达终点
				refreshPhoromone(0.1);
				disp('到达终点');
				% 此路径到达终点，增加信息素浓度
				break;
			end

			nearList = [];	% 候选节点列表
			
			for a = -1 : 1 : 1
				for b = -1 : 1 : 1
					for c = -1 : 1 : 1
						% 遍历周围所有节点
						if a == 0 && b == 0 && c == 0
							continue;	% 排除当前节点
						end


						node = getPosition(current) + [a b c];	% 新节点坐标
						index = getIndex(node);	% 新节点索引
						if min(node) < 1 || max(node) > range
							continue;	% 排除不存在节点
						end
						if isObstacle(struct('x', node(1), 'y', node(2), 'z', node(3)), obstacles)
							continue;	% 排除不可达节点
						end
						if max(ismember([index, -1], ant))
							continue;	% 排除已经过节点
						end

						currentPhoromone = pheromone(2 + a, 2 + b, 2 + c, current);
						otherPhoromone = pheromone(2 - a, 2 - b, 2 - c, index);
						% 分别获取本节点储存的目标节点信息素浓度，和目标节点储存的本节点信息素浓度

						nearList = [nearList; [index, currentPhoromone + otherPhoromone]];
						% 将当前新节点列入候选节点
					end
				end
			end

			if length(nearList)	% 有可选节点
				[tmp, index] = sort(nearList, 1, 'descend');	% 对所有可选节点排序
				nearestIndex = index(1, 2);	% 最优节点在可选节点列表中的索引
				nearestNodeIndex = nearList(nearestIndex, 1);	% 最优节点的索引
				ant = [ant nearestNodeIndex];	% 将信息素浓度最高的作为下一节点
			else	% 无可选节点
				% 此路径落入陷阱，全部削减信息素浓度
				disp('落入陷阱');
				refreshPhoromone(-0.1);
				break;
			end
		end
	end

	function refreshPhoromone(increase)
		% 刷新信息素
		for k = 2 : 1 : length(ant)	% 刷新所有节点信息素浓度
			thisNode = ant(k - 1);	% 当前节点索引
			nextNode = ant(k);	% 下一节点索引
			relative = getPosition(nextNode) - getPosition(thisNode) + [2 2 2];	% 当前节点指向下一节点的方位矩阵
			currentPhoromone = pheromone(relative(1), relative(2), relative(3), thisNode);	% 当前信息素浓度
			pheromone(relative(1), relative(2), relative(3), thisNode) = currentPhoromone + increase;
		end
	end

	function index = getIndex(position)
		% 根据坐标值获取索引值
		index = sum((position - [1 1 1]) .* [range ^ 2, range, 1]) + 1;
	end

	function position = getPosition(index)
		% 根据索引值计算坐标值
		index = index - 1;
		position = [floor(index / range ^ 2), floor(mod(index, range ^ 2) / range), mod(index, range)] + [1 1 1];
	end
end