<template>
    <div class="user-container">
    <div class="userinfo">
      <el-avatar id="avatar" :size="95"> user </el-avatar>
      <!-- 昵称可以再优化位置 -->
      <div id="nickname">昵称</div>
      <ul class="userList">
        <li>用户名:</li>
        <li>密码: ********</li>
        <li>用户地址：</li>
        <li>邮箱地址:</li>
        <li>用户类型：</li>
      </ul>
    </div>
    <!-- 后期优化滚动条 -->
    <div class="orderinfo">
      <div class="list-item">
        <div id="car-picture">图片</div>
        <span id="CarName">奥迪-奥迪A4L 2018款 30周年年型</span>

        <div class="block">
          还车日期:
          <div>yy-mm--dd</div>
        </div>

        <div id="number">
          租用数量:
          <div>XXX</div>
        </div>

        <div id="amount">
          价格：
          <div>10</div>
        </div>

        <div class="unpaid">
          待支付:
          <div>--</div>
        </div>
        
      </div>
    </div>
  </div>
</template>

<script>
export default {
    
}
</script>

<style scoped>
.user-container {
  width: 1200px;
  margin: auto;
  margin-top: 20px;
}
#avatar {
  position: absolute;
  left: 36px;
  top: 42px;
}
#nickname {
  position: absolute;
  left: 232px;
  top: 84px;
}
.userList {
  position: absolute;
  left: 0;
  top: 37%;
  width: 100%;
  padding: 0;
  list-style: none;
}
.userList li {
  width: 100%;
  height: 50px;
  line-height: 50px;
  text-indent: 2em;
  border-bottom: white solid 1px;
  background-color: #68b1fa;
  color: white;
}
.userList li:last-of-type {
  border-bottom: none;
}
.userinfo {
  display: inline-block;
  position: relative;
  width: 30%;
  height: 420px;
  margin-right: 20px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.14);
}
.orderinfo {
  display: inline-block;
  float: right;
  width: 68%;
  height: 600px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.1);
}

.list-item {
  position: relative;
  float: left;
  width: 100%;
  height: 100px;
  border-bottom: rgb(178, 177, 177) solid 1px;
}
#car-picture {
  display: inline-block;
  width: 18%;
  height: 100%;
  background-color: burlywood;
}
#CarName {
  position: absolute;
  left: 22%;
  top: 10%;
  font-size: 16px;
}
.block {
  position: absolute;
  left: 22%;
  bottom: 7%;
  color: gray;
  font-size: 14px;
}
.block div {
  position: absolute;
  left: 117%;
  bottom: 10%;
  width: 70px;
  height: 14px;
}
#number {
  position: absolute;
  left: 45%;
  bottom: 7%;
  font-size: 14px;
  color: gray;
}
#number div {
  position: absolute;
  left: 115%;
  bottom: 10%;
  width: 55px;
  height: 14px;
}
#amount {
  position: absolute;
  right: 32%;
  bottom: 7%;
  color: gray;
  font-size: 14px;
}
#amount div {
  position: absolute;
  right: -123%;
  bottom: 10%;
  width: 55px;
  height: 14px;
}
.unpaid {
  position: absolute;
  right: 17%;
  bottom: 7%;
  color: rgb(217, 68, 68);
}
.unpaid div {
  position: absolute;
  right: -123%;
  bottom: 10%;
  width: 55px;
  height: 16px;
}

</style>
