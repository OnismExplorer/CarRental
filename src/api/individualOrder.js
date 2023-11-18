import request from "@/utils/request";

export function getOrderById(uid) {
  return request({
    url: `/order/details/${uid}`,
    type: "get",
  });
}
export function removeOrder(id) {
  return request({
    url: `/order/cancel/${id}`,
    type: "put",
  });
}
export function changeOrder({ id, start, end }) {
  return request({
    url: `/order/update/${id}`,
    type: "put",
    params: {
      id,
      start,
      end,
    },
  });
}
