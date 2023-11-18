import Vue from "vue";
import Router from "vue-router";

Vue.use(Router);

/* Layout */
import Layout from "@/layout";

/**
 * Note: sub-menu only appear when route children.length >= 1
 * Detail see: https://panjiachen.github.io/vue-element-admin-site/guide/essentials/router-and-nav.html
 *
 * hidden: true                   if set true, item will not show in the sidebar(default is false)
 * alwaysShow: true               if set true, will always show the root menu
 *                                if not set alwaysShow, when item has more than one children route,
 *                                it will becomes nested mode, otherwise not show the root menu
 * redirect: noRedirect           if set noRedirect will no redirect in the breadcrumb
 * name:'router-name'             the name is used by <keep-alive> (must set!!!)
 * meta : {
    roles: ['admin','editor']    control the page roles (you can set multiple roles)
    title: 'title'               the name show in sidebar and breadcrumb (recommend set)
    icon: 'svg-name'/'el-icon-x' the icon show in the sidebar
    breadcrumb: false            if set false, the item will hidden in breadcrumb(default is true)
    activeMenu: '/example/list'  if set path, the sidebar will highlight the path you set
  }
 */

/**
 * constantRoutes
 * a base page that does not have permission requirements
 * all roles can be accessed
 */
export const constantRoutes = [
  {
    path: "/login",
    component: () => import("@/views/login/index"),
    hidden: true,
  },
  {
    path: "/404",
    component: () => import("@/views/404"),
    hidden: true,
  },
  {
    path: "/sign",
    component: () => import("@/views/login/sign/sigin"),
    hidden: true,
  },
  // 主页
  {
    path: "/",
    component: Layout,
    redirect: "/dashboard",
    children: [
      {
        path: "dashboard",
        name: "Dashboard",
        component: () => import("@/views/dashboard/index"),
        meta: { title: "主页", icon: "dashboard" },
      },
      {
        path: "details",
        name: "details",
        component: () => import("@/views/dashboard/details/index"),
        meta: {
          title: "车辆详情",
        },
        hidden: true,
      },
    ],
  },

  // 管理员查看
  {
    path: "/admin",
    component: Layout,
    redirect: "/admin/registration",
    name: "Admin",
    meta: {
      title: "管理员",
      icon: "nested",
    },
    children: [
      {
        path: "registration",
        component: () => import("@/views/admin/registration/index"),
        name: "registration",
        meta: { title: "查看车辆" },
      },
      {
        path: "add",
        component: () => import("@/views/admin/registration/add/index"),
        name: "add",
        meta: { title: "添加车辆" },
        hidden: true,
      },
      {
        path: "upgrade",
        component: () => import("@/views/admin/registration/upgrade/index"),
        name: "upgrade",
        meta: { title: "修改车辆" },
        hidden: true,
      },
      {
        path: "users",
        component: () => import("@/views/admin/users/index"),
        name: "users",
        meta: { title: "查看用户" },
      },
      {
        path: "usersInfo",
        component: () => import("@/views/admin/users/userInfo/index"),
        name: "usersInfo",
        meta: { title: "用户详情" },
        hidden: true,
      },
      {
        path: "adduser",
        component: () => import("@/views/admin/users/add/index"),
        name: "adduser",
        meta: { title: "新增用户" },
        hidden: true,
      },

      {
        path: "upgradeUser",
        component: () => import("@/views/admin/users/upgrade/index"),
        name: "upgradeUser",
        meta: { title: "修改用户信息" },
        hidden: true,
      },
    ],
  },
  // 个人订单
  {
    path: "/order",
    component: Layout,
    children: [
      {
        path: "order",
        name: "order",
        component: () => import("@/views/individualOrder/index"),
        meta: { title: "个人订单", icon: "form" },
      },
    ],
  },

  // 个人详情
  {
    path: "/userInfo",
    component: Layout,
    children: [
      {
        path: "userInfo",
        name: "userInfo",
        component: () => import("@/views/userInfo/index"),
        meta: { title: "个人详情", icon: "link" },
      },
    ],
  },

  // 404 page must be placed at the end !!!
  { path: "*", redirect: "/404", hidden: true },
];

const createRouter = () =>
  new Router({
    // mode: 'history', // require service support
    scrollBehavior: () => ({ y: 0 }),
    routes: constantRoutes,
  });

const router = createRouter();

// Detail see: https://github.com/vuejs/vue-router/issues/1234#issuecomment-357941465
export function resetRouter() {
  const newRouter = createRouter();
  router.matcher = newRouter.matcher; // reset router
}

export default router;
