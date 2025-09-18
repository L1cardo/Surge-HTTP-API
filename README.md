# Surge HTTP API Swift Package

一个用于调用 Surge HTTP API 的 Swift Package，支持 Surge iOS 4.4.0+ 和 Mac 4.0.0+ 版本。

所有 API 均来自 [Surge 官方手册](https://manual.nssurge.com/others/http-api.html)

**注意：此包已更新为使用现代 async/await 语法，并支持最新的 iOS 17+ 和 macOS 14+ 平台版本。**

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2017%2B%20%7C%20macOS%2014%2B-blue.svg)](https://developer.apple.com/platforms/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/your-username/SurgeHTTPAPI/blob/main/LICENSE)

## 功能特性

- 完整实现 Surge HTTP API 的所有端点
- 使用 Alamofire 进行网络请求
- 使用 SwiftyJSON 处理 JSON 数据
- 支持 iOS 和 macOS 平台
- 使用现代 async/await 语法
- 符合 Swift 语法规范

## 安装

### Swift Package Manager

在 `Package.swift` 中添加依赖：

```swift
dependencies: [
    .package(url: "https://github.com/your-username/SurgeHTTPAPI.git", from: "1.0.0")
]
```

或者在 Xcode 中：

1. 选择 File > Swift Packages > Add Package Dependency
2. 输入仓库 URL
3. 选择版本

## 使用方法

### 初始化客户端

```swift
import SurgeHTTPAPI

// 保存配置到 UserDefaults（只需一次）
SurgeHTTPAPI.shared.saveConfiguration(baseURL: "http://127.0.0.1:6171", apiKey: "your-api-key")

// 使用单例客户端（推荐）
let surgeClient = SurgeHTTPAPI.shared
```

### 功能切换 (使用 async/await)

```swift
// 获取 MITM 状态
Task {
    do {
        let state = try await surgeClient.getMITMState()
        print("MITM enabled: \(state.enabled)")
    } catch {
        print("Error: \(error)")
    }
}

// 设置 MITM 状态
Task {
    do {
        try await surgeClient.setMITMState(enabled: true)
        print("MITM state updated successfully")
    } catch {
        print("Error: \(error)")
    }
}
```

### 出站模式 (使用 async/await)

```swift
// 获取出站模式
Task {
    do {
        let mode = try await surgeClient.getOutboundMode()
        print("Outbound mode: \(mode.mode)")
    } catch {
        print("Error: \(error)")
    }
}

// 设置出站模式
Task {
    do {
        try await surgeClient.setOutboundMode(mode: "rule")
        print("Outbound mode updated successfully")
    } catch {
        print("Error: \(error)")
    }
}
```

### 代理策略 (使用 async/await)

```swift
// 列出所有策略
Task {
    do {
        let policies = try await surgeClient.getPolicies()
        print("Policies: \(policies)")
    } catch {
        print("Error: \(error)")
    }
}

// 测试策略
Task {
    do {
        let testRequest = PolicyTestRequest(
            policyNames: ["ProxyA", "ProxyB"], 
            url: "http://bing.com"
        )
        let result = try await surgeClient.testPolicies(request: testRequest)
        print("Test result: \(result)")
    } catch {
        print("Error: \(error)")
    }
}
```


## 支持的 API 端点

### 功能切换
- MITM: `GET / POST /v1/features/mitm`
- Capture: `GET / POST /v1/features/capture`
- Rewrite: `GET / POST /v1/features/rewrite`
- Scripting: `GET / POST /v1/features/scripting`
- System Proxy (仅 Mac): `GET / POST /v1/features/system_proxy`
- Enhanced Mode (仅 Mac): `GET / POST /v1/features/enhanced_mode`

### 出站模式
- 出站模式: `GET / POST /v1/outbound`
- 全局策略: `GET / POST /v1/outbound/global`

### 代理策略
- 策略列表: `GET /v1/policies`
- 策略详情: `GET /v1/policies/detail`
- 测试策略: `POST /v1/policies/test`
- 策略组: `GET /v1/policy_groups`
- 策略组测试结果: `GET /v1/policy_groups/test_results`
- 策略组选择: `GET / POST /v1/policy_groups/select`
- 测试策略组: `POST /v1/policy_groups/test`

### 请求管理
- 最近请求: `GET /v1/requests/recent`
- 活动请求: `GET /v1/requests/active`
- 杀死请求: `POST /v1/requests/kill`

### 配置文件 (仅 Mac 4.0.6+)
- 当前配置: `GET /v1/profiles/current`
- 重新加载: `POST /v1/profiles/reload`
- 切换配置: `POST /v1/profiles/switch`
- 可用配置: `GET /v1/profiles`
- 检查配置: `POST /v1/profiles/check`

### DNS
- 刷新缓存: `POST /v1/dns/flush`
- DNS 缓存: `GET /v1/dns`
- 测试延迟: `POST /v1/test/dns_delay`

### 模块
- 模块列表: `GET /v1/modules`
- 设置模块: `POST /v1/modules`

### 脚本
- 脚本列表: `GET /v1/scripting`
- 评估脚本: `POST /v1/scripting/evaluate`
- 评估 Cron 脚本: `POST /v1/scripting/cron/evaluate`

### 设备管理 (仅 Mac 4.0.6+)
- 设备列表: `GET /v1/devices`
- 设备图标: `GET /v1/devices/icon`
- 更新设备: `POST /v1/devices`

### 杂项
- 停止 Surge: `POST /v1/stop`
- 事件中心: `GET /v1/events`
- 规则列表: `GET /v1/rules`
- 流量信息: `GET /v1/traffic`
- 日志级别: `POST /v1/log/level`
- MITM CA 证书: `GET /v1/mitm/ca`

## 要求

- iOS 17.0+ 或 macOS 14.0+
- Swift 6.0+
- Alamofire 5.6+
- SwiftyJSON 5.0+

## 许可证

MIT
