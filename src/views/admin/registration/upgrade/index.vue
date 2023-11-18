<template>
  <div class="add-contain">
    <el-form ref="form" :model="form" label-width="80px" :rules="rules">
      <el-form-item label="车辆图片">
        <el-upload
          class="avatar-uploader"
          action="https://jsonplaceholder.typicode.com/posts/"
          :show-file-list="false"
          :on-success="handleAvatarSuccess"
          :before-upload="beforeAvatarUpload"
        >
          <img v-if="form.avatar" :src="form.avatar" class="avatar" />
          <i v-else class="el-icon-plus avatar-uploader-icon"></i>
        </el-upload>
        <span class="tips">(点击图片可修改)</span>
      </el-form-item>
      <el-form-item label="车辆品牌" prop="brand">
        <el-input v-model="form.brand" style="width: 400px"></el-input>
      </el-form-item>
      <el-form-item label="车辆车系" prop="model">
        <el-input v-model="form.model" style="width: 400px"></el-input>
      </el-form-item>
      <el-form-item label="车辆数量" prop="available">
        <el-input v-model="form.available" style="width: 100px"></el-input>
      </el-form-item>
      <el-form-item label="日租金" prop="dailyRate">
        <el-input v-model="form.dailyRate" style="width: 100px"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button
          type="primary"
          @click="handleUpgrade"
          style="margin-bottom: 20px"
          >完成修改</el-button
        >
        <el-button @click="retreat">取消</el-button>
      </el-form-item>
    </el-form>
  </div>
</template>

<script>
import { getDataById, upgradeCar } from "@/api/registration";

export default {
  data() {
    return {
      form: {
        id: "",
        brand: "",
        model: "",
        license: "",
        type: 0,
        dailyRate: 0,
        illustrate: "",
        avatar: "",
        available: 0,
      },
      rules: {
        brand: [
          { required: true, message: "请输入品牌名称", trigger: "blur" },
          { min: 1, message: "不能为空！", trigger: "blur" },
        ],
        model: [
          { required: true, message: "请输入车型名称", trigger: "blur" },
          { min: 1, message: "不能为空！", trigger: "blur" },
        ],
        available: [
          { required: true, message: "请输入车辆数量", trigger: "blur" },
          { min: 1, max: 99, message: "不能为零！", trigger: "blur" },
        ],
        dailyRate: [
          { required: true, message: "请输入车辆数量", trigger: "blur" },
          { min: 1, message: "不能为零！", trigger: "blur" },
        ],
      },
    };
  },
  created() {
    this.fetchDataById(this.$route.params.id);
  },
  methods: {
    retreat() {
      this.$router.push({ path: "/admin/registration" });
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
    fetchDataById(id) {
      getDataById(id).then((res) => {
        this.form = res;
        console.log(this.form);
      });
    },
    handleUpgrade() {
      // let m = {
      //   id: this.form.id,
      //   brand: this.form.brand,
      //   model: this.form.model,
      //   license: this.form.license,
      //   type: this.form.type,
      //   dailyRate: this.form.dailyRate,
      //   illustrate: this.form.illustrate,
      //   avatar: this.form.avatar,
      //   available: this.form.available,
      // };
      upgradeCar(this.form).then(
        () => {
          // this.$message({
          //   type: "success",
          //   message: res.message,
          // });
          this.$router.push({ path: "/admin/registration" });
        },
        (err) => {
          console.log(err);
        }
      );
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
  top: 12px;
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
.tips {
  margin: 0;
  position: relative;
  left: 220px;
  top: -100px;
  color: gray;
}
</style>
