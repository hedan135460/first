---
title: 小游戏
---
<style>
.game-card-container{
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(260px,1fr));
  gap:24px;
  margin-top:30px;
}
.game-card{
  border:1px solid #e5e7eb;
  border-radius:16px;
  padding:16px;
  text-align:center;
  cursor:pointer;
  transition: 0.2s;
}
.game-card:hover{
  box-shadow: 0 4px 12px rgba(0,0,0,0.08);
}
.game-card img{
  width:100%;
  height:160px;
  object-fit:contain;
  background:#f4f4f4;
  border-radius:8px;
}
.game-card h4{
  margin:12px 0 4px;
  font-size:18px;
}
</style>
<div class="game-card-container">
<div class="game-card" onclick="window.open('/games/2048/index.html','_blank')">
  <img src="/games/img/2048.png" alt="2048游戏">
  <h4>2048</h4>
  <p>点击开始游戏</p>
</div>
<div class="game-card" onclick="window.open('/games/snake/index.html','_blank')">
  <img src="/games/img/snake.png" alt="贪吃蛇">
  <h4>贪吃蛇</h4>
  <p>点击开始游戏</p>
</div>

<div class="game-card" onclick="window.open('/games/killking/index.html','_blank')">
  <img src="/games/img/killking.png" alt="杀死国王">
  <h4>杀死国王</h4>
  <p>点击开始游戏</p>
</div>

<!-- win12卡片，使用你hlleo独立仓库外链 -->
<div class="game-card" onclick="window.open('https://hlleo.pages.dev/win12/boot.html','_blank')">
  <img src="/games/img/win12.png" alt="win12‑online">
  <h4>win12‑online</h4>
  <p>点击开始游戏</p>
</div>

<div class="game-card" onclick="window.open('/games/pvd/index.html','_blank')">
  <img src="/games/img/pvd.png" alt="">
  <h4></h4>
  <p>点击开始游戏</p>
</div>

</div>