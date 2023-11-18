<template>
  <div class="user-container">
    <div class="user-base">
      <el-button type="primary" class="createBtn" @click="toCreate"
        >新增用户</el-button
      >
      <el-table :data="tableData" style="width: 100%" height="400">
        <el-table-column fixed prop="avater" label="头像" width="150">
          <template slot-scope="scope">
            <el-avatar :src="scope.row.avater"></el-avatar>
          </template>
        </el-table-column>
        <el-table-column fixed prop="id" label="ID" width="150">
        </el-table-column>
        <el-table-column prop="username" label="用户名" width="120">
        </el-table-column>
        <el-table-column prop="nickname" label="昵称" width="120">
        </el-table-column>
        <el-table-column prop="address" label="地址" width="300">
        </el-table-column>
        <el-table-column prop="email" label="邮箱" width="120">
        </el-table-column>
        <el-table-column label="用户状态" width="160">
          <template slot-scope="scope">
            <el-switch
              v-model="scope.row.state"
              active-color="#13ce66"
              inactive-color="#ff4949"
            >
            </el-switch>
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="130">
          <template slot-scope="scope">
            <el-button
              type="primary"
              size="mini"
              plain
              @click="toInfo(scope.row)"
              >查看</el-button
            >
            <el-button
              type="danger"
              class="deleBtn"
              size="mini"
              plain
              @click="handleDele(scope.row)"
              >删除</el-button
            >
          </template>
        </el-table-column>
      </el-table>
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
import { getUserData, removeById } from "@/api/user";

export default {
  data() {
    return {
      key: "",
      page: 1,
      pageSize: 4,
      pageCount: 0,
      tableData: [
        {
          avater: "",
          id: "2016",
          username: "王小虎",
          nickname: "上海",
          type: 0,
          address: "上海市普陀区金沙江路 1518 弄",
          email: 200333,
          state:true
        },
      ],
    };
  },
  created() {
    this.fetchData();
  },
  methods: {
    toInfo(row) {
      this.$router.push({ name: "usersInfo", params: { id: row.id } });
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
    fetchData() {
      getUserData({
        key: this.key,
        pageNum: this.page,
        pageSize: this.pageSize,
      }).then((res) => {
        this.pageCount = Math.ceil(res.total / this.pageSize);
        this.tableData.shift();
        this.tableData = res.list;
      });
    },
    handleDele(row) {
      let id = row.id;
      this.$confirm("此操作将永久删除该用户, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          return removeById(id);
        })
        .then((res) => {
          this.fetchData();
          this.$message.success(res.message);
        });
    },
    toCreate() {
      this.$router.push({ name: "adduser" });
    },
  },
};
</script>

<style scoped>
.user-base {
  position: relative;
  width: 95%;
  margin: 90px auto;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.32), 0 0 6px rgba(0, 0, 0, 0.14);
}
.user-base ul {
  position: absolute;
  left: 0;
  top: 0px;
  width: 100%;
  padding-left: 0;
  margin: 0;
  list-style: none;
}
.block {
  position: absolute;
  bottom: 0;
  left: 45%;
}
.deleBtn {
  margin-left: 0;
  margin-top: 5px;
}
.createBtn {
  float: right;
  margin-right: 65px;
  margin-top: 10px;
}
</style>
