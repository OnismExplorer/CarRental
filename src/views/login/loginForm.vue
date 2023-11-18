<template>
  <div>
    <el-form
      ref="loginForm"
      :model="loginForm"
      :rules="loginRules"
      auto-complete="on"
      label-position="left"
      class="form card"
    >
      <div class="card_header">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          viewBox="0 0 24 24"
          width="24"
          height="24"
        >
          <path fill="none" d="M0 0h24v24H0z"></path>
          <path
            fill="currentColor"
            d="M4 15h2v5h12V4H6v5H4V3a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v18a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1v-6zm6-4V8l5 4-5 4v-3H2v-2h8z"
          ></path>
        </svg>
        <button class="form_heading" @click="toSign">注册</button>
      </div>
      <div class="field" prop="username">
        <label for="username">用户名</label>
        <input
          class="input"
          name="username"
          type="text"
          placeholder="Username"
          id="username"
          ref="username"
          v-model="loginForm.username"
          tabindex="1"
          auto-complete="on"
        />
      </div>
      <div class="field" prop="password">
        <label for="password">密码</label>
        <input
          :key="passwordType"
          ref="password"
          v-model="loginForm.password"
          class="input"
          name="password"
          :type="passwordType"
          placeholder="Password"
          id="password"
          tabindex="2"
          auto-complete="on"
          @keyup.enter.native="handleLogin"
        />

        <span class="show-pwd" @click="showPwd">
          <svg-icon
            :icon-class="passwordType === 'password' ? 'eye' : 'eye-open'"
          />
        </span>
      </div>
      <div class="field">
        <button class="button" :loading="loading" @click="handleLogin">
          登录
        </button>
      </div>
    </el-form>
  </div>
</template>

<script>
import { validUsername } from "@/utils/validate";
export default {
  name: "loginForm",
  data() {
    const validateUsername = (rule, value, callback) => {
      if (!validUsername(value)) {
        callback(new Error("Please enter the correct user name"));
      } else {
        callback();
      }
    };
    const validatePassword = (rule, value, callback) => {
      if (value.length < 6) {
        callback(new Error("The password can not be less than 6 digits"));
      } else {
        callback();
      }
    };
    return {
      loginForm: {
        username: "admin",
        password: "123456",
      },
      loginRules: {
        username: [
          { required: true, trigger: "blur", validator: validateUsername },
        ],
        password: [
          { required: true, trigger: "blur", validator: validatePassword },
        ],
      },
      loading: false,
      passwordType: "password",
      redirect: undefined,
    };
  },
  watch: {
    $route: {
      handler: function (route) {
        this.redirect = route.query && route.query.redirect;
      },
      immediate: true,
    },
  },
  methods: {
    showPwd() {
      if (this.passwordType === "password") {
        this.passwordType = "";
      } else {
        this.passwordType = "password";
      }
      this.$nextTick(() => {
        this.$refs.password.focus();
      });
    },

    handleLogin() {
      this.$refs.loginForm.validate((valid) => {
        if (valid) {
          this.loading = true;
          this.$store
            .dispatch("user/login", this.loginForm)
            .then(() => {
              this.$router.push({ path: this.redirect || "/" });
              this.loading = false;
            })
            .catch(() => {
              this.loading = false;
            });
        } else {
          console.log("error submit!!");
          return false;
        }
      });
    },
    toSign() {
      
      this.$router.push({ path: '/sign' })
      console.log("123");
    }
  },
};
</script>

<style lang="scss" scoped>
$dark_gray: #889aa4;
.card {
  width: 420px;
  height: 280px;
  background: rgba($color: #f7f6f6, $alpha: 0.7);
  border: 1px solid transparent;
  border-radius: 5px;
  box-shadow: 10px 10px 64px 0px rgba(180, 180, 207, 0.75);
  -webkit-box-shadow: 10px 10px 64px 0px rgba(186, 186, 202, 0.75);
  -moz-box-shadow: 10px 10px 64px 0px rgba(208, 208, 231, 0.75);
}

.form {
  padding: 25px;
}

.card_header {
  display: flex;
  align-items: center;
}

.card svg {
  color: #7878bd;
  margin-bottom: 20px;
  margin-right: 5px;
  
}

.form_heading {
  position: relative;
  top:-10px;
  padding-bottom: 20px;
  font-size: 21px;
  color: #7878bd;
  background-color: transparent;
}
.form_heading:hover{
  background-color: transparent;
  cursor: pointer;
}
.field {
  padding-bottom: 10px;
  .show-pwd {
    position: absolute;
    right: 25px;
    bottom: 56px;
    font-size: 16px;
    color: $dark_gray;
    cursor: pointer;
    user-select: none;
  }
}

.input {
  border-radius: 5px;
  background-color: #e9e9f7;
  padding: 5px;
  width: 100%;
  color: #7a7ab3;
  border: 1px solid #dadaf7;
}

.input:focus-visible {
  outline: 1px solid #aeaed6;
}

.input::placeholder {
  color: #bcbcdf;
}

label {
  color: #eef0f4;
  font-size: 14px;
  display: block;
  padding-bottom: 4px;
}

button {
  background-color: #7878bd;
  margin-top: 10px;
  font-size: 14px;
  padding: 7px 12px;
  height: auto;
  font-weight: 500;
  color: white;
  border: none;
}

button:hover {
  background-color: #5f5f9c;
}
</style>
