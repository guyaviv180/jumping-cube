<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="game.aspx.cs" Inherits="jumping_cube.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div style="display:none">
        <img id="wood" width="50" height="50" src="wood.jpg" />
    </div>
    <div style="display:none">
        <img id="gadi_kapsanoni" width="50" height="50" src="gadi_kapsanoni.PNG" />
    </div>
    <div style="display:none">
        <img id="zviki" width="50" height="50" src="zviki.PNG" />
    </div>
    <script src="graphics.js"></script>

    <button id="1" type="button" onclick="game(wood)"><img src="wood.jpg" height="50" width="50" /></button> 
    <button id="2" type="button" onclick="game(zviki)"><img src="zviki.PNG" height="50" width="50" /></button> <br />

    <canvas id="myCanvas" width="600" height="300" style="background-color:lightblue"></canvas>

    <script>


        function game(image) {
            var image = image;
            var cubeWidth = 50;
            var cubeHeight = 50;
            var cubeX = 100;
            var cubeY = document.getElementById("myCanvas").height - cubeHeight;
            var score = 0;
            var obstacleSpeed = 10;
            var gameStart = false;
            var spaceKey = false;

            canvas = document.getElementById("myCanvas");
            context = canvas.getContext("2d");
            var fps = 30;
            countScore();
            createObstacle();
            setInterval(function () {
                moveCube();
                moveObstacle();
                draw();
            }, 1000 / fps)
            document.getElementById("1").disabled = true;
            document.getElementById("2").disabled = true;
            addEventListener("keydown", onKeyDown);
            addEventListener("keyup", onKeyUp);

            function moveCube() {
                if (spaceKey == true && cubeY == canvas.height - cubeHeight) {
                    for (var i = 0; i < 5; i++) {
                        setTimeout(function () { cubeY -= 12; }, 80)
                    }
                }
                gravity();
            }

            function onKeyDown(event) {
                var keyCode = event.keyCode;
                switch (keyCode) {
                    case 32:
                        spaceKey = true;
                        break;
                }
            }

            function onKeyUp(event) {
                var keyCode = event.keyCode;
                switch (keyCode) {
                    case 32:
                        spaceKey = false;
                        break;

                }
            }

            function gravity() {
                if (cubeY != canvas.height - cubeHeight) {
                    cubeY += 5;
                }
            }

            function countScore() {
                setInterval(function () { score += 1 }, 100)
            }

            function decideWhichObstacle() {
                var x = getRandomNumber(0, 1);
                if (x == 0) {
                    obstacleWidth = getRandomNumber(20, 35);
                    obstacleHeight = getRandomNumber(60, 100);
                }
                if (x == 1) {
                    obstacleWidth = getRandomNumber(35, 100);
                    obstacleHeight = getRandomNumber(20, 40);
                }
            }

            function createObstacle() {
                decideWhichObstacle()
                obstacleWidth;
                obstacleHeight;
                obstacleX = canvas.width - obstacleWidth;
                obstacleY = canvas.height - obstacleHeight;
            }

            function moveObstacle() {
                if (obstacleX + obstacleWidth < 0) {
                    createObstacle();
                    obstacleSpeed += 0.5
                }
                obstacleX -= obstacleSpeed;
                if ((cubeX + cubeWidth) >= obstacleX && cubeX <= (obstacleX + obstacleWidth) && (cubeY + cubeHeight) >= obstacleY && cubeY <= (obstacleY + obstacleHeight)) {
                    stopGame();
                }
            }

            function stopGame() {
                alert("you lost, your score was: " + score);
                cubeY = canvas.height - cubeHeight;
                obstacleX = canvas.width - obstacleWidth;
                obstacleY = canvas.height - obstacleHeight;
                obstacleSpeed = 10;
                score = 0;
                spaceKey = false;

            }

            function drawPlayer() {
                //var image = document.getElementById("zviki");
                context.drawImage(image, cubeX, cubeY, 50, 50);
            }

            function draw() {
                drawRectangle(0, 0, canvas.width, canvas.height, "lightblue");
                drawText(20, 40, "20px arial", "white", score);
                drawPlayer();
                drawRectangle(obstacleX, obstacleY, obstacleWidth, obstacleHeight)
            }

           

           
        }
        
    </script>
</asp:Content>
