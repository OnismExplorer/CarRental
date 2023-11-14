<template>
  <div class="registration-container">
    <div class="cargo">
      <el-button type="primary" class="createBtn" >创建车辆</el-button>
      <ul>
        <li>
          <div class="list-item">
            <div id="car-picture">图片</div>
            <span id="CarName">奥迪-奥迪A4L 2018款 30周年年型</span>

            <div id="car-stores">
              库存:
              <div>11</div>
            </div>
            <div id="amount">
              价格：
              <div>10</div>
            </div>
            <el-button type="primary" class="editBtn" size="mini" plain>编辑</el-button>
            <el-button type="danger" class="deleBtn" size="mini" plain>删除</el-button>
          </div>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {};
</script>

<style scoped>
.cargo {
  position: relative;
  width: 80%;
  height: 500px;
  margin: 90px auto;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.14);
}
.createBtn {
  float: right;
  margin: 25px;
}
.editBtn{
    position: absolute;
    bottom: 5px;
    right: 30px;
}
.deleBtn{
    position: absolute;
    bottom: 40px;
    right: 30px;
}
.cargo ul {
  position: absolute;
  left: 0;
  top: 75px;
  width: 100%;
  list-style: none;
  padding-left: 0;
}

.list-item {
  position: relative;
  width: 100%;
  height: 80px;
  border-bottom: rgb(178, 177, 177) solid 1px;
}
.list-item:first-of-type {
  border-top: rgb(178, 177, 177) solid 1px;
}
#car-picture {
  display: inline-block;
  width: 12%;
  height: 100%;
  background-color: burlywood;
}
#CarName {
  position: absolute;
  left: 14%;
  top: 40%;
  font-size: 16px;
}
#car-stores {
  position: absolute;
  left: 50%;
  top: 40%;
}
#car-stores div {
  position: absolute;
  left: 106%;
  top: 0%;
  width: 100px;
  height: 20px;
}
#amount {
  position: absolute;
  right: 23%;
  top: 40%;
  color: black;
}
#amount div {
  position: absolute;
  right: -120%;
  bottom: -126%;
  width: 60px;
  height: 40px;
  color: black;
}

</style>
