import request from "@/utils/request";

export function getAllData() {
    return request({
        url: '/vehicle/list',
        method:'get'
    })
}