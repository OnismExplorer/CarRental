package com.code.rent.entity.vo;

import com.code.rent.entity.Order;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Data;
import lombok.experimental.Accessors;

import java.math.BigDecimal;
import java.util.Date;

/**
 * 订购 VO
 *
 * @author HeXin
 * @date 2023/11/12
 */
@Data
@Accessors(chain = true)
public class OrderVO {
    /**
     * 编号
     */
    @Schema(description = "订单id")
    private String id;
    /**
     * uid
     */
    @Schema(description = "用户id")
    private Long uid;
    /**
     * 许可证
     */
    @Schema(description = "车辆车牌号")
    private String license;
    /**
     * 开始
     */
    @Schema(description = "车辆租赁开始时间")
    private Date start;
    /**
     * 结束
     */
    @Schema(description = "车辆租赁结束时间")
    private Date end;
    /**
     * 说明
     */
    @Schema(description = "车辆信息描述")
    private String illustrate;
    /**
     * 返回时间
     */
    @Schema(description = "车辆归还日期")
    private Date returnTime;
    /**
     * 总成本
     */
    @Schema(description = "总租金费用")
    private BigDecimal totalCost;

    /**
     * 至 po
     *
     * @param vo VO
     * @return {@link Order}
     */
    public static Order toPo(OrderVO vo){
        if (vo == null) {
            return null;
        }
        Order order = new Order();
        order.setUid(vo.getUid());
        order.setStart(vo.getStart());
        order.setEnd(vo.getEnd());
        order.setReturnTime(vo.getReturnTime());
        order.setTotalCost(vo.getTotalCost());
        order.setIllustrate(vo.getIllustrate());
        order.setId(vo.getId());
        return order;
    }
}