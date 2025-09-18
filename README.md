# Surge HTTP API Swift Package

一个用于调用 Surge HTTP API 的 Swift Package，支持 Surge iOS 4.4.0+ 和 Mac 4.0.0+ 版本。

所有 API 均来自 [Surge 官方手册](https://manual.nssurge.com/others/http-api.html)

**注意：此包已更新为使用现代 async/await 语法，并支持最新的 iOS 17+ 和 macOS 14+ 平台版本。**

[![Swift](https://img.shields.io/badge/Swift-6.0-orange.svg)](https://swift.org)
[![Platforms](https://img.shields.io/badge/Platforms-iOS%2017%2B%20%7C%20macOS%2014%2B-blue.svg)](https://developer.apple.com/platforms/)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://github.com/L1cardo/Surge-HTTP-API/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/L1cardo/Surge-HTTP-API.svg?style=social&label=Star&maxAge=2592000)](https://GitHub.com/L1cardo/Surge-HTTP-API/stargazers/)

## 目录

- [功能特性](#功能特性)
- [安装](#安装)
- [使用方法](#使用方法)
- [支持的 API 端点](#支持的-api-端点)
  - [连通性测试](#连通性测试)
  - [功能切换](#功能切换)
  - [出站模式](#出站模式)
  - [代理策略](#代理策略)
  - [请求管理](#请求管理)
  - [配置文件 (仅 Mac 4.0.6+)](#配置文件-仅-mac-406)
  - [DNS](#dns)
  - [模块](#模块)
  - [脚本](#脚本)
  - [设备管理 (仅 Mac 4.0.6+)](#设备管理-仅-mac-406)
  - [杂项](#杂项)
- [数据模型](#数据模型)
- [要求](#要求)
- [许可证](#许可证)

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
    .package(url: "https://github.com/L1cardo/Surge-HTTP-API.git", from: "1.0.0")
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

## 支持的 API 端点

### 连通性测试

测试与 Surge 的连接状态

- `testConnectivity()` - 测试连通性，使用 GET /v1/outbound

使用示例：
```swift
Task {
    do {
        let isConnected = try await surgeClient.testConnectivity()
        print("Surge 连接状态: \(isConnected ? "已连接" : "未连接")")
    } catch {
        print("连接测试失败: \(error)")
    }
}
```

### 功能切换

控制 Surge 的各种功能模块

- `getMITMState()` - 获取 MITM 功能状态，使用 GET /v1/features/mitm
- `setMITMState(enabled:)` - 设置 MITM 功能状态，使用 POST /v1/features/mitm
- `getCaptureState()` - 获取 Capture 功能状态，使用 GET /v1/features/capture
- `setCaptureState(enabled:)` - 设置 Capture 功能状态，使用 POST /v1/features/capture
- `getRewriteState()` - 获取 Rewrite 功能状态，使用 GET /v1/features/rewrite
- `setRewriteState(enabled:)` - 设置 Rewrite 功能状态，使用 POST /v1/features/rewrite
- `getScriptingState()` - 获取 Scripting 功能状态，使用 GET /v1/features/scripting
- `setScriptingState(enabled:)` - 设置 Scripting 功能状态，使用 POST /v1/features/scripting
- `getSystemProxyState()` - 获取 System Proxy 功能状态 (仅 Mac)，使用 GET /v1/features/system_proxy
- `setSystemProxyState(enabled:)` - 设置 System Proxy 功能状态 (仅 Mac)，使用 POST /v1/features/system_proxy
- `getEnhancedModeState()` - 获取 Enhanced Mode 功能状态 (仅 Mac)，使用 GET /v1/features/enhanced_mode
- `setEnhancedModeState(enabled:)` - 设置 Enhanced Mode 功能状态 (仅 Mac)，使用 POST /v1/features/enhanced_mode

使用示例：
```swift
// 获取和设置 MITM 状态
Task {
    do {
        let mitmEnabled = try await surgeClient.getMITMState()
        print("MITM 当前状态: \(mitmEnabled)")
        
        // 切换 MITM 状态
        try await surgeClient.setMITMState(enabled: !mitmEnabled)
        print("MITM 状态已更新")
    } catch {
        print("操作失败: \(error)")
    }
}

// 获取和设置其他功能状态
Task {
    do {
        let captureEnabled = try await surgeClient.getCaptureState()
        let rewriteEnabled = try await surgeClient.getRewriteState()
        let scriptingEnabled = try await surgeClient.getScriptingState()
        
        print("Capture: \(captureEnabled), Rewrite: \(rewriteEnabled), Scripting: \(scriptingEnabled)")
    } catch {
        print("获取功能状态失败: \(error)")
    }
}
```

### 出站模式

控制 Surge 的出站模式和全局策略

- `getOutboundMode()` - 获取出站模式，使用 GET /v1/outbound
- `setOutboundMode(mode:)` - 设置出站模式，使用 POST /v1/outbound
- `getGlobalPolicy()` - 获取全局出站策略，使用 GET /v1/outbound/global
- `setGlobalPolicy(policy:)` - 设置全局出站策略，使用 POST /v1/outbound/global

使用示例：
```swift
// 获取和设置出站模式
Task {
    do {
        let mode = try await surgeClient.getOutboundMode()
        print("当前出站模式: \(mode)")
        
        // 设置为规则模式
        try await surgeClient.setOutboundMode(mode: "rule")
        print("出站模式已设置为 rule")
    } catch {
        print("操作失败: \(error)")
    }
}

// 获取和设置全局策略
Task {
    do {
        let globalPolicy = try await surgeClient.getGlobalPolicy()
        print("当前全局策略: \(globalPolicy)")
        
        // 设置全局策略
        try await surgeClient.setGlobalPolicy(policy: "Proxy")
        print("全局策略已设置为 Proxy")
    } catch {
        print("操作失败: \(error)")
    }
}
```

### 代理策略

管理和测试代理策略及策略组

- `getPolicies()` - 列出所有策略，使用 GET /v1/policies
- `getPolicyDetail(policyName:)` - 获取策略详情，使用 GET /v1/policies/detail
- `testPolicies(policyNames:url:)` - 测试策略，使用 POST /v1/policies/test
- `getPolicyGroups()` - 列出所有策略组及其选项，使用 GET /v1/policy_groups
- `getPolicyGroupTestResults()` - 获取策略组测试结果，使用 GET /v1/policy_groups/test_results
- `getPolicyGroupSelection(groupName:)` - 获取选择策略组的所选项，使用 GET /v1/policy_groups/select
- `setPolicyGroupSelection(groupName:policy:)` - 更改选择策略组的选项，使用 POST /v1/policy_groups/select
- `testPolicyGroup(groupName:)` - 立即测试策略组，使用 POST /v1/policy_groups/test

使用示例：
```swift
// 获取所有策略
Task {
    do {
        let policies = try await surgeClient.getPolicies()
        print("代理策略: \(policies.proxies)")
        print("策略组: \(policies.policyGroups)")
    } catch {
        print("获取策略失败: \(error)")
    }
}

// 测试策略
Task {
    do {
        let results = try await surgeClient.testPolicies(
            policyNames: ["Proxy", "Direct"], 
            url: "http://www.google.com"
        )
        
        for (policyName, result) in results {
            print("策略 \(policyName):")
            print("  TCP 延迟: \(result.tcp)ms")
            print("  可用性: \(result.available ? "可用" : "不可用")")
        }
    } catch {
        print("策略测试失败: \(error)")
    }
}

// 管理策略组
Task {
    do {
        // 获取策略组选项
        let selectedPolicy = try await surgeClient.getPolicyGroupSelection(groupName: "Proxy Group")
        print("策略组当前选择: \(selectedPolicy)")
        
        // 更改策略组选项
        try await surgeClient.setPolicyGroupSelection(
            groupName: "Proxy Group", 
            policy: "New Proxy"
        )
        print("策略组选项已更新")
    } catch {
        print("策略组操作失败: \(error)")
    }
}
```

### 请求管理

管理和查看网络请求

- `getRecentRequests()` - 列出最近的请求，使用 GET /v1/requests/recent
- `getActiveRequests()` - 列出所有活动请求，使用 GET /v1/requests/active
- `killRequest(id:)` - 终止活动请求，使用 POST /v1/requests/kill

使用示例：
```swift
// 获取最近的请求
Task {
    do {
        let requests = try await surgeClient.getRecentRequests()
        print("最近 \(requests.count) 个请求:")
        
        for request in requests.prefix(5) {  // 只显示前5个
            print("  URL: \(request.url)")
            print("  方法: \(request.method)")
            print("  状态: \(request.status)")
        }
    } catch {
        print("获取请求失败: \(error)")
    }
}

// 终止请求
Task {
    do {
        try await surgeClient.killRequest(id: 12345)
        print("请求 #12345 已终止")
    } catch {
        print("终止请求失败: \(error)")
    }
}
```

### 配置文件 (仅 Mac 4.0.6+)

管理 Surge 配置文件

- `getCurrentProfile(sensitive:)` - 获取当前配置文件内容，使用 GET /v1/profiles/current
- `reloadProfile()` - 立即重新加载配置文件，使用 POST /v1/profiles/reload
- `switchProfile(name:)` - 切换到另一个配置文件，使用 POST /v1/profiles/switch
- `getAvailableProfiles()` - 获取所有可用的配置文件名称，使用 GET /v1/profiles
- `checkProfile(name:)` - 检查配置文件，使用 POST /v1/profiles/check

使用示例：
```swift
// 获取当前配置文件
Task {
    do {
        let profile = try await surgeClient.getCurrentProfile(sensitive: false)
        print("当前配置文件: \(profile.name)")
        print("配置内容长度: \(profile.profile.count) 字符")
    } catch {
        print("获取配置文件失败: \(error)")
    }
}

// 管理配置文件
Task {
    do {
        // 获取可用配置文件
        let profiles = try await surgeClient.getAvailableProfiles()
        print("可用配置文件: \(profiles)")
        
        // 切换配置文件
        if !profiles.isEmpty {
            try await surgeClient.switchProfile(name: profiles[0])
            print("已切换到配置文件: \(profiles[0])")
        }
        
        // 重新加载配置文件
        try await surgeClient.reloadProfile()
        print("配置文件已重新加载")
    } catch {
        print("配置文件操作失败: \(error)")
    }
}
```

### DNS

管理 DNS 缓存和测试

- `flushDNS()` - 刷新 DNS 缓存，使用 POST /v1/dns/flush
- `getDNSCache()` - 获取当前 DNS 缓存内容，使用 GET /v1/dns
- `testDNSDelay()` - 测试 DNS 延迟，使用 POST /v1/test/dns_delay

使用示例：
```swift
// DNS 操作
Task {
    do {
        // 刷新 DNS 缓存
        try await surgeClient.flushDNS()
        print("DNS 缓存已刷新")
        
        // 获取 DNS 缓存
        let dnsCache = try await surgeClient.getDNSCache()
        print("本地 DNS 记录数: \(dnsCache.local.count)")
        print("DNS 缓存记录数: \(dnsCache.dnsCache.count)")
        
        // 测试 DNS 延迟
        let delay = try await surgeClient.testDNSDelay()
        print("DNS 延迟: \(delay)ms")
    } catch {
        print("DNS 操作失败: \(error)")
    }
}
```

### 模块

管理 Surge 模块

- `getModules()` - 列出可用和已启用的模块，使用 GET /v1/modules
- `setModule(moduleName:enabled:)` - 启用或禁用模块，使用 POST /v1/modules

使用示例：
```swift
// 模块管理
Task {
    do {
        // 获取模块状态
        let modules = try await surgeClient.getModules()
        print("已启用模块: \(modules.enabled)")
        print("可用模块: \(modules.available)")
        
        // 启用/禁用模块
        if !modules.available.isEmpty {
            let moduleName = modules.available[0]
            try await surgeClient.setModule(moduleName: moduleName, enabled: true)
            print("模块 \(moduleName) 已启用")
        }
    } catch {
        print("模块操作失败: \(error)")
    }
}
```

### 脚本

管理和执行脚本

- `getScripts()` - 列出所有脚本，使用 GET /v1/scripting
- `evaluateScript(scriptText:mockType:timeout:)` - 执行脚本，使用 POST /v1/scripting/evaluate
- `evaluateCronScript(scriptName:)` - 立即执行 Cron 脚本，使用 POST /v1/scripting/cron/evaluate

使用示例：
```swift
// 脚本管理
Task {
    do {
        // 获取脚本列表
        let scripts = try await surgeClient.getScripts()
        print("脚本数量: \(scripts.count)")
        
        for script in scripts {
            print("  脚本: \(script.name) (类型: \(script.type.rawValue))")
        }
        
        // 执行脚本
        let output = try await surgeClient.evaluateScript(
            scriptText: "console.log('Hello from Surge'); return 'Success';",
            mockType: "http-request",
            timeout: 5.0
        )
        print("脚本输出: \(output)")
    } catch {
        print("脚本操作失败: \(error)")
    }
}
```

### 设备管理 (仅 Mac 4.0.6+)

管理网络设备

- `getDevices()` - 获取当前活动和保存的设备列表，使用 GET /v1/devices
- `updateDevice(physicalAddress:name:address:shouldHandledBySurge:)` - 更改设备属性，使用 POST /v1/devices

使用示例：
```swift
// 设备管理
Task {
    do {
        // 获取设备列表
        let devices = try await surgeClient.getDevices()
        print("设备数量: \(devices.count)")
        
        for device in devices {
            print("  设备: \(device.name ?? "未知")")
            print("    IP: \(device.displayIPAddress)")
            print("    MAC: \(device.physicalAddress ?? "未知")")
        }
        
        // 更新设备属性
        if !devices.isEmpty, let macAddress = devices[0].physicalAddress {
            let error = try await surgeClient.updateDevice(
                physicalAddress: macAddress,
                name: "My Device",
                shouldHandledBySurge: true
            )
            
            if error.isEmpty {
                print("设备属性已更新")
            } else {
                print("设备更新失败: \(error)")
            }
        }
    } catch {
        print("设备操作失败: \(error)")
    }
}
```

### 杂项

其他功能

- `stopSurge()` - 关闭 Surge 引擎，使用 POST /v1/stop
- `getEvents()` - 获取事件中心内容，使用 GET /v1/events
- `getRules()` - 获取规则列表，使用 GET /v1/rules
- `getTraffic()` - 获取流量信息，使用 GET /v1/traffic
- `setLogLevel(level:)` - 更改当前会话的日志级别，使用 POST /v1/log/level
- `getMITMCACertificate()` - 获取 MITM 的 CA 证书 (DER 二进制格式)，使用 GET /v1/mitm/ca

使用示例：
```swift
// 杂项功能
Task {
    do {
        // 获取事件
        let events = try await surgeClient.getEvents()
        print("事件数量: \(events.count)")
        
        // 获取规则
        let rules = try await surgeClient.getRules()
        print("规则数量: \(rules.rules.count)")
        print("可用策略: \(rules.availablePolicies)")
        
        // 获取流量信息
        let traffic = try await surgeClient.getTraffic()
        print("连接器数量: \(traffic.connector.count)")
        print("接口数量: \(traffic.interface.count)")
        
        // 设置日志级别
        try await surgeClient.setLogLevel(level: .info)
        print("日志级别已设置为 info")
        
        // 获取 CA 证书
        let certificateData = try await surgeClient.getMITMCACertificate()
        print("CA 证书大小: \(certificateData.count) 字节")
    } catch {
        print("杂项操作失败: \(error)")
    }
}
```

## 数据模型

本项目提供了完整的数据模型来解析 Surge HTTP API 的响应：

- `PoliciesResponse` - 策略列表响应模型
- `SinglePolicyTestResult` - 单个策略测试结果模型
- `PolicyGroupItem` - 策略组策略项模型
- `RequestsResponse` - 最近请求响应模型
- `RequestTimingRecord` - 请求计时记录模型
- `Request` - 请求模型
- `ProfileResponse` - 配置文件响应模型
- `DNSCacheResponse` - DNS 缓存响应模型
- `LocalDNSRecord` - 本地 DNS 记录模型
- `DNSCacheRecord` - DNS 缓存记录模型
- `ScriptsResponse` - 脚本响应模型
- `Script` - 脚本模型
- `ScriptType` - 脚本类型枚举
- `ModulesState` - 模块状态模型
- `DevicesResponse` - 设备响应模型
- `BytesStat` - 字节统计模型
- `DHCPDevice` - DHCP 设备模型
- `Device` - 设备模型
- `EventsResponse` - 事件响应模型
- `Event` - 事件模型
- `RulesResponse` - 规则响应模型
- `TrafficStat` - 流量统计模型
- `TrafficResponse` - 流量响应模型
- `LogLevel` - 日志级别枚举

## 要求

- iOS 17.0+ 或 macOS 14.0+
- Swift 6.0+
- Alamofire 5.6+
- SwiftyJSON 5.0+

## Star 趋势图

[![Stargazers over time](https://starchart.cc/L1cardo/Surge-HTTP-API.svg)](https://starchart.cc/L1cardo/Surge-HTTP-API)

## 许可证

MIT
