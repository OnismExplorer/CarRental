package com.code.rent.controller;

import cn.dev33.satoken.annotation.SaCheckLogin;
import cn.hutool.core.date.DateUnit;
import cn.hutool.core.date.DateUtil;
import com.code.rent.common.Result;
import com.code.rent.constants.CodeEnum;
import com.code.rent.entity.Order;
import com.code.rent.entity.dto.OrderDTO;
import com.code.rent.entity.vo.OrderVO;
import com.code.rent.exception.CustomException;
import com.code.rent.service.OrderService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

/**
 * 订单控制器
 *
 * @author HeXin
 * @date 2023/11/12
 */
@Tag(name = "订单模块")
@RestController
@SaCheckLogin
@RequestMapping("/order")
public class OrderController {

    /**
     * 订购服务
     */
    @Autowired
    private OrderService orderService;

    /**
     * 创建订单
     *
     * @param dto DTO
     * @return {@link Result}<{@link OrderVO}>
     */
    @Operation(summary = "创建订单")
    @PostMapping("/create")
    public Result<OrderVO> createOrder(@RequestBody OrderDTO dto){
        return Result.success(orderService.create(dto));
    }

    /**
     * 完成订单
     *
     * @param orderId 订单编号
     * @return {@link Result}<{@link OrderVO}>
     */
    @Operation(summary = "完成订单")
    @PostMapping("/finish/{orderId}")
    public Result<OrderVO> finishOrder(@PathVariable String orderId){
        return Result.success(orderService.finish(orderId));
    }

    /**
     * 通过UID获取订单详细信息
     *
     * @param uid uid
     * @return {@link Result}<{@link OrderVO}>
     */
    @Operation(summary = "根据用户id获取订单详情")
    @GetMapping("/details/{uid}")
    public Result<List<OrderVO>> getOrderDetailsByUid(@PathVariable String uid){
        List<Order> orders = orderService.lambdaQuery().notIn(Order::getStatus,3).eq(Order::getUid, uid).list();
        List<OrderVO> result = new ArrayList<>();
        orders.forEach(order -> result.add(Order.toVo(order)));
        return Result.success(result);
    }

    /**
     * 按 ID 获取订单
     *
     * @param id 编号
     * @return {@link Result}<{@link OrderVO}>
     */
    @Operation(summary = "根据订单id获取订单")
    @GetMapping("/detail/{id}")
    public Result<OrderVO> getOrderById(@PathVariable String id){
        return Result.success(Order.toVo(orderService.getById(id)));
    }

    @Operation(summary = "修改租赁日期")
    @PutMapping("/update/{id}")
    public Result<OrderVO> updateOrder(@PathVariable String id,
                                       @RequestParam("start")Date start,
                                       @RequestParam("end")Date end){
        return Result.isSuccess(orderService.update(id, start, end));
    }

    /**
     * 取消订单
     *
     * @param id 编号
     * @return {@link Result}
     */
    @Operation(summary = "取消订单")
    @PutMapping("/cancel/{id}")
    public Result cancelOrder(@PathVariable String id){
        Order order = orderService.getById(id);
        if(order.getStatus().equals(4)){
            throw new CustomException(CodeEnum.ORDER_ABNORMAL);
        }
        order.setStatus(3);
        return Result.isSuccess(orderService.updateById(order));
    }
}
