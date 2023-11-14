<template>
  <div class="user-container">
    <div class="user-base">
      <el-table :data="tableData" style="width: 100%" height="250">
        <el-table-column fixed prop="avater" label="头像" width="150">
        </el-table-column>
        <el-table-column fixed prop="id" label="ID" width="150">
        </el-table-column>
        <el-table-column prop="name" label="用户名" width="120">
        </el-table-column>
        <el-table-column prop="nickname" label="昵称" width="120">
        </el-table-column>
        <el-table-column prop="address" label="地址" width="300">
        </el-table-column>
        <el-table-column prop="zip" label="邮编" width="120"> </el-table-column>
        <el-table-column label="用户状态" width="160">
          <el-switch
            v-model="tableData.user_mode"
            active-color="#13ce66"
            inactive-color="#ff4949"
          >
          </el-switch>
        </el-table-column>
        <el-table-column fixed="right" label="操作" width="130">
          <el-button type="primary" size="mini" plain>查看</el-button>
        </el-table-column>
      </el-table>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      tableData: [
        {
          user_mode: true,
          avater: "",
          id: "2016",
          name: "王小虎",
          nickname: "上海",
          city: "普陀区",
          address: "上海市普陀区金沙江路 1518 弄",
          zip: 200333,
        },
      ],
    };
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
</style>
