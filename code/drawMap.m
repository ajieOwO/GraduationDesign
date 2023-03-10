function drawMap(config, path)
	% 绘制地图
	figure(1);
	hold on;

	for k = 1 : length(config.obstacles.cube)
		drawCube(config.obstacles.cube(k), config.color.obstacleSurface);
	end
	for k = 1 : length(config.obstacles.sphere)
		drawSphere(config.obstacles.sphere(k), config.color.obstacleSurface, config.color.alpha);
	end
	for k = 1 : length(config.obstacles.cylinder)
		drawCylinder(config.obstacles.cylinder(k), config.color.obstacleSurface, config.color.alpha);
	end
	alpha(config.color.alpha);
	% 绘制障碍物

	plot3(path(:, 1), path(:, 2), path(:, 3));
	% 绘制路径

	motionRange = config.motionRange;
	view(3);	% 展示三维窗口
	grid on;	% 显示网格
	axis equal;	% 保持坐标轴比例一致
	range = [1; motionRange];
	axis([range; range; range]);	% 设置显示范围

	xlabel('x');
	ylabel('y');
	zlabel('z');
	title(config.title);
	plot3(1, 1, 1, '*');
	plot3(motionRange, motionRange, motionRange, '*');
	text(1, 1, 1, '起点');
	text(motionRange, motionRange, motionRange, '终点');

	set(gcf,'outerposition',get(0,'screensize'));%全屏显示figure
end

function drawCube(cube, color)
	% 绘制立方体
	vertices = [	% 指定八个定点的坐标
		cube.x - cube.length, cube.y - cube.width, cube.z - cube.height;
		cube.x - cube.length, cube.y - cube.width, cube.z + cube.height;
		cube.x - cube.length, cube.y + cube.width, cube.z - cube.height;
		cube.x - cube.length, cube.y + cube.width, cube.z + cube.height;
		cube.x + cube.length, cube.y - cube.width, cube.z - cube.height;
		cube.x + cube.length, cube.y - cube.width, cube.z + cube.height;
		cube.x + cube.length, cube.y + cube.width, cube.z - cube.height;
		cube.x + cube.length, cube.y + cube.width, cube.z + cube.height;
	];
	faces = [	% 指定每个面的四个定点
		1 2 4 3;
		5 6 8 7;
		1 2 6 5;
		3 4 8 7;
		2 4 8 6;
		1 3 7 5
	];
	cube = patch('Faces', faces, 'Vertices', vertices, 'FaceColor', color);
end

function drawSphere(config, color, alpha)
	% 绘制球体
	[x, y, z] = sphere(20);
	mesh(x * config.r + config.x, y * config.r + config.y, z * config.r + config.z, 'FaceColor', color, 'EdgeColor', 'black', 'FaceAlpha', alpha)
end

function drawCylinder(config, color, alpha)
	% 绘制圆柱体
	[x, y, z] = cylinder;
	mesh(x * config.r + config.x, y * config.r + config.y, z * config.h + config.z, 'FaceColor', color, 'EdgeColor', 'black', 'FaceAlpha', alpha);
	theta = 0: 0.1: 2 * pi;
	fill3(sin(theta) * config.r + config.x, cos(theta) * config.r + config.y, theta * 0 + config.z, color);
	fill3(sin(theta) * config.r + config.x, cos(theta) * config.r + config.y, theta * 0 + config.z + config.h, color);
end