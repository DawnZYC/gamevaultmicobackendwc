package com.sg.nusiss.gamevaultmicobackendwc.config;

import com.sg.nusiss.gamevaultmicobackendwc.service.shopping.GameActivationCodeService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * 游戏初始化监听器
 * 在应用启动完成后，自动检查并初始化所有游戏的激活码
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class GameInitializationListener {

    private final GameActivationCodeService activationCodeService;
    
    @Value("${activation.auto-init.enabled:true}")
    private boolean autoInitEnabled;

    /**
     * 应用启动完成后自动初始化所有游戏的激活码
     */
    @EventListener(ApplicationReadyEvent.class)
    public void onApplicationReady() {
        if (!autoInitEnabled) {
            log.info("自动初始化激活码功能已禁用");
            return;
        }
        
        try {
            log.info("开始检查并初始化游戏激活码...");
            int processedCount = activationCodeService.initializeAllGamesCodes();
            log.info("激活码初始化完成，处理了 {} 个游戏", processedCount);
        } catch (Exception e) {
            log.error("初始化激活码时发生错误", e);
        }
    }
}
