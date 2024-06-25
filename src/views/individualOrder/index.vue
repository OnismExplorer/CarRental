<template>
  <div class="order-container">
    <div class="order-list">
      <div class="list-item" v-for="(item, index) in carList" :key="index">
        <el-button
          type="danger"
          icon="el-icon-close"
          plain
          class="cancel"
          @click="cancel(index)"
        ></el-button>
        <div
          id="car-picture"
          :style="{ backgroundImage: 'url(' + item.avatar + ')' }"
        ></div>
        <span id="CarName">{{
          item.brand + "-" + item.model + "-" + item.illustrate
        }}</span>

        <div id="car-stores">
          库存:
          <div>1</div>
        </div>
        <div class="block">
          <span class="demonstration">租用日期</span>
          <el-date-picker
            v-model="item.day"
            type="daterange"
            range-separator="至"
            start-placeholder="开始日期"
            end-placeholder="结束日期"
            value-format="yyyy-MM-dd HH:mm:ss"
            @blur="changeDate(index)"
          >
          </el-date-picker>
        </div>
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
          
          v-model="item.day"
          @click="confirm(index)"
          >确认</el-button
        >
      </div>
    </div>

    <div class="bottom">
      <div class="bottom-tab">
        <div class="shop-img">图片</div>
        <span id="tips">
          (若超出规定时间换车,则每超出日期的日租金按正常租金的1.5倍支付!!!)</span
        >
        <div class="total-amount">
          总金额:
          <div>{{ amount }}</div>
        </div>
        <div class="vip-total-amount">
          会员价:
          <div>400</div>
        </div>
        <el-button type="danger" id="pay">支付订单</el-button>
      </div>
    </div>
  </div>
</template>

<script>
import { getDataById } from "@/api/registration";
import { getOrderById, removeOrder, changeOrder } from "@/api/individualOrder";

export default {
  data() {
    return {
      list: [
        {
          id: "",
          uid: "",
          vehicleId: "",
          start: "",
          end: "",
          illustrate: "",
          returnTime: "",
          totalCost: 0,
          status: 0,
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
          available: 1,
          inventory: 0,
          day:""
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
      let uid = this.$store.getters.id;
      getOrderById(uid).then((res) => {
        this.list = res;
        this.carList.shift()
        this.list.forEach((obj) => {
          getDataById(obj.vehicleId)
            .then((res) => {
              let car = res;
              car.day = "";
              this.carList.push(car);
              // obj = { ...res };
            })
            .then(() => {
              this.calAmount();
            });
        });
      });
    },
    cancel(index) {
      console.log(this.list[index].id);
      this.$confirm("此操作将永久删除该订单, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          return removeOrder(this.list[index].id);
        })
        .then((res) => {
          this.fetchData();
          this.$message.success(res.message);
        });
    },
    confirm(index) {
      let id = this.list[index].id;
      let start = this.list[index].start;
      let end = this.list[index].end;
      changeOrder({ id, start, end }).then(() => {
        this.fetchData();
      }, err => {
        console.log(err);
      });
     
    },
    changeDate(index) {
      this.list[index].start = this.carList[index].day[0];
      this.list[index].end = this.carList[index].day[1];
    },
    calAmount() {
      this.carList.forEach((item) => {
        this.amount += item.dailyRate;
      });
    },
  },
};
</script>

<style scoped>
.order-container {
  height: 1000px;
}
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
  margin-left: -30px;
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
.bottom {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 15%;
  border: rgb(178, 177, 177) solid 1px;
  background-color: #fff;
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
  left: 37%;
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
