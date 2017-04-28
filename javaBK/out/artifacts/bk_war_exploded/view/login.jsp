<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>登录</title>
		<link rel="stylesheet"  href="<%=basePath%>/public/css/mui.min.css" />
		<link rel="stylesheet"  href="<%=basePath%>/public/css/page.css" />
		<link rel="stylesheet" href="<%=basePath%>/css/main.css">
		<script src="<%=basePath%>/public/js/jquery-3.2.0.min.js"></script>
		<script src="<%=basePath%>/public/js/page.js"></script>
		<script src="<%=basePath%>/public/js/jquery.cookie.js"></script>
		<script src="<%=basePath%>/js/main.js"></script>
	</head>

	<body>
		<main class="index-main-body" style="min-width: auto;">
			<div class="index-header">
				<h1 class="logo">BLOG</h1>
				<h2 class="subtitle">发现更大的世界</h2>
			</div>
			<div>
				<div class="index-tab-navs">
					<div class="navs-slider">
						<a href="javascript:void(0)" id="signup" class="">注册</a>
						<a href="javascript:void(0)" id="signin" class="active">登录</a>
						<span class="navs-slider-bar"></span>
					</div>
				</div>
				<!--//login-->
				<div class="login-wrap">
					<div class="view-signin">
						<input type="text" aria-label="手机号或邮箱" placeholder="手机号或邮箱" required="" id="psdMobile">
						<input type="password" aria-label="密码" placeholder="密码" required="" id="password">
						<a><button class="sign-button" type="submit" id="psdLogin">登录</button></a>
						<div class="clearfix">
							<a class="login-Toggle" href="javascript:void(0)">手机验证码登录</a>
						</div>
					</div>
				    <!--codeLogin-->
					<div class="view-forgetPwd" style="display: none;">
						<input type="text" class="account" aria-label="手机号" placeholder="手机号">
						<div class="code">
							<input type="text" aria-label="验证码" placeholder="验证码">
							<input class="send" value="发送验证码">
						</div>
						<a href="index.jsp"><button class="sign-button" type="submit">登录</button></a>
						<div class="clearfix">
							<a class="login-Toggle" href="javascript:void(0)" id="mobileLogin">密码登录</a>
						</div>
					</div>
				</div>
				<!--//register-->
				<div class="view-signup" style="display: none;">
					<input type="text" aria-label="姓名" placeholder="姓名">
					<input type="text" class="account" aria-label="手机号" placeholder="手机号">
					<input type="password" aria-label="密码" placeholder="密码（不少于 6 位）">
					<div class="code">
						<input type="text" aria-label="验证码" placeholder="验证码">
						<input class="send" value="发送验证码">
					</div>
					<button class="sign-button" type="submit">进入博客</button>
				</div>
			</div>
		</main>
		<footer class="login-footer">
			<p>©2017 Design by Gao</p>
		</footer>
		<canvas id="canvas" style="height: 1000px;"></canvas>
		<script>
            $("#psdLogin").click(function () {
//                var reg = /^1[34578]\d{9}$/;
//                var mobile=$("#psdMobile").val();
//                if (mobile == "" || mobile == "null") {
//                    alert("手机号不能为空!");
//                }
//                else if (!reg.test(mobile)) {
//                    alert("请输入正确的手机号码!");
//                }
                $.ajax({
                    type:"post",
                    url:"users?action=login",
                    dataType:"json",
                    data:{
                        "userName":$("#psdMobile").val(),
                        "password":$("#password").val()
                    },
                    success:function(msgString){
                        alert("into fun" + msgString.msg)
                        if(msgString.code == '200'){
                            $.cookie('userName',msgString.data.NickName);
                            $.cookie('mobile',msgString.data.mobile);
                            console.log(msgString.data.userName+','+msgString.data.password);
                            window.location.href='<%=basePath%>/view/index.jsp';
                        }
                        else {
                            console.log(msgString.msg);
                        }
                    },
                    error:function (msgString) {
                        console.log('error:'+msgString.code);
                    }
                });
            })
		</script>
		<script>
			var bodyHeight = $(window).height();
			$('canvas').height(bodyHeight);
			$("#signin").click(function() {
				$(".navs-slider a").removeClass('active');
				$(this).addClass('active');
				$('.navs-slider-bar').css('left', '4.5rem');
				$('.view-signup').css('display', 'none');
				$('.login-wrap').css('display', 'block');
			})
			$("#signup").click(function() {
				$(".navs-slider a").removeClass('active');
				$(this).addClass('active');
				$('.navs-slider-bar').css('left', '0');
				$('.login-wrap').css('display', 'none');
				$('.view-signup').css('display', 'block');
			})
			//定义画布宽高和生成点的个数
			var WIDTH = window.innerWidth,
				HEIGHT = window.innerHeight,
				POINT = 35;

			var canvas = document.getElementById('canvas');
			canvas.width = WIDTH,
				canvas.height = HEIGHT;
			var context = canvas.getContext('2d');
			context.strokeStyle = 'rgba(0,0,0,0.02)',
				context.strokeWidth = 1,
				context.fillStyle = 'rgba(0,0,0,0.05)';
			var circleArr = [];

			//线条：开始xy坐标，结束xy坐标，线条透明度
			function Line(x, y, _x, _y, o) {
				this.beginX = x,
					this.beginY = y,
					this.closeX = _x,
					this.closeY = _y,
					this.o = o;
			}
			//点：圆心xy坐标，半径，每帧移动xy的距离
			function Circle(x, y, r, moveX, moveY) {
				this.x = x,
					this.y = y,
					this.r = r,
					this.moveX = moveX,
					this.moveY = moveY;
			}
			//生成max和min之间的随机数
			function num(max, _min) {
				var min = arguments[1] || 0;
				return Math.floor(Math.random() * (max - min + 1) + min);
			}
			// 绘制原点
			function drawCricle(cxt, x, y, r, moveX, moveY) {
				var circle = new Circle(x, y, r, moveX, moveY)
				cxt.beginPath()
				cxt.arc(circle.x, circle.y, circle.r, 0, 2 * Math.PI)
				cxt.closePath()
				cxt.fill();
				return circle;
			}
			//绘制线条
			function drawLine(cxt, x, y, _x, _y, o) {
				var line = new Line(x, y, _x, _y, o)
				cxt.beginPath()
				cxt.strokeStyle = 'rgba(0,0,0,' + o + ')'
				cxt.moveTo(line.beginX, line.beginY)
				cxt.lineTo(line.closeX, line.closeY)
				cxt.closePath()
				cxt.stroke();

			}
			//初始化生成原点
			function init() {
				circleArr = [];
				for(var i = 0; i < POINT; i++) {
					circleArr.push(drawCricle(context, num(WIDTH), num(HEIGHT), num(15, 2), num(10, -10) / 40, num(10, -10) / 40));
				}
				draw();
			}

			//每帧绘制
			function draw() {
				context.clearRect(0, 0, canvas.width, canvas.height);
				for(var i = 0; i < POINT; i++) {
					drawCricle(context, circleArr[i].x, circleArr[i].y, circleArr[i].r);
				}
				for(var i = 0; i < POINT; i++) {
					for(var j = 0; j < POINT; j++) {
						if(i + j < POINT) {
							var A = Math.abs(circleArr[i + j].x - circleArr[i].x),
								B = Math.abs(circleArr[i + j].y - circleArr[i].y);
							var lineLength = Math.sqrt(A * A + B * B);
							var C = 1 / lineLength * 7 - 0.009;
							var lineOpacity = C > 0.03 ? 0.03 : C;
							if(lineOpacity > 0) {
								drawLine(context, circleArr[i].x, circleArr[i].y, circleArr[i + j].x, circleArr[i + j].y, lineOpacity);
							}
						}
					}
				}
			}

			//调用执行
			window.onload = function() {
				init();
				setInterval(function() {
					for(var i = 0; i < POINT; i++) {
						var cir = circleArr[i];
						cir.x += cir.moveX;
						cir.y += cir.moveY;
						if(cir.x > WIDTH) cir.x = 0;
						else if(cir.x < 0) cir.x = WIDTH;
						if(cir.y > HEIGHT) cir.y = 0;
						else if(cir.y < 0) cir.y = HEIGHT;

					}
					draw();
				}, 16);
			}
		</script>
	</body>

</html>