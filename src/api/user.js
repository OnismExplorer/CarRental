import request from "@/utils/request";

export function login(data) {
  return request({
    url: "/user/login",
    method: "post",
    data,
  });
}

export function getInfo(token) {
  return request({
    url: "/user/info",
    method: "get",
    params: { token },
  });
}

export function logout() {
  return request({
    url: "/user/logout",
    method: "post",
  });
}

export function getUserData({ key, pageNum, pageSize }) {
  return request({
    url: "/admin/user/page",
    method: "get",
    params: { key, pageNum, pageSize },
  });
}

export function getUserById(id) {
  return request({
    url: `/admin/user/${id}`,
    method:'get'
  })
}

export function removeById(id) {
  return request({
    url: `/admin/delete/user/${id}`,
    method:'delete'
  })
}

export function addUser() {
  return request({
    url: '/admin/save/user',
    method:'post'
  })
}

export function upgradeUser() {
  return request({
    url: '/admin/update/user',
    method:'put'
  })
}