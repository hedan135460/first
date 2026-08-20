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
  height:160px;       /* ←改这个数字调图片高度，数字越小图片越小 */
  object-fit:contain; /* contain=完整显示图片不裁剪；cover=填满裁剪 */
  background:#f4f4f4; /* contain模式下留白的背景色 */
  border-radius:8px;
}
.game-card h4{
  margin:12px 0 4px;
  font-size:18px;
}
</style>

<div class="game-card-container">

<!--2048卡片：点击图片跳转独立游戏页面-->
<div class="game-card" onclick="window.open('/games/2048/index.html','_blank')">
  <img src="/games/img/2048.png" alt="2048游戏">
  <h4>2048</h4>
  <p>点击开始游戏</p>
</div>

<!--贪吃蛇卡片-->
<div class="game-card" onclick="window.open('/games/snake/index.html','_blank')">
  <img src="/games/img/snake.png" alt="贪吃蛇">
  <h4>贪吃蛇</h4>
  <p>点击开始游戏</p>
</div>

<!--杀死国王卡片-->
<div class="game-card" onclick="window.open('/games/killking/index.html','_blank')">
  <img src="/games/img/killking.png" alt="杀死国王">
  <h4>杀死国王</h4>
  <p>点击开始游戏</p>
</div>

<!--win12卡片-->
<div class="game-card" onclick="window.open('/games/win12/index.html','_blank')">
  <img src="/games/img/win12.png" alt="杀死国王">
  <h4>win12</h4>
  <p>点击开始游戏</p>
</div>

</div>