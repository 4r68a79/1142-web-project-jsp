<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="zh-TW">
    <head>
        <meta charset="utf-8" />
        <title>JOURNEY － 台灣旅遊景點導覽</title>
        <link rel="stylesheet" href="style.css" type="text/css" />
        <script type="text/javascript" src="jquery-1.10.2.min.js"></script>
        <script type="text/javascript">
            $(function(){
                // 🪄 核心魔法：動態載入共用 layout.html
                $("#shared-layout").load("layout.html", function() {
                    
                    // 1. 自動把選單搬進 #wrapper 肚子裡
                    $("#nav").prependTo("#wrapper");

                    // 2. 隱藏所有子選單
                    $("ul.subs").hide();
                    
                    // 3. 讀取並展開當前被記憶的選單狀態
                    var menuId = sessionStorage.getItem("openMenu");
                    if (menuId) {
                        $("#" + menuId).next("ul.subs").show();
                        $("#" + menuId).addClass("open");
                    }
                    
                    // 4. 綁定選單點擊展開/縮合事件
                    $("div.main").click(function(){
                        var $nextUl = $(this).next("ul");
                        var isVisible = $nextUl.is(":visible");
                        
                        $("ul.subs").slideUp();
                        $("div.main").removeClass("open");
                        
                        if(!isVisible){
                            $nextUl.slideDown();
                            $(this).addClass("open");
                            var menuId = $(this).attr("id");
                            sessionStorage.setItem("openMenu", menuId);
                        } else {
                            sessionStorage.removeItem("openMenu");
                        }
                    });

                    // 5. 綁定滑鼠懸停效果
                    $("div.main").mouseover(function () {
                        $(this).addClass("rollover");
                    }).mouseout(function(){
                        $(this).removeClass("rollover");
                    });
                });
            });
        </script>
        <script type="text/javascript">
        $(document).ready(function () {

            // 點圖片放大
            $("#contents img").click(function () {
                let imgSrc = $(this).attr("src");

                $("#overlay img").attr("src", imgSrc);
                $("body").css("overflow", "hidden");    //禁止背景滾動
                $("#overlay").fadeIn();
            });

            // 點背景關閉
            $("#overlay").click(function () {
                $(this).fadeOut();
                $("body").css("overflow", "auto");      // 恢復背景滾動
            });

        });
    </script>
    </head>
    <body>

        <div id="shared-layout"></div>

        <div id="wrapper" class="clearfix">
            
            <div id="contents">
                <%
					String pageParam = request.getParameter("page");
					// 超連結傳遞的參數
					String pageToInclude = "home.jsp";
					// 首頁為home.jsp

					if(pageParam != null){
						// 如果有傳遞參數
						pageToInclude = pageParam + ".jsp";
						// 載入對應的jsp檔案(同參數名稱)
					}
				%>

				<jsp:include page="<%= pageToInclude %>" />
				<!-- 將載入的jsp檔案整個放進來 -->

                <!-- 放大的圖片 -->
                <div id="overlay">
                    <img src="">
                </div>
            </div>

        </div>
        <div id="footer">
            <div id="footer-inner">Copyright © 2014 MdN Department All Right Reserved.</div>
        </div>
    </body>
</html>