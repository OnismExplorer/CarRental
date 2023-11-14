import request from '@/utils/request'

const api_name = '/admin/vehicle'

export function pageList({key,pageNum,pageSize}) {
    return request({
        url: `${api_name}/page`,
        method: 'get',
        params: {
            key,pageNum,pageSize
        }
    })
}

export function removeById(id) {
    return request({
        url: "/admin/delete/vehicle/{id}",
        method: "delete",
    })
}

export function addCar(car) {
    return request({
        url: "/admin/save/vehicle",
        method: "post",
        data:car,
    })
}

export function updateCar()