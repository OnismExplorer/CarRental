import request from "@/utils/request";

export function createOrder(order) {
  return request({
    url: "/order/create",
    method: "post",
    data:order
  });
}


