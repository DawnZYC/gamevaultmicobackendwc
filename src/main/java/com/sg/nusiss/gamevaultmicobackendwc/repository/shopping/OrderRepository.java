package com.sg.nusiss.gamevaultmicobackendwc.repository.shopping;

import com.sg.nusiss.gamevaultmicobackendwc.entity.shopping.Order;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long>, OrderRepositoryCustom {
    List<Order> findByUserId(Long userId);
    List<Order> findByUserIdOrderByOrderIdDesc(Long userId);
}

interface OrderRepositoryCustom {
    List<Order> findOrdersWithItems(Long userId);
}
