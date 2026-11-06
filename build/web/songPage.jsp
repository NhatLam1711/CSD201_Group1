<%-- 
    Document   : songPage
    Created on : Nov 4, 2026, 12:50:07 PM
    Author     : Tung Nguyen
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Tìm bài hát - Music Player</title>
<style>
  :root{
    --bg:#0b0b14; --card:#14141f; --card2:#1a1a29; --line:#26263a; --text:#f2f2f8; --muted:#8b8ba7;
    --accent:#a855f7; --accent2:#ec4899;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{
    min-height:100vh; padding-bottom:110px;
    font-family:"Segoe UI",Roboto,Helvetica,Arial,sans-serif; color:var(--text);
    background:radial-gradient(700px 400px at 10% -5%, rgba(168,85,247,.2), transparent 60%), var(--bg);
  }
  header{
    position:sticky;top:0;z-index:10; display:flex;align-items:center;justify-content:space-between;gap:16px;
    padding:14px 32px; background:rgba(11,11,20,.85); backdrop-filter:blur(10px); border-bottom:1px solid var(--line);
  }
  .brand{display:flex;align-items:center;gap:10px;font-weight:700;font-size:18px}
  .brand .logo{width:34px;height:34px;border-radius:10px;display:grid;place-items:center;
    background:linear-gradient(135deg,var(--accent),var(--accent2))}
  nav{display:flex;gap:6px}
  nav a{padding:8px 16px;border-radius:999px;color:var(--muted);text-decoration:none;font-size:14px;transition:.2s}
  nav a:hover{color:var(--text)}
  nav a.active{background:var(--card2);color:var(--text)}
  .user{display:flex;align-items:center;gap:12px;font-size:14px;color:var(--muted)}
  .user button{background:none;border:1px solid var(--line);color:var(--text);padding:7px 14px;border-radius:999px;cursor:pointer;font-size:13px;transition:.2s}
  .user button:hover{border-color:var(--accent)}
  .user b{color:var(--text)}

  main{max-width:900px;margin:0 auto;padding:36px 24px}
  h1{font-size:28px;margin-bottom:6px}
  .sub{color:var(--muted);font-size:14px;margin-bottom:24px}

  .toolbar{display:flex;gap:12px;margin-bottom:20px;flex-wrap:wrap}
  .search{flex:1;min-width:240px;position:relative}
  .search span{position:absolute;left:14px;top:50%;transform:translateY(-50%);color:var(--muted)}
  .search input{
    width:100%;padding:14px 16px 14px 42px;border-radius:14px;font-size:15px;color:var(--text);
    background:var(--card);border:1px solid var(--line);outline:none;transition:.2s;
  }
  .search input:focus{border-color:var(--accent);box-shadow:0 0 0 3px rgba(168,85,247,.2)}
  .count{color:var(--muted);font-size:13px;margin-bottom:12px}

  .list{display:flex;flex-direction:column;gap:8px}
  .song{
    display:grid;grid-template-columns:52px 1fr auto 44px;align-items:center;gap:16px;
    padding:12px 16px;border-radius:14px;background:var(--card);border:1px solid transparent;transition:.2s;
  }
  .song:hover{background:var(--card2);border-color:var(--line)}
  .cover{width:52px;height:52px;border-radius:12px;display:grid;place-items:center;font-size:20px;color:#fff;
    background:linear-gradient(135deg,var(--accent),var(--accent2))}
  .info .title{font-weight:600;font-size:15px;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}
  .info .artist{color:var(--muted);font-size:13px;margin-top:3px}
  .dur{color:var(--muted);font-size:14px;font-variant-numeric:tabular-nums}
  .play{
    width:44px;height:44px;border-radius:50%;border:none;cursor:pointer;color:#fff;font-size:15px;
    background:linear-gradient(135deg,var(--accent),var(--accent2));transition:.2s;
    text-decoration:none;display:grid;place-items:center;
  }
  .play:hover{transform:scale(1.1)}
  .empty{text-align:center;padding:60px 0;color:var(--muted)}

  @media(max-width:640px){
    header{padding:12px 16px;flex-wrap:wrap}
    .song{grid-template-columns:44px 1fr 44px}
    .dur{display:none}
    .cover{width:44px;height:44px}
  }
</style>
</head>
<body>
<header>
  <div class="brand"><div class="logo">♪</div>Music Player</div>
  <nav>
    <a href="mainController?action=Song" class="active">Bài hát</a>
    <a href="mainController?action=History">Lịch sử</a>
  </nav>
  <div class="user">Xin chào, <b>${sessionScope.USER.fullname}</b>
    <a href="mainController?action=Logout"><button>Đăng xuất</button></a>
  </div>
</header>

<main>
  <h1>Tìm bài hát</h1>
  <p class="sub">Gõ tên bài hát để tìm. Nhấn nút phát để nghe và lưu vào lịch sử.</p>

  <div class="toolbar">
    <form action="showSongController" method="GET" class="search">
      <span>🔍</span>
      <input name="KEYWORD" type="text" placeholder="Tìm theo tên bài hát..."
             value="${KEYWORD}" autofocus>
    </form>
  </div>

  <c:if test="${SONGLIST != null}">
    <div class="count">
      <c:choose>
        <c:when test="${not empty KEYWORD}">
          Tìm thấy ${SONGLIST.size()} kết quả cho "${KEYWORD}"
        </c:when>
        <c:otherwise>
          Tất cả ${TOTALSONG} bài hát
        </c:otherwise>
      </c:choose>
    </div>
  </c:if>

  <div class="list">
    <c:choose>
      <c:when test="${SONGLIST != null && !SONGLIST.isEmpty()}">
          <c:forEach var="song" items="${requestScope.SONGLIST}">
          <div class="song">
            <div class="cover">♪</div>
            <div class="info">
              <div class="title">${song.title}</div>
              <div class="artist">${song.artist}</div>
            </div>
            <div class="dur">${song.formattedDuration}</div>
            <a class="play" href="showSongController?action=play&songId=${song.id}" title="Phát ${song.title}">▶</a>
          </div>
        </c:forEach>
      </c:when>
      <c:when test="${not empty KEYWORD}">
        <div class="empty">
          <p>Không tìm thấy bài hát nào với từ khóa "${KEYWORD}"</p>
        </div>
      </c:when>
      <c:otherwise>
        <div class="empty">
          <p>Chưa có bài hát nào</p>
        </div>
      </c:otherwise>
    </c:choose>
  </div>
</main>
</body>
</html>
