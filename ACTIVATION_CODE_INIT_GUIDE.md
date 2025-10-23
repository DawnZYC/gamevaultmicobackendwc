# 游戏激活码自动初始化指南

## 问题描述

当通过SQL直接插入游戏数据时，绕过了原本的`createGame`流程，导致激活码没有被自动生成。

## 解决方案

我们提供了两种解决方案来处理这个问题：

### 方案1：手动API调用（推荐用于测试环境）

执行SQL初始化后，调用以下API来批量初始化所有游戏的激活码：

```bash
POST /api/admin/games/activation-codes/init-all
```

**响应示例：**
```json
{
  "message": "已为 30 个游戏初始化激活码库存"
}
```

### 方案2：自动初始化（推荐用于生产环境）

应用启动时会自动检查并初始化所有游戏的激活码。

**配置参数：**
```yaml
# application.yml
activation:
  stock:
    target: 30  # 每个游戏的目标库存数量
  auto-init:
    enabled: true  # 是否启用自动初始化
```

## 使用步骤

### 1. 执行SQL初始化
```sql
-- 执行您的 init_games.sql
\c gamevault
\i init_games.sql
```

### 2. 初始化激活码

**方式A：自动初始化（推荐）**
- 重启应用，系统会自动检测并初始化所有游戏的激活码
- 查看日志确认初始化结果

**方式B：手动API调用**
```bash
curl -X POST http://localhost:8080/api/admin/games/activation-codes/init-all \
  -H "Authorization: Bearer YOUR_JWT_TOKEN"
```

### 3. 验证结果

检查特定游戏的激活码库存：
```bash
GET /api/admin/games/{gameId}/activation-codes/stats
```

**响应示例：**
```json
{
  "unused": 30,
  "purchased": 0
}
```

## 其他相关API

### 查看单个游戏激活码库存
```bash
GET /api/admin/games/{gameId}/activation-codes/stats
```

### 手动补充特定游戏的激活码
```bash
POST /api/admin/games/{gameId}/activation-codes/replenish
```

### 初始化特定游戏的激活码
```bash
POST /api/admin/games/{gameId}/activation-codes/init
```

## 注意事项

1. **权限要求**：所有管理API都需要管理员权限
2. **事务安全**：激活码生成过程是事务性的，确保数据一致性
3. **性能考虑**：批量初始化可能需要一些时间，建议在低峰期执行
4. **日志监控**：初始化过程会在日志中记录详细信息

## 故障排除

如果激活码初始化失败，请检查：

1. 数据库连接是否正常
2. 游戏数据是否正确插入
3. 应用日志中的错误信息
4. 权限配置是否正确

## 配置示例

```yaml
# application.yml
activation:
  stock:
    target: 30  # 每个游戏的目标库存
  auto-init:
    enabled: true  # 启用自动初始化

logging:
  level:
    com.sg.nusiss.gamevaultmicobackendwc.config.GameInitializationListener: INFO
```
