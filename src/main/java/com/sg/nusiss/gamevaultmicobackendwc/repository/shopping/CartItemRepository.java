package com.sg.nusiss.gamevaultmicobackendwc.repository.shopping;

import com.sg.nusiss.gamevaultmicobackendwc.entity.shopping.CartItem;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CartItemRepository extends JpaRepository<CartItem, Long> {
}
