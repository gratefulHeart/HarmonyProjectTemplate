# 搜索组件快速入门

## 目录

- [简介](#简介)
- [约束与限制](#约束与限制)
- [使用](#使用)
- [API参考](#API参考)
- [示例代码](#示例代码)

## 简介

本组件提供了搜索文本的功能，开发者可以根据业务需要快速搭建搜索页面。

<img src="./screenshot/search01.jpg" width="300">

## 约束与限制
### 环境
- DevEco Studio版本：DevEco Studio 5.0.3 Release及以上
- HarmonyOS SDK版本：HarmonyOS 5.0.3 Release SDK及以上
-  设备类型：华为手机（包括双折叠和阔折叠）
- 系统版本：HarmonyOS 5.0.1(13)及以上

## 使用

1. 安装组件。

   如果是在DevEco Studio使用插件集成组件，则无需安装组件，请忽略此步骤。

   如果是从生态市场下载组件，请参考以下步骤安装组件。

   a. 解压下载的组件包，将包中所有文件夹拷贝至您工程根目录的XXX目录下。

   b. 在项目根目录build-profile.json5添加module_search模块。

    ```
   // 在项目根目录build-profile.json5填写module_search路径。其中XXX为组件存放的目录名。
   "modules": [
   {
   "name": "module_search",
   "srcPath": "./XXX/module_search",
   }
   ]
    ```
   c. 在项目根目录oh-package.json5中添加依赖。
   ```
   // XXX为组件存放的目录名称
   "dependencies": {
      "module_search": "file:./XXX/module_search"
     }
   ```

2. 引入搜索组件句柄

   ```
   import { SearchPage } from 'module_search';
   ```
3. 调用组件，详细参数配置说明参见[API参考](#API参考)。

   ``` 
   import { SearchPage } from 'module_search';
   
   @Entry
   @Component
   struct Index {
     build() {
       Column() {
         // 搜索页面
        SearchPage({
          searchSourceData: ["DevEco Studio的使用", "ArkTS基础语法", "<HarmonyOS第二课>构建更加丰富的页面", "应用程序框架基础",
             "HarmonyOS第一课"],// 搜索的数据源
          clickSearchResult: (searchData) => {
           console.log("点击搜索结果回调事件")
          },
          back: () => {// 点击返回按钮
           console.log("点击返回按钮")
          },
        })
       }
       .width('100%')
       .height('100%')
     }
   }
   ```

## API参考

### 接口

SearchPage({searchSourceData?:string[]})

搜索组件。

**参数：**

| 参数名           | 类型     | 是否必填 | 说明       |
| ---------------- | -------- | -------- | ---------- |
| searchSourceData | string[] | 否       | 搜索源数据 |



### 事件

支持以下事件：
#### clickSearchResult

clickSearchResult: () => void = () => {}

搜索结果的一项的点击事件

#### back

back: () => void = () => {}

回退按钮回调函数。

## 示例代码

   ``` 
  import { SearchPage } from 'module_search';
   
   @Entry
   @Component
   struct Index {
     build() {
       Column() {
         // 搜索页面
        SearchPage({
          searchSourceData: ["DevEco Studio的使用", "ArkTS基础语法", "<HarmonyOS第二课>构建更加丰富的页面", "应用程序框架基础",
             "HarmonyOS第一课"],// 搜索的数据源
          clickSearchResult: (searchData) => {
           console.log("点击搜索结果回调事件")
          },
          back: () => {// 点击返回按钮
           console.log("点击返回按钮")
          },
        })
       }
       .width('100%')
       .height('100%')
     }
   }
   ```
