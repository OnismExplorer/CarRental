<template>
  <div class="registration-container">
    <div class="cargo">
      <el-button type="primary" class="createBtn" @click="toCreate"
        >创建车辆</el-button
      >
      <ul>
        <li>
          <div class="list-item" v-for="(item, index) in pageList" :key="index">
            <div
              id="car-picture"
              :style="{ backgroundImage: 'url(' + item.avatar + ')' }"
            ></div>
            <span id="CarName">{{
              item.brand + "-" + item.model + "-" + item.illustrate
            }}</span>

            <div id="amount">
              价格：
              <div>{{ item.dailyRate }}元</div>
            </div>
            <el-button
              type="primary"
              class="editBtn"
              size="mini"
              plain
              @click="toUpgrade(item.id)"
              >编辑</el-button
            >
            <el-button
              type="danger"
              class="deleBtn"
              size="mini"
              plain
              @click="handleDele(item.id)"
              >删除</el-button
            >
          </div>
        </li>
      </ul>
      <div class="block">
        <el-pagination
          layout="prev, pager, next"
          :page-size="6"
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
</template>

<script>
import { pageList, removeById } from "@/api/registration";

export default {
  data() {
    return {
      keyWords: "",
      page: 1,
      pageSize: 6,
      departmentId: null,
      total: 0,
      pageCount: 0,
      list: [
        {
          id: "",
          brand: "",
          model: "",
          avatar: "",
          dailyRate: "",
          illustrate: "",
        },
      ],
      pageList: [],
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    fetchData() {
      pageList({
        key: this.keyWords,
        pageNum: this.page,
        pageSize: this.pageSize,
      }).then((res) => {
        this.total = res.total;
        this.pageCount = Math.ceil(this.total / this.pageSize);
        this.list.shift();
        this.list = res.list;
        this.changeCurrentPage();
      });
    },
    handleDele(id) {
      this.$confirm("此操作将永久删除该车辆, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          return removeById(id);
        })
        .then((res) => {
          this.fetchData();
          this.$message.success(res.message)
        });
    },
    toCreate() {
      this.$router.push({ path: "/admin/add" });
    },
    toUpgrade(id) {
      this.$router.push({ name: "upgrade", params: { id } });
    },
    changeCurrentPage() {
      let startItem = (this.page - 1) * this.pageSize;
      let endItem = this.page * this.pageSize;
      this.pageList = this.list;
    },
    // 当总页数只有1的时候会出问题
    changeSize(num) {
      this.page = this.page + num;
      // if (this.page == this.pageCount) {
      //   this.pageSize = this.total - this.page * this.pageSize;
      // } else this.pageSize = 6;
      this.fetchData();
    },
  },
};
</script>

<style scoped>
.cargo {
  position: relative;
  width: 80%;
  height: 600px;
  margin: 90px auto;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.14);
}
.createBtn {
  float: right;
  margin: 25px;
}
.editBtn {
  position: absolute;
  bottom: 5px;
  right: 30px;
}
.deleBtn {
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
  border-top: rgb(178, 177, 177) solid 1px;
}

#car-picture {
  display: inline-block;
  width: 12%;
  height: 100%;
  /* background-color: burlywood; */
  background: url("https://fingerbed.oss-cn-chengdu.aliyuncs.com/CSDN/202311031104822.png")
    no-repeat center;
  background-size: 80px 80px;
  transition: background-size 3s;
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
.block {
  position: absolute;
  bottom: 0%;
  left: 38%;
}
</style>
