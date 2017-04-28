<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>相册</title>
		<link rel="stylesheet" type="text/css" href="../public/css/mui.min.css"/>
		<link rel="stylesheet" type="text/css" href="../public/css/page.css"/>
		<link rel="stylesheet" href="../css/main.css">
		<script src="../public/js/jquery-3.2.0.min.js"></script>
		<script src="../public/js/page.js"></script>
		<script src="../js/main.js"></script>
	</head>

	<body>
		<header class="top-header">
			<div class="header-top-wrap">
				<div class="header-top">
					<img src="../img/banner_top.jpg" alt="banner">
					<div class="banner-words">
						<p class="a-fadeinL page1_1">我们不停的翻弄着回忆</p>
						<p class="a-fadeinL page1_2">却再也找不回那时的自己</p>
						<p class="fadeIn page1_3">红尘一梦，不再追寻</p>
					</div>
					<div class="loginIn">
						<div class="loginImg">
						<img src="../img/mr.jpg" alt="photo"/>
					</div>
					<div class="loginList">
						<ul>
							<li class="loginName">寻找火星人</li>
							<li class="personInfo"><a href="">个人中心</a></li>
							<li class="changePwd"><a href="">修改密码</a></li>
							<li class="exit"><a href="login.jsp">退出</a></li>
						</ul>
					</div>
					</div>
				</div>
			</div>
			<div class="nav-wrap">
				<ul class="nav" id="nav">
					<li>
						<a href="index.jsp">首页</a>
					</li>
					<li>
						<a href="Article.jsp">博文</a>
					</li>
					<li class="navOn">
						<a href="Album.jsp">相册</a>
					</li>
					<li>
						<a href="Diary.jsp">日记</a>
					</li>
					<li>
						<a href="Guestbook.jsp">留言板</a>
					</li>
					<li>
						<a href="about.jsp">关于我</a>
					</li>
				</ul>
			</div>
		</header>
		<main class="clearfix">
			<div class="main-wrap clearfix">
				<div class="location">
				<span class="mui-icon mui-icon-location">您当前的位置：</span><a href="index.jsp">首页</a><span>></span><span>相册</span>
			</div>
			</div>
		</main>
		<footer>
			<p>©2017 Design by Gao</p>
		</footer>
		<canvas id="canvas" style="height: 1000px;"></canvas>
		<!--<script>
			var bodyHeight = $('body').height();
			$('canvas').height(bodyHeight);
		</script>-->
	</body>

</html>