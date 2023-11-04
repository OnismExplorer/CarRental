<template>
  <div class="login-container">
    <loginForm class="form"></loginForm>
  </div>
</template>

<script>
import loginForm from './loginForm.vue';
export default {
  name: "Login",
  components:{loginForm},
};
</script>

<style lang="scss">
$bg: #283443;
$light_gray: #fff;
$cursor: #fff;

@supports (-webkit-mask: none) and (not (cater-color: $cursor)) {
  .login-container .el-input input {
    color: $cursor;
  }
}

</style>

<style lang="scss" scoped>
$bg: #2d3a4b;
$dark_gray: #889aa4;
$light_gray: #eee;

.login-container {
  min-height: 100%;
  width: 100%;
  background-size: 100%;
  background-attachment: fixed;
  background: url("~@/assets/login/file_.png") center center;
  overflow: hidden;
}

.form {
  position: relative;
  top: 217px;
  left: 37%;
  padding: 25px;
}
</style>
