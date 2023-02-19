function drawMap(config)
	figure(1);
	hold on;

	for i = 1:length(config.obstacles.cube)
		drawCube(config.obstacles.cube(i), config.color.obstacleSurface);
	end
	for i = 1:length(config.obstacles.sphere)
		drawSphere(config.obstacles.sphere(i), config.color.obstacleSurface, config.color.alpha);
	end
	alpha(config.color.alpha);

	view(3);	% 展示三维窗口
	grid on;	% 显示网格
	axis equal;	% 保持坐标轴比例一致
	range = [config.motionSpace.start;config.motionSpace.end];
	axis(range(:)');	% 设置显示范围

	xlabel('x');
	ylabel('y');
	zlabel('z');
	title(config.title);
end

function drawCube(cube, color)
	faces = [
		1 2 4 3;
		5 6 8 7;
		1 2 6 5;
		3 4 8 7;
		2 4 8 6;
		1 3 7 5
	];
	vertices = [
		cube.x - cube.length, cube.y - cube.width, cube.z - cube.height;
		cube.x - cube.length, cube.y - cube.width, cube.z + cube.height;
		cube.x - cube.length, cube.y + cube.width, cube.z - cube.height;
		cube.x - cube.length, cube.y + cube.width, cube.z + cube.height;
		cube.x + cube.length, cube.y - cube.width, cube.z - cube.height;
		cube.x + cube.length, cube.y - cube.width, cube.z + cube.height;
		cube.x + cube.length, cube.y + cube.width, cube.z - cube.height;
		cube.x + cube.length, cube.y + cube.width, cube.z + cube.height;
	];
	cube = patch('Faces', faces, 'Vertices', vertices, 'FaceColor', color);
end

function drawSphere(config, color, alpha)
	[x, y, z] = sphere(50);
	mesh(x * config.r + config.x, y * config.r + config.y, z * config.r + config.z, 'FaceColor', color, 'EdgeColor', 'none', 'FaceAlpha', alpha)
end

function drawCylinder(config, color, alpha)
	[x, y, z] = sphere(50);
end