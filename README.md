# HarmonyOS 项目模板

这是一个基于鸿蒙 ArkUI 的模块化项目模板，采用 Stage 模型和 HAR 模块化架构。

## 项目结构

```
HarmonyProjectTemplate/
├── products/phone              # 应用主入口模块
│   └── src/main/ets/pages/
│       ├── Index.ets         # Navigation 根页面
│       ├── IndexPage.ets     # Tab 首页（4个Tab）
│       ├── StartPage.ets     # 启动页
│       ├── SafePage.ets      # 隐私协议确认页
│       ├── PrivacyPage.ets   # 隐私协议详情页
│       └── AgreeDialogPage.ets # 隐私协议弹窗
│
├── commons/                    # 公共模块
│   ├── lib_common/            # 公共工具、常量、路由
│   ├── lib_account/           # 登录模块（华为登录、账号登录）
│   └── lib_api/               # API 封装层
│
├── features/                   # 功能模块（业务 Feature）
│   ├── home/                  # Tab1 - 首页
│   ├── course/                # Tab2 - 课程
│   ├── plan/                  # Tab3 - 计划
│   ├── mine/                  # Tab4 - 我的
│   └── setting/               # 设置模块
│
└── oh-package.json5           # 项目依赖配置
```

## 核心特性

### 1. 隐私协议流程
```
StartPage → SafePage → IndexPage(Tab首页)
              ↓
        PrivacyPage(隐私详情)
```

- 应用启动时先检查是否同意隐私协议
- 未同意则跳转到 SafePage 确认
- 同意后直接进入 Tab 首页

### 2. 登录模块
位置：`commons/lib_account/`

- 华为账号登录
- 第三方登录扩展支持
- 登录状态拦截（IndexVM 中配置）

使用方式：
```typescript
import { LoginSheetUtils } from 'lib_account';

// 打开登录弹窗
LoginSheetUtils.open();
```

### 3. Tab 结构
4个 Tab 页面：
- 首页 (HomePage)
- 课程 (CoursePage)
- 计划 (PlanPage)
- 我的 (MinePage)

### 4. 路由管理
位置：`commons/lib_common/src/main/ets/utils/RouterUtils.ets`

使用方式：
```typescript
import { RouterMap, RouterUtils } from 'lib_common';

// 跳转页面
RouterUtils.pushPathByName(RouterMap.SETTING_PAGE);

// 替换页面
RouterUtils.replacePathByName(RouterMap.INDEX_PAGE);

// 返回
RouterUtils.pop();
```

### 5. 需要登录的页面配置
位置：`products/phone/src/main/ets/common/Constants.ets`

```typescript
export const REQUIRE_LOGIN_PAGE_LIST: RouterMap[] = [
  // 添加需要登录才能访问的页面
];
```

## 模块依赖关系

```
products/phone
    ├── depends on: lib_common, lib_account, lib_api
    ├── depends on: home, course, plan, mine, setting

features/*
    ├── depends on: lib_common, lib_widget
    ├── depends on: lib_account (可选)

commons/lib_account
    ├── depends on: lib_common, lib_api

commons/lib_api
    ├── depends on: lib_common
```

## 快速开始

1. **克隆模板后修改以下配置：**
   - `products/phone/src/main/ets/pages/StartPage.ets`: 修改应用名称和 slogan
   - `products/phone/src/main/ets/pages/SafePage.ets`: 修改隐私协议相关文案
   - `products/phone/src/main/resources/rawfile/privacy-statement.htm`: 隐私协议 HTML 内容

2. **添加业务代码：**
   - 在 `features/*` 对应模块中添加业务页面
   - 在 `commons/lib_api` 中添加 API 接口
   - 在 `commons/lib_common/src/main/ets/constants/RouterMap.ets` 中添加路由

3. **配置登录拦截：**
   - 在 `REQUIRE_LOGIN_PAGE_LIST` 中添加需要登录的页面

## 注意事项

1. 本模板移除了原有的引导页流程，如需添加请在 `StartPage.ets` 中修改跳转逻辑
2. 四个 Tab 页面已简化为骨架，需自行添加业务内容
3. API 模块保留了基础结构，需根据实际业务接口修改

## License

MIT
