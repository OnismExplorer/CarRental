package com.code.rent.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.code.rent.entity.Order;
import com.code.rent.entity.dto.OrderDTO;
import com.code.rent.entity.vo.OrderVO;

import java.util.Date;

/**
* @author HeXin
* @description 针对表【order】的数据库操作Service
* @createDate 2023-10-29 14:58:39
*/
public interface OrderService extends IService<Order> {

    OrderVO create(OrderDTO dto);

    OrderVO finish(String orderId);

    Boolean update(String id, Date start, Date end);
}
