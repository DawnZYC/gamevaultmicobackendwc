# GameVault 微服务后端 - 商城服务 (WC)

这是GameVault的微服务后端，专门负责游戏商城、支付和激活码管理相关功能。

## 功能模块

### 1. 游戏商城模块 (Games)
- 游戏列表展示（支持搜索、筛选）
- 游戏详情查询
- 游戏管理（创建、更新 - 管理员功能）
- 游戏图片上传和管理

**API端点：**
- `GET /api/games` - 获取游戏列表（支持搜索、按类型、按平台筛选）
- `GET /api/games/{id}` - 获取游戏详情
- `POST /api/games` - 创建新游戏（管理员）
- `PUT /api/games/{id}` - 更新游戏信息（管理员）
- `POST /api/games/{gameId}/image` - 上传游戏图片
- `DELETE /api/games/{gameId}/image` - 删除游戏图片

### 2. 购物车模块 (Cart)
- 购物车查询
- 添加/移除游戏到购物车
- 更新购物车商品数量
- 清空购物车
- 应用折扣策略
- 结账功能

**API端点：**
- `GET /api/cart` - 获取购物车
- `POST /api/cart/items` - 添加游戏到购物车
- `PUT /api/cart/items/{gameId}` - 更新购物车商品数量
- `DELETE /api/cart/items/{gameId}` - 移除购物车商品
- `DELETE /api/cart` - 清空购物车
- `POST /api/cart/discount` - 应用折扣策略
- `POST /api/cart/checkout` - 结账

### 3. 激活码管理模块 (Activation Codes)
- 自动生成游戏激活码
- 激活码库存管理
- 自动补充库存机制（低于目标库存时自动补充）
- 用户激活码查询

**API端点：**

**管理员功能：**
- `GET /api/admin/games/{gameId}/activation-codes/stats` - 查看激活码库存统计
- `POST /api/admin/games/{gameId}/activation-codes/replenish` - 手动补充激活码
- `POST /api/admin/games/{gameId}/activation-codes/init` - 初始化激活码库存

**用户功能：**
- `GET /api/user/activation-codes` - 查询当前用户所有已购激活码
- `GET /api/user/activation-codes/{gameId}` - 查询当前用户指定游戏的激活码

### 4. 支付和订单模块 (Orders)
- 创建待支付订单
- 支付成功后自动分配激活码
- 订单状态管理
- 订单查询

**订单服务方法：**
- `createPendingOrder()` - 创建待支付订单
- `captureAndFulfill()` - 支付成功后完成订单并分配激活码
- `markFailed()` - 标记订单失败
- `findById()` - 查询订单详情
- `findByUserId()` - 查询用户订单列表

### 5. 折扣策略模块 (Discount)
支持多种折扣策略：
- 无折扣策略 (`NoDiscountStrategy`)
- 百分比折扣 (`PercentageDiscount`)
- 可通过工厂模式轻松扩展新的折扣策略

## 技术栈

- **框架**: Spring Boot 3.5.6
- **数据库**: PostgreSQL
- **安全**: Spring Security + JWT (RSA公钥验证)
- **文件上传**: Apache Commons FileUpload
- **构建工具**: Maven

## 配置

### 数据库配置
```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:12000/gamevault
    username: gamevault_user
    password: gamevault_pass
```

### JWT配置
本微服务使用RSA公钥验证JWT令牌（由认证微服务签发）：
```yaml
rsa:
  public-key: "file:secrets/keys/rsa-public.pem"
spring:
  security:
    oauth2:
      resourceserver:
        jwt:
          public-key-location: ${rsa.public-key}
```

### 激活码库存配置
```yaml
activation:
  stock:
    target: 30  # 目标库存量，库存低于此值时自动补充
```

### 文件上传配置
```yaml
app:
  upload:
    path: uploads
    max-file-size: 5MB
    max-request-size: 10MB
```

## 运行方式

### 前置条件

1. Java 17+
2. Maven 3.8+
3. PostgreSQL数据库（端口12000）
4. 确保RSA公钥文件存在于 `secrets/keys/rsa-public.pem`

### 使用Docker Compose启动数据库

```bash
# 启动PostgreSQL服务
docker-compose up -d
```

### 直接运行

```bash
# 确保PostgreSQL服务运行在localhost:12000
mvn spring-boot:run
```

## 端口配置

- **应用端口**: 8081
- **PostgreSQL**: 12000
- **认证微服务(zyc)**: 8080（需要同时运行）

## 与其他微服务的关系

### 认证微服务 (gamevaultmicobackendzyc - 端口8080)
负责：
- 用户登录/注册
- JWT令牌签发
- 用户资料管理
- 订单查询
- 游戏库管理

### 商城微服务 (gamevaultmicobackendwc - 端口8081)
负责：
- 游戏商城展示
- 购物车管理
- 支付和订单创建
- 激活码生成和分配

两个微服务：
- **共享同一个PostgreSQL数据库**
- **使用RSA密钥对进行JWT认证**（认证服务签发，商城服务验证）
- **通过JWT令牌传递用户信息**，无需服务间直接调用

## 激活码自动管理机制

### 工作流程

1. **游戏上架时**: 自动生成目标数量（默认30个）的激活码
2. **购买流程**:
   - 用户结账 → 创建PENDING状态的订单
   - 支付成功 → 从未使用激活码库存中分配激活码
   - 记录到已购激活码表
   - 删除库存中已分配的激活码
3. **自动补充**: 每次分配激活码后，检查库存，如果低于目标值则自动补充

### 数据表设计

- `unused_game_activation_code`: 未使用的激活码库存
- `purchased_game_activation_code`: 已购买的激活码（关联用户和订单项）
- `game`: 游戏信息表
- `cart`: 购物车表
- `cart_item`: 购物车商品项
- `orders`: 订单表
- `order_item`: 订单项表

## 安全认证

所有需要认证的API端点（除了公开的游戏列表/详情）都需要携带JWT令牌：

```
Authorization: Bearer <JWT_TOKEN>
```

JWT令牌由认证微服务（端口8080）签发，本服务使用RSA公钥进行验证。

## 开发说明

### 添加新的折扣策略

1. 实现 `IDiscountStrategy` 接口
2. 在 `DiscountFactory` 中注册新策略
3. 通过 `/api/cart/discount` 端点应用策略

### 扩展功能

由于采用微服务架构，可以独立部署和扩展本服务，不影响其他服务。

## 注意事项

1. 本微服务不处理用户认证，所有用户信息通过JWT令牌获取
2. 游戏详细信息和激活码由本服务管理，订单记录在两个服务中都有维护
3. 确保与认证微服务使用相同的RSA密钥对
4. 所有API都需要JWT认证（除了公开的游戏列表/详情查询）

## 测试

```bash
mvn test
```

## 联系方式

如有问题，请联系开发团队。

