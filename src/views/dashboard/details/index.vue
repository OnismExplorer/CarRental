<template>
  <div class="details-container">
    <div class="car-img">图片</div>
    <div class="info">
      <span id="CarName">奥迪-奥迪A4L 2018款 30周年年型</span>
      <div id="car-stores">
        库存:
        <div>11</div>
      </div>
      <div id="amount">
        价格：
        <div>10</div>
      </div>
      <div id="vip-amount">
        会员价：
        <div>100</div>
      </div>
      <el-button type="danger" id="pay">加入购物车</el-button>
      <div class="useless">
        <ul>
          <li>服务 <span>支持上门取车</span></li>
          <li>5.0分<span>暂无评价</span></li>
          <li>取车地点<span>明理楼c区1004处</span></li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.car-img {
  display: inline-block;
  float: left;
  width: 530px;
  height: 441px;
  margin: 81px 60px 0 37px;
  background-color: darkcyan;
}
.info {
  display: inline-block;
  position: relative;
  width: 590px;
  height: 441px;
  margin-top: 81px;
  /* background-color: wheat; */
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.14);
}
#CarName {
  position: absolute;
  left: 8%;
  top: 10%;
  font-size: 22px;
}
#car-stores {
  position: absolute;
  right: 18%;
  top: 11%;
  color: gray;
}
#car-stores div {
  position: absolute;
  left: 106%;
  top: 0%;
  width: 100px;
  height: 20px;
}
#vip-amount {
  position: absolute;
  left: 10%;
  top: 25%;
  color: rgb(217, 68, 68);
  font-weight: 700;
}
#vip-amount div {
  position: absolute;
  left: 54px;
  bottom: -8px;
  font-size: 40px;
  font-weight: normal;
}
#amount {
  position: absolute;
  right: 30%;
  top: 25%;
  color: black;
  font-weight: 700;
}
#amount div {
  position: absolute;
  right: -120%;
  bottom: -100%;
  width: 60px;
  height: 40px;
  color: black;
  font-size: 20px;
  font-weight: 700;
  text-decoration: line-through;
  text-decoration-color: rgb(217, 68, 68);
}
#pay {
  position: absolute;
  right: 12px;
  bottom: 8px;
}
.useless{
  position: relative;
  top: 150px;
  left: 0;
  width: 100%;
  height: 100px;
  padding-right: 45px;
}
.useless ul{
  list-style: none;
}
.useless ul li{
  height: 50px;
  width: 100%;
  border-bottom: rgb(190, 189, 189) solid 1px;
  line-height: 50px;
  font-weight: 700;
}
.useless ul li span{
  float: right;
  font-weight: normal;
  color:gray;
}
</style>
