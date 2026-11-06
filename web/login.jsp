<%-- 
    Document   : login
    Created on : Feb 24, 2026, 3:19:40 AM
    Author     : ThongNT2025
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Đăng nhập - Music Player</title>
<style>
  :root{
    --bg:#0b0b14; --card:#14141f; --line:#26263a; --text:#f2f2f8; --muted:#8b8ba7;
    --accent:#a855f7; --accent2:#ec4899; --danger:#f87171;
  }
  *{box-sizing:border-box;margin:0;padding:0}
  body{
    min-height:100vh; display:grid; place-items:center; padding:24px;
    font-family:"Segoe UI",Roboto,Helvetica,Arial,sans-serif; color:var(--text);
    background:
      radial-gradient(600px 400px at 15% 10%, rgba(168,85,247,.25), transparent 60%),
      radial-gradient(500px 400px at 90% 90%, rgba(236,72,153,.22), transparent 60%),
      var(--bg);
  }
  .card{
    width:100%; max-width:400px; padding:40px 36px; border-radius:20px;
    background:rgba(20,20,31,.85); border:1px solid var(--line);
    box-shadow:0 30px 80px rgba(0,0,0,.5); backdrop-filter:blur(8px);
  }
  .logo{
    width:56px;height:56px;border-radius:16px;margin:0 auto 18px;display:grid;place-items:center;
    background:linear-gradient(135deg,var(--accent),var(--accent2)); font-size:26px;
    box-shadow:0 10px 30px rgba(168,85,247,.45);
  }
  h1{font-size:24px;text-align:center;font-weight:700}
  .sub{text-align:center;color:var(--muted);font-size:14px;margin:6px 0 28px}
  label{display:block;font-size:13px;color:var(--muted);margin-bottom:6px}
  .field{margin-bottom:18px}
  .input-wrap{position:relative}
  input{
    width:100%; padding:13px 14px; border-radius:12px; font-size:15px; color:var(--text);
    background:#0e0e18; border:1px solid var(--line); outline:none; transition:.2s;
  }
  input:focus{border-color:var(--accent); box-shadow:0 0 0 3px rgba(168,85,247,.2)}
  .toggle{
    position:absolute;right:10px;top:50%;transform:translateY(-50%);
    background:none;border:none;color:var(--muted);cursor:pointer;font-size:13px;padding:4px 6px;
  }
  .toggle:hover{color:var(--text)}
  .error{
    display:none; margin-bottom:16px; padding:10px 12px; border-radius:10px; font-size:13px;
    color:var(--danger); background:rgba(248,113,113,.1); border:1px solid rgba(248,113,113,.3);
  }
  .error.show{display:block}
  button.primary{
    width:100%; padding:14px; border:none; border-radius:12px; cursor:pointer;
    font-size:15px; font-weight:600; color:#fff;
    background:linear-gradient(135deg,var(--accent),var(--accent2)); transition:.2s;
    box-shadow:0 10px 25px rgba(168,85,247,.35);
  }
  button.primary:hover{transform:translateY(-1px);filter:brightness(1.08)}
  button.primary:active{transform:translateY(0)}
  .hint{margin-top:20px;text-align:center;font-size:12px;color:var(--muted)}
</style>
</head>
<body>
  <main class="card">
    <div class="logo">♪</div>
    <h1>Music Player</h1>
    <p class="sub">Đăng nhập để quản lý playlist của bạn</p>

    <form id="loginForm" novalidate action="mainController" method="post">
      <div class="field">
        <label for="userId">User ID</label>
        <input id="userId" name="userID" type="text" placeholder="Nhập User ID" autocomplete="username" autofocus>
      </div>
      <div class="field">
        <label for="password">Mật khẩu</label>
        <div class="input-wrap">
          <input id="password" name="password" type="password" placeholder="Nhập mật khẩu" autocomplete="current-password">
          <!--<button type="button" class="toggle" id="toggle">Hiện</button>-->
        </div>
      </div>
      <div class="error" id="error"></div>
      <!--<button class="primary" type="submit">Đăng nhập</button>-->
      <input class="primary" type="submit" value="Login" name="action" style="margin-bottom: 10px"/>
      <input type="reset" value="Cancel" name="action"/>
    </form>
  </main>

<!--<script>
  // Đã đăng nhập thì vào thẳng trang bài hát
  if (localStorage.getItem("mp_user")) location.replace("songs.html");

  const form = document.getElementById("loginForm");
  const err = document.getElementById("error");
  const pw = document.getElementById("password");

  document.getElementById("toggle").addEventListener("click", e => {
    const show = pw.type === "password";
    pw.type = show ? "text" : "password";
    e.target.textContent = show ? "Ẩn" : "Hiện";
  });

  form.addEventListener("submit", e => {
    e.preventDefault();
    const id = document.getElementById("userId").value.trim();
    const p = pw.value;
    let msg = "";
    if (!id) msg = "Vui lòng nhập User ID.";
    else if (p.length < 4) msg = "Mật khẩu phải có ít nhất 4 ký tự.";

    if (msg) { err.textContent = msg; err.classList.add("show"); return; }
    // TODO: thay bằng gọi API tới backend Java để xác thực thật
    localStorage.setItem("mp_user", id);
    location.href = "songs.html";
  });
</script>-->
</body>
</html>
