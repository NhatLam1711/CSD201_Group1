<%-- 
    Document   : history
    Created on : Nov 2, 2026, 7:05:20 PM
    Author     : kayng
--%>

<%@page import="ds.NodeStack"%>
<%@page import="dto.SongHistory"%>
<%@page import="ds.Stack"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Lịch sử nghe - Music Player</title>
        <style>
            :root{
                --bg:#0b0b14;
                --card:#14141f;
                --card2:#1a1a29;
                --line:#26263a;
                --text:#f2f2f8;
                --muted:#8b8ba7;
                --accent:#a855f7;
                --accent2:#ec4899;
                --danger:#f87171;
            }
            *{
                box-sizing:border-box;
                margin:0;
                padding:0
            }
            body{
                min-height:100vh;
                padding-bottom:60px;
                font-family:"Segoe UI",Roboto,Helvetica,Arial,sans-serif;
                color:var(--text);
                background:radial-gradient(700px 400px at 90% -5%, rgba(236,72,153,.18), transparent 60%), var(--bg);
            }
            header{
                position:sticky;
                top:0;
                z-index:10;
                display:flex;
                align-items:center;
                justify-content:space-between;
                gap:16px;
                padding:14px 32px;
                background:rgba(11,11,20,.85);
                backdrop-filter:blur(10px);
                border-bottom:1px solid var(--line);
            }
            .brand{
                display:flex;
                align-items:center;
                gap:10px;
                font-weight:700;
                font-size:18px
            }
            .brand .logo{
                width:34px;
                height:34px;
                border-radius:10px;
                display:grid;
                place-items:center;
                background:linear-gradient(135deg,var(--accent),var(--accent2))
            }
            nav{
                display:flex;
                gap:6px
            }
            nav a{
                padding:8px 16px;
                border-radius:999px;
                color:var(--muted);
                text-decoration:none;
                font-size:14px;
                transition:.2s
            }
            nav a:hover{
                color:var(--text)
            }
            nav a.active{
                background:var(--card2);
                color:var(--text)
            }
            .user{
                display:flex;
                align-items:center;
                gap:12px;
                font-size:14px;
                color:var(--muted)
            }
            .user button{
                background:none;
                border:1px solid var(--line);
                color:var(--text);
                padding:7px 14px;
                border-radius:999px;
                cursor:pointer;
                font-size:13px;
                transition:.2s
            }
            .user button:hover{
                border-color:var(--accent)
            }
            .user b{
                color:var(--text)
            }

            main{
                max-width:900px;
                margin:0 auto;
                padding:36px 24px
            }
            .head{
                display:flex;
                justify-content:space-between;
                align-items:flex-end;
                gap:16px;
                margin-bottom:24px;
                flex-wrap:wrap
            }
            h1{
                font-size:28px;
                margin-bottom:6px
            }
            .sub{
                color:var(--muted);
                font-size:14px
            }
            .clear{
                padding:10px 18px;
                border-radius:12px;
                border:1px solid rgba(248,113,113,.4);
                background:rgba(248,113,113,.08);
                color:var(--danger);
                cursor:pointer;
                font-size:14px;
                transition:.2s;
            }
            .clear:hover{
                background:rgba(248,113,113,.18)
            }

            .stats{
                display:grid;
                grid-template-columns:repeat(3,1fr);
                gap:12px;
                margin-bottom:28px
            }
            .stat{
                padding:16px 18px;
                border-radius:14px;
                background:var(--card);
                border:1px solid var(--line)
            }
            .stat .n{
                font-size:22px;
                font-weight:700
            }
            .stat .l{
                font-size:12px;
                color:var(--muted);
                margin-top:4px
            }

            .group{
                font-size:13px;
                color:var(--muted);
                margin:22px 0 10px;
                text-transform:uppercase;
                letter-spacing:.06em
            }
            .list{
                display:flex;
                flex-direction:column;
                gap:8px
            }
            .item{
                display:grid;
                grid-template-columns:52px 1fr auto auto;
                align-items:center;
                gap:16px;
                padding:12px 16px;
                border-radius:14px;
                background:var(--card);
                border:1px solid transparent;
                transition:.2s;
            }
            .item:hover{
                background:var(--card2);
                border-color:var(--line)
            }
            .item.top{
                border-color:var(--accent)
            }
            .cover{
                width:52px;
                height:52px;
                border-radius:12px;
                display:grid;
                place-items:center;
                font-size:20px;
                color:#fff
            }
            .info .title{
                font-weight:600;
                font-size:15px;
                display:flex;
                align-items:center;
                gap:8px;
                flex-wrap:wrap
            }
            .badge{
                font-size:11px;
                padding:2px 8px;
                border-radius:99px;
                background:linear-gradient(135deg,var(--accent),var(--accent2));
                color:#fff;
                font-weight:600
            }
            .info .artist{
                color:var(--muted);
                font-size:13px;
                margin-top:3px
            }
            .when{
                color:var(--muted);
                font-size:13px;
                text-align:right;
                font-variant-numeric:tabular-nums
            }
            .del{
                width:34px;
                height:34px;
                border-radius:50%;
                border:1px solid var(--line);
                background:none;
                color:var(--muted);
                cursor:pointer;
                font-size:14px;
                transition:.2s;
            }
            .del:hover{
                color:var(--danger);
                border-color:var(--danger)
            }

            .empty{
                text-align:center;
                padding:80px 0;
                color:var(--muted)
            }
            .empty .big{
                font-size:42px;
                margin-bottom:12px
            }
            .empty a{
                display:inline-block;
                margin-top:18px;
                padding:11px 22px;
                border-radius:12px;
                text-decoration:none;
                color:#fff;
                font-weight:600;
                background:linear-gradient(135deg,var(--accent),var(--accent2));
            }

            @media(max-width:640px){
                header{
                    padding:12px 16px;
                    flex-wrap:wrap
                }
                .stats{
                    grid-template-columns:1fr
                }
                .item{
                    grid-template-columns:44px 1fr auto
                }
                .when{
                    display:none
                }
                .cover{
                    width:44px;
                    height:44px
                }
            }
        </style>
    </head>
    <body>
        <header>
            <div class="brand"><div class="logo">♪</div>Music Player</div>
            <nav>
                <a href="mainController?action=Song">Bài hát</a>
                <a href="mainController?action=History" class="active">Lịch sử</a>
            </nav>
            <div class="user">Xin chào, <b id="who"></b><a href="mainController?action=Logout"><button id="logout">Đăng xuất</button></a></div>
        </header>

        <main>
            <div class="head">
                <div>
                    <h1>Lịch sử nghe nhạc</h1>
                    <p class="sub">Bài nghe gần nhất nằm trên cùng.</p>
                </div>
                <button class="clear" id="clear">Xóa toàn bộ</button>
            </div>

            <div class="stats">
                <div class="stat"><div class="n" id="sCount">0</div><div class="l">Lượt nghe</div></div>
                <div class="stat"><div class="n" id="sUnique">0</div><div class="l">Bài khác nhau</div></div>
                <div class="stat"><div class="n" id="sTime">0:00</div><div class="l">Tổng thời lượng</div></div>
            </div>

            <div class="list">
                <c:if test="${empty sessionScope.LISTHISTORY}">
                    <div class="empty">
                        <div class="big">🎧</div>
                        Chưa có lịch sử nghe nhạc.<br>
                        <a href="mainController?action=Song">Tìm bài hát để nghe</a>
                    </div>
                </c:if>

                <c:forEach var="h" items="${sessionScope.LISTHISTORY}" varStatus="st">
                    <c:set var="hue1" value="${(h.songId * 47) % 360}" />
                    <c:set var="hue2" value="${(hue1 + 50) % 360}" />
                    <div class="item ${st.first ? 'top' : ''}">
                        <div class="cover" style="background:linear-gradient(135deg,hsl(${hue1} 70% 55%),hsl(${hue2} 70% 40%))">♪</div>
                        <div class="info">
                            <div class="title">
                                ${h.title}
                                <c:if test="${st.first}"><span class="badge">TOP</span></c:if>
                                </div>
                                <div class="artist">${h.artist} · ${h.formattedDuration}</div>
                        </div>
                        <div class="when">
                            <div class="when">${h.formattedPlayedAt}</div>
                        </div>
                        <button class="play" data-id="${h.songId}" title="Phát">▶</button>
                    </div>
                </c:forEach>
            </div>
        </main>
    </body>
</html>

