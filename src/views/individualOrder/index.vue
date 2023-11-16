<template>
  <div class="order-container">
    <div class="order-list">
      <div class="list-item" v-for="(item, index) in list" :key="index">
        <el-button
          type="danger"
          icon="el-icon-close"
          plain
          class="cancel"
          @click="cancel(item.id)"
        ></el-button>
        <div
          id="car-picture"
          :style="{ backgroundImage: 'url(' + item.avatar + ')' }"
        >
          图片
        </div>
        <span id="CarName">{{
          item.brand + "-" + item.model + "-" + item.illustrate
        }}</span>

        <div id="car-stores">
          库存:
          <div>{{ item.available }}</div>
        </div>

        <div class="block">
          <span class="demonstration">租用日期</span>
          <el-date-picker
            v-model="item.day"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            @blur="changeDate(index,item.day)"
          >
          </el-date-picker>
        </div>

        <!-- <div id="number">
          租用数量
          
        </div> -->

        <div id="amount">
          价格：
          <div>{{ item.dailyRate }}</div>
        </div>
        <div id="vip-amount">
          会员价：
          <div>100</div>
        </div>
        <el-button
          type="primary"
          class="confirm"
          @click="confirm(item.id, item.start, item.end)"
          >确认</el-button
        >
      </div>
    </div>

    <bottom
      ><div class="bottom-tab">
        <div class="shop-img">图片</div>
        <span id="tips">
          (若超出规定时间换车,则每超出日期的日租金按正常租金的1.5倍支付!!!)</span
        >
        <div class="total-amount">
          总金额:
          <div>1000</div>
        </div>
        <div class="vip-total-amount">
          会员价:
          <div>10</div>
        </div>

        <el-button type="danger" id="pay">支付订单</el-button>
      </div></bottom
    >
  </div>
</template>

<script>
import { removeOrder, getOrderById, changeOrder } from "@/api/details";
import { getDataById } from "@/api/registration";

export default {
  data() {
    return {
      list: [
        {
          id: "",
          start: "",
          end: "",
          brand: "",
          model: "",
          dailyRate: "",
          avatar: "",
          available: "",
        },
      ],
      amount: 0,
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      // 需要获取用户uid
      getOrderById(uid).then((res) => {
        this.list = res;
      });
      this.list.forEach((obj) => {
        obj.day = '';
        getDataById(obj.id).then((res) => {
          obj = { ...res };
        });
      });
    },
    cancel(id) {
      this.$confirm("此操作将永久删除该文件, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          return removeOrder(id);
        })
        .then((res) => {
          this.fetchData();
          this.$message.success(res.message);
        });
      this.fetchData();
    },
    confirm(id, start, end) {
      changeOrder({ id, start, end }).then((res) => {
        this.$message({
          type: "success",
          message: res.message,
        });
      });
      this.fetchData();
    },
    changeDate(index,day) {
      this.list[index].start = day[0];
      this.list[index].end = day[1];
    },
  },
};
</script>

<style scoped>
.order-list {
  width: 100%;
}
.list-item {
  position: relative;
  width: 100%;
  height: 150px;
  border-bottom: rgb(178, 177, 177) solid 1px;
}
#car-picture {
  display: inline-block;
  width: 16%;
  height: 100%;
  background: url("https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031104822.png")
    no-repeat center;
  background-size: 150px 150px;
  transition: background-size 3s;
}
#CarName {
  position: absolute;
  left: 18%;
  top: 10%;
  font-size: 22px;
}
#car-stores {
  position: absolute;
  left: 18%;
  top: 40%;
  color: gray;
}
#car-stores div {
  position: absolute;
  left: 106%;
  top: 0%;
  width: 100px;
  height: 20px;
}

.block {
  position: absolute;
  left: 18%;
  bottom: 4%;
}
.demonstration {
  margin-right: 15px;
}
#number {
  position: absolute;
  left: 52%;
  bottom: 11%;
}
.num {
  position: absolute;
  left: 128%;
  bottom: -18%;
}
.cancel {
  position: absolute;
  right: 0%;
  top: 1%;
}
#amount {
  position: absolute;
  right: 25%;
  bottom: 7%;
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
#vip-amount {
  position: absolute;
  right: 17%;
  bottom: 7%;
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
.confirm {
  position: absolute;
  right: 10px;
  bottom: 10px;
}
bottom {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 15%;
  border: rgb(178, 177, 177) solid 1px;
}
.bottom-tab {
  position: relative;
  width: 100%;
  height: 100%;
}
.shop-img {
  position: absolute;
  left: 0;
  top: 0;
  width: 24%;
  height: 100%;
  background-color: lightcoral;
}
#pay {
  position: absolute;
  right: 12px;
  bottom: 8px;
}

.total-amount {
  position: absolute;
  left: 27%;
  bottom: 18px;
  color: black;
  font-weight: 700;
}
.total-amount div {
  position: absolute;
  left: 104%;
  bottom: -3px;
  width: 60px;
  height: 40px;
  color: black;
  line-height: 55px;
  font-weight: 700;
  font-size: 20px;
  text-decoration: line-through;
  text-decoration-color: rgb(217, 68, 68);
}
.vip-total-amount {
  position: absolute;
  left: 34%;
  bottom: 20px;
  color: rgb(217, 68, 68);
  font-weight: 700;
}
.vip-total-amount div {
  position: absolute;
  left: 100%;
  bottom: -8px;
  font-size: 40px;
  font-weight: normal;
}
#tips {
  position: absolute;
  left: 59%;
  bottom: 19%;
  color: rgb(114, 113, 113);
}
</style>
