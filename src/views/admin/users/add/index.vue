<template>
  <div class="add-contain">
    <el-form ref="form" :model="form" label-width="80px" :rules="rules">
      <el-form-item label="用户头像">
        <el-upload
          class="avatar-uploader"
          action="https://jsonplaceholder.typicode.com/posts/"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="form.avater" :src="form.avater" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
      </el-form-item>
      <el-form-item label="用户名" prop="userName">
        <el-input v-model="form.userName" style="width: 400px"></el-input>
      </el-form-item>
      <el-form-item label="昵称" prop="nickname">
        <el-input v-model="form.nickname" style="width: 400px"></el-input>
      </el-form-item>
      <el-form-item label="密码" prop="password">
        <el-input v-model="form.password" style="width: 300px"></el-input>
      </el-form-item>
      <el-form-item label="用户类型" prop="type">
        <el-input v-model="form.type" style="width: 100px"></el-input>
      </el-form-item>
      <el-form-item label="地址" prop="address">
        <el-input v-model="form.address" style="width: 100px"></el-input>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="onSubmit" style="margin-bottom: 20px"
          >立即创建</el-button
        >
        <el-button @click="retreat">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { addUser } from "@/api/user";

export default {
  data() {
    return {
      form: {
        userName: "",
        password: "",
        nickname: "",
        avater: "",
        email: "",
        address: "",
        type: 2,
        state: 0,
      },
      rules: {
        userName: [
          { required: true, message: "请输入用户名称", trigger: "blur" },
          { min: 2, message: "至少两个字！", trigger: "blur" },
        ],
        nickname: [
          { required: true, message: "请输入昵称", trigger: "blur" },
          { min: 1, message: "不能为空！", trigger: "blur" },
        ],
        password: [
          { required: true, message: "请输入密码", trigger: "blur" },
          { min: 6, max: 99, message: "至少六位数！", trigger: "blur" },
        ],
        type: [
          { required: true, message: "请输入用户类型", trigger: "blur" },
          { min: 1, message: "不能为空！", trigger: "blur" },
        ],
      },
    };
  },
  methods: {
    retreat() {
      this.$router.push({ path: "/admin/users" });
    },
    onSubmit() {
      addUser(this.form).then(() => {
        // this.$message({
        //   type: "success",
        //   message: res.message,
        // });
        this.$router.push({ path: "/admin/users" });
      });
    },
    handleAvatarSuccess(res, file) {
      this.form.imageUrl = URL.createObjectURL(file.raw);
    },
    beforeAvatarUpload(file) {
      const isJPG = file.type === "image/jpeg";
      const isLt2M = file.size / 1024 / 1024 < 2;

      if (!isJPG) {
        this.$message.error("上传头像图片只能是 JPG 格式!");
      }
      if (!isLt2M) {
        this.$message.error("上传头像图片大小不能超过 2MB!");
      }
      return isJPG && isLt2M;
    },
  },
};
</script>

<style scoped>
.add-contain {
  width: 90%;
  margin: 30px auto;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
}
.avatar-uploader-icon {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .avatar-uploader-icon:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  line-height: 178px;
  text-align: center;
}
.avatar {
  width: 178px;
  height: 178px;
  display: block;
}
</style>
