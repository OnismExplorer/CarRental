<template>
  <div class="user-container">
    <div class="userinfo">
      <el-avatar
        id="avatar"
        :size="95"
        :style="{ backgroundImage: 'url(' + userList.avatar + ')' }"
      >
        user
      </el-avatar>
      <!-- 昵称可以再优化位置 -->
      <div id="nickname">{{ userList.nickname }}</div>
      <el-button
        type="primary"
        class="editBtn"
        size="mini"
        plain
        @click="toUpgrade(userList.id)"
        >编辑</el-button
      >
      <ul class="userList">
        <li>用户名:{{ userList.userName }}</li>
        <li>密码: ********</li>
        <li>用户地址：{{ userList.address }}</li>
        <li>邮箱地址:{{ userList.email }}</li>
        <li>用户类型：{{ userList.type }}</li>
      </ul>
    </div>
    <!-- 后期优化滚动条 -->
    <div class="orderinfo">
      <div class="list-item" v-for="(item, index) in carList" :key="index">
        <div
          id="car-picture"
          :style="{ backgroundImage: 'url(' + item.avatar + ')' }"
        ></div>
        <span id="CarName">{{
          item.brand + "-" + item.model + "-" + item.illustrate
        }}</span>

        <div class="block">
          还车日期:
          <div>{{ item.end }}</div>
        </div>

        <div id="number">
          租用数量:
          <div>XXX</div>
        </div>

        <div id="amount">
          价格：
          <div>{{ item.dailyRate }}</div>
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
import { getUserById } from "@/api/user";
import { getDataById } from "@/api/registration";
import { getOrderById } from "@/api/individualOrder";

export default {
  data() {
    return {
      userList: [
        {
          id: "",
          userName: "",
          nickname: "",
          avatar: "",
          email: "",
          type: "",
        },
      ],
      carList: [
        {
          id: "",
          brand: "",
          model: "",
          license: "",
          type: 0,
          dailyRate: 0,
          illustrate: "",
          avatar: "",
          available: 0,
          inventory: 0,
          end: "",
        },
      ],
      list: [],
    };
  },
  created() {
    this.fetchData(this.$route.params.id);
  },
  methods: {
    fetchData(id) {
      getUserById(id)
        .then((res) => {
          this.userList = res;
          if (this.userList.type == 0) this.userList.type = "管理员";
          else if (this.userList.type == 1) this.userList.type = "vip会员";
          else this.userList.type = "普通用户";
        })
        .then(() => {
          getOrderById(this.userList.id).then((res) => {
            this.list = res;
            this.list.forEach((obj) => {
              getDataById(obj.vehicleId).then((res) => {
                let data = res;
                data.end = obj.end;
                this.carList.push(data);
                // obj = { ...res };
              });
            });
          });
        });
    },
    toUpgrade(id) {
      this.$router.push({ name: "upgradeUser", params: { id } });
    },
  },
};
</script>

<style scoped>
.editBtn {
  float: right;
  margin-top: 10px;
  margin-right: 10px;
}
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
  top: -179px;
  width: 30%;
  height: 420px;
  margin-right: 20px;
  background-color: rgb(255, 255, 255);
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.14);
}
.orderinfo {
  display: inline-block;
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
  background: url("https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031104822.png")
    no-repeat center;
  background-size: 150px 120px;
  transition: background-size 3s;
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
  overflow: hidden;
  position: absolute;
  left: 117%;
  bottom: 10%;
  width: 76px;
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
