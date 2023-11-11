<template>
    <div class="CarInfo">
      <div id="img">图片</div>
      <div id="introduction">
        <button class="view-details">查看详情</button>
        <span id="price">{{price}}￥</span>
        <span id="CarName">{{ CarName }}</span>
      </div>
    </div>
  </template>
  
  <script>
  export default {
    name: "CarInfo",
    props: ['price','CarName'],
  };
  </script>
  
  <style scoped>
  .CarInfo {
    display: inline-block;
    width: 281px;
    height: 325px;
    margin-top: 30px;
    margin-right: 50px;
    margin-left: -10px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.12), 0 0 6px rgba(0, 0, 0, 0.04);
  }
  .CarInfo:hover {
    box-shadow: 0 10px 10px rgba(0, 0, 0, 0.12), 0 0 10px rgba(0, 0, 0, 0.04);
    transition: box-shadow 0.3s;
  }
  #img {
    width: 100%;
    height: 60%;
    background-color: wheat;
  }
  #introduction {
    position: relative;
    width: 100%;
    height: 40%;
  }
  .view-details {
    position: absolute;
    right: 11px;
    bottom: 11px;
    width: 78px;
    height: 36px;
    background-color: #fff;
    border: rgb(217, 68, 68) 1px solid;
    color: rgb(217, 68, 68);
    border-radius: 5px;
  }
  .view-details:hover {
    background-color: rgb(217, 68, 68);
    color: white;
  }
  #price {
    position: absolute;
    left: 20px;
    bottom: 13px;
    font-size: 31px;
    color: rgb(217, 68, 68);
  }
  #CarName {
    position: absolute;
    left: 13px;
    top: 16px;
  }
  </style>
  