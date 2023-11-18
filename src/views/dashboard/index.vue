<template>
  <div class="dashboard-container">
    <div class="option-list">
      <div class="col">
        品牌：
        <el-radio-group
          v-model="radio1"
          text-color="#ffffff"
          fill="orange"
          size="mini"
          style="margin-left: 20px"
          @change="selectedChange"
        >
          <el-radio-button
            v-for="(item, index) in colType.brand"
            :key="index"
            style="margin-left: 10px"
            :label="item"
          ></el-radio-button>
        </el-radio-group>
      </div>
      <div class="col">
        车系：
        <el-radio-group
          v-model="radio2"
          text-color="#ffffff"
          fill="orange"
          size="mini"
          style="margin-left: 20px"
          @change="selectedChange"
        >
          <el-radio-button
            v-for="(item, index) in colType.car_series"
            :key="index"
            style="margin-left: 10px"
            :label="item"
          ></el-radio-button>
        </el-radio-group>
      </div>
      <div class="col">
        日租金：
        <el-input-number
          v-model="radio3"
          :step="100"
          @change="selectedChange"
        ></el-input-number>
        以下
      </div>
      <div class="col order">
        排序：
        <el-radio-group
          v-model="radio4"
          text-color="#ffffff"
          fill="rgb(255, 94, 0)"
          size="mini"
          style="margin-left: 20px"
          @change="orderChange"
        >
          <el-radio-button
            v-for="(item, index) in order"
            :key="index"
            style="margin-left: 10px"
            :label="item"
          ></el-radio-button>
        </el-radio-group>
      </div>
      <div class="display-bottom">
        <CarInfo
          v-for="(item, index) in list"
          :key="index"
          :price="item.dailyRate"
          :imgUrl="item.avatar"
          :CarName="item.brand + '-' + item.model + '-' + item.illustrate"
          :id="item.id"
        ></CarInfo>

        <div class="block">
          <el-pagination
            layout="prev, pager, next"
            :page-size="8"
            :current-page="page"
            :page-count="pageCount"
            @current-change="changeCurrentPage"
            @next-click="changeSize(1)"
            @prev-click="changeSize(-1)"
          >
          </el-pagination>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import CarInfo from "./CarInfo.vue";
import { pageList } from "@/api/registration";
import { getAllData } from "@/api/dashboard";

export default {
  name: "Dashboard",
  components: { CarInfo },
  data() {
    return {
      radio1: "不限",
      radio2: "不限",
      radio3: 0,
      radio4: "价格升序",
      key: "",
      page: 1,
      pageSize: 8,
      pageCount: 0,
      list: [
        {
          id: "",
          brand: "",
          model: "",
          avatar: "",
          dailyRate: "",
          illustrate: "",
          pageSize: 6,
        },
      ],
      allList: [],
      pagelist: [],
      order: ["价格升序", "价格降序"],
      colType: {
        brand: ["不限"],
        car_series: ["不限"],
      },
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    changeStyles(i) {
      this.$refs.brand[i].style.color = "white";
    },
    fetchData() {
      pageList({
        key: this.key,
        pageNum: this.page,
        pageSize: this.pageSize,
      }).then((res) => {
        this.pageCount = Math.ceil(res.total / this.pageSize);
        this.list.shift();
        this.list = res.list;
        this.handlecolType();
        this.orderChange();
      });
    },
    changeCurrentPage() {
      let startItem = (this.page - 1) * this.pageSize;
      let endItem = this.page * this.pageSize;
      this.pageList = this.list;
    },
    changeSize(num) {
      this.page = this.page + num;
      // if (this.page == this.pageCount) {
      //   this.pageSize = this.total - this.page * this.pageSize;
      // } else this.pageSize = 6;
      this.fetchData();
    },
    handlecolType() {
      getAllData().then((res) => {
        this.allList = res;
        this.allList.forEach((item) => {
          if (this.colType.brand.indexOf(item.brand) == -1) {
            this.colType.brand.push(item.brand);
          }
          if (this.colType.car_series.indexOf(item.model) == -1) {
            this.colType.car_series.push(item.model);
          }
        });
      });
    },
    selectedChange() {
      if (this.radio1 == "不限" && this.radio2 == "不限") {
        this.list = this.allList;
      } else if (this.radio1 == "不限") {
        this.list = [];
        this.allList.forEach((item) => {
          if (item.model == this.radio2) {
            this.list.push(item);
          }
        });
      } else if (this.radio2 == "不限") {
        this.list = [];
        this.allList.forEach((item) => {
          if (item.brand == this.radio1) {
            this.list.push(item);
          }
        });
      } else {
        this.list = [];
        this.allList.forEach((item) => {
          if (item.model == this.radio2 && item.brand == this.radio1) {
            this.list.push(item);
          }
        });
      }
      if (this.radio3 != 0) {
        let tem = this.list;
        this.list = [];
        tem.forEach((item) => {
          if (item.dailyRate < this.radio3) {
            this.list.push(item);
          }
        });
      }
      this.orderChange();
      if (this.list.length == 0) {
        alert("没有满足条件的车辆，请重新选择");
      }
    },
    orderChange() {
      if (this.list.length != 0) {
        for (let i = this.list.length - 1; i >= 0; i--) {
          for (let j = 0; j < i; j++) {
            if (this.list[j].dailyRate > this.list[j + 1].dailyRate) {
              let tem = this.list[j + 1];
              this.list[j + 1] = this.list[j];
              this.list[j] = tem;
            }
          }
        }
        if (this.radio4 != "价格升序") {
          this.list.reverse();
        } else {
          let m = this.list.reverse();
          this.list=m.reverse()
        }
      }
    },
  },
};
</script>

<style scoped>
.dashboard-container {
  width: 100%;
  height: 1000px;
}
.option-list {
  width: 1200px;
  height: 204px;
  margin: 10px auto;
  padding: 0 10px;
  background-color: rgb(247, 244, 244);
}
.col {
  height: 51px;
  margin: 0;
  padding: 0;
  border-bottom: rgb(178, 177, 177) solid 1px;
  line-height: 50px;
  font-size: 14px;
  color: gray;
}
.order {
  border-bottom: solid 1px transparent;
}
.display-bottom {
  position: relative;
  margin-top: 30px;
  margin-left: 0px;
  width: 1200px;
  height: 760px;
}
.block {
  position: absolute;
  bottom: 0;
  left: 40%;
}
</style>
