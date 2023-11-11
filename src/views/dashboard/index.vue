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
      >
        <el-radio-button
          v-for="(item, index) in colTytpe.brand"
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
      >
        <el-radio-button
          v-for="(item, index) in colTytpe.car_series"
          :key="index"
          style="margin-left: 10px"
          :label="item"
        ></el-radio-button>
      </el-radio-group>
    </div>
    <div class="col">
      日租金：
      <el-radio-group
        v-model="radio3"
        text-color="#ffffff"
        fill="orange"
        size="mini"
        style="margin-left: 6px"
      >
        <el-radio-button
          v-for="(item, index) in colTytpe.price"
          :key="index"
          style="margin-left: 10px"
          :label="item"
        ></el-radio-button>
      </el-radio-group>
    </div>
    <div class="col order">
      排序：
      <el-radio-group
        v-model="radio4"
        text-color="#ffffff"
        fill="rgb(255, 94, 0)"
        size="mini"
        style="margin-left: 20px"
      >
        <el-radio-button
          v-for="(item, index) in colTytpe.order"
          :key="index"
          style="margin-left: 10px"
          :label="item"
        ></el-radio-button>
      </el-radio-group>
    </div>
    <CarInfo
      v-for="(item, index) in car"
      :key="index"
      :price="item.price"
      :CarName="item.CarName"
    ></CarInfo>
  </div>
  </div>
</template>

<script>
import CarInfo from './CarInfo.vue';

export default {
  name: 'Dashboard',
  components:{CarInfo},
  data() {
    return {
      radio1: "不限",
      radio2: "不限",
      radio3: "不限",
      radio4: "价格升序",
      colTytpe: {
        brand: ["不限", "大众", "奔驰"],
        car_series: ["不限", "宝马5系", "幻影"],
        price: ["不限", "3万以下", "3-5万", "5-8万"],
        order: ["价格升序", "价格降序"],
      },
      car: [
        { price: "200", CarName: "奥迪-奥迪A4L 2018款 30周年年型" },
        { price: "300", CarName: "奥迪-奥迪A4L 2018款 30周年年型" },
      ],
    };
  },
  methods: {
    changeStyles(i) {
      this.$refs.brand[i].style.color = "white";
    },
  },
}
</script>

<style scoped>
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
.order{
  border-bottom: solid 1px transparent;
}

</style>
