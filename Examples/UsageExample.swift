import Foundation
import SurgeHTTPAPI

@main
struct SurgeCompleteUsageExample {
    static func main() async throws {
        // 初始化客户端
        let surgeAPI = SurgeHTTPAPI.shared
        
        // 保存配置（只需执行一次）
        surgeAPI.saveConfiguration(baseURL: "http://127.0.0.1:6171", apiKey: "your-api-key")
        
        // 获取配置信息
        let currentBaseURL = surgeAPI.getBaseURL()
        let currentAPIKey = surgeAPI.getAPIKey()
        print("当前 baseURL: \(currentBaseURL)")
        print("当前 apiKey: \(currentAPIKey)")
        
        try await runConnectivityExample(surgeAPI)
        try await runFeatureToggleExample(surgeAPI)
        try await runOutboundModeExample(surgeAPI)
        try await runProxyPolicyExample(surgeAPI)
        try await runPolicyGroupExample(surgeAPI)
        try await runProfileExample(surgeAPI)
        try await runDNSExample(surgeAPI)
        try await runModuleExample(surgeAPI)
        try await runMiscExample(surgeAPI)
    }
    
    // MARK: - 连通性测试示例
    static func runConnectivityExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 测试与 Surge 的连接
            let isConnected = try await surgeAPI.testConnectivity()
            print("与 Surge 连接正常: \(isConnected)")
        } catch {
            // 详细错误处理
            print("与 Surge 连接失败: \(error)")
            print("错误类型: \(type(of: error))")
            
            // 检查是否为网络连接错误
            if let nsError = error as NSError? {
                if nsError.domain == NSURLErrorDomain {
                    print("网络错误代码: \(nsError.code)")
                    print("网络错误描述: \(nsError.localizedDescription)")
                }
            }
        }
    }
    
    // MARK: - 功能切换示例
    static func runFeatureToggleExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 获取和设置 MITM 状态
            let mitmState = try await surgeAPI.getMITMState()
            print("MITM 状态: \(mitmState.enabled)")
            
            try await surgeAPI.setMITMState(enabled: true)
            print("MITM 状态设置成功")
        } catch {
            print("MITM 操作失败: \(error)")
            // 错误处理...
        }
        
        do {
            // 获取和设置 Capture 状态
            let captureState = try await surgeAPI.getCaptureState()
            print("Capture 状态: \(captureState.enabled)")
            
            try await surgeAPI.setCaptureState(enabled: false)
            print("Capture 状态设置成功")
        } catch {
            print("Capture 操作失败: \(error)")
            // 同样的错误处理方式...
        }
    }
    
    // MARK: - 出站模式示例
    static func runOutboundModeExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 获取和设置出站模式
            let outboundMode = try await surgeAPI.getOutboundMode()
            print("当前出站模式: \(outboundMode.mode)")
            
            let newMode = try await surgeAPI.setOutboundMode(mode: "rule")
            print("新出站模式: \(newMode.mode)")
        } catch {
            print("出站模式操作失败: \(error)")
            // 错误处理...
        }
    }
    
    // MARK: - 代理策略示例
    static func runProxyPolicyExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 列出所有策略
            let policies = try await surgeAPI.getPolicies()
            print("代理策略列表: \(policies.proxies)")
            print("策略组列表: \(policies.policyGroups)")
        } catch {
            print("获取策略列表失败: \(error)")
            // 错误处理...
        }
        
        do {
            // 获取策略详情
            let policyDetail = try await surgeAPI.getPolicyDetail(policyName: "ProxyNameHere")
            print("策略名称: \(policyDetail.policyName)")
            print("策略详情: \(policyDetail.detail)")
        } catch {
            print("获取策略详情失败: \(error)")
            // 错误处理...
        }
        
        do {
            // 测试策略
            let testRequest = PolicyTestRequest(
                policyNames: ["🎯直连", "⛔️Reject"], 
                url: "http://bing.com"
            )
            let results = try await surgeAPI.testPolicies(request: testRequest)
            print("策略测试结果:")
            for (policyName, result) in results {
                print("策略: \(policyName)")
                print("  tfo: \(result.tfo)")
                print("  tcp: \(result.tcp)ms")
                print("  receive: \(result.receive)ms")
                print("  available: \(result.available)ms")
                print("  round-one-total: \(result.roundOneTotal)ms")
            }
        } catch {
            print("策略测试失败: \(error)")
            // 错误处理...
        }
    }
    
    // MARK: - 策略组示例
    static func runPolicyGroupExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 获取策略组选项
            let selection = try await surgeAPI.getPolicyGroupSelection(groupName: "GroupA")
            print("策略组选择: \(selection.policy)")
            
            // 设置策略组选项
            let selectRequest = PolicyGroupSelectRequest(groupName: "GroupA", policy: "ProxyA")
            let newSelection = try await surgeAPI.setPolicyGroupSelection(request: selectRequest)
            print("新策略组选择: \(newSelection.policy)")
        } catch {
            print("策略组操作失败: \(error)")
            // 错误处理...
        }
        
        do {
            // 获取所有策略组及其选项
            let policyGroups = try await surgeAPI.getPolicyGroups()
            print("策略组列表:")
            for (groupName, items) in policyGroups.policyGroups {
                print("  策略组: \(groupName)")
                for item in items {
                    print("    - 名称: \(item.name)")
                    print("      类型: \(item.typeDescription)")
                    print("      启用: \(item.enabled)")
                    print("      是策略组: \(item.isGroup)")
                }
            }
        } catch {
            print("获取策略组列表失败: \(error)")
            // 错误处理...
        }
        
        do {
            // 获取策略组测试结果
            let testResults = try await surgeAPI.getPolicyGroupTestResults()
            print("策略组测试结果:")
            for (groupName, policyNames) in testResults.testResults {
                print("  策略组: \(groupName)")
                for policyName in policyNames {
                    print("    - 策略: \(policyName)")
                }
            }
        } catch {
            print("获取策略组测试结果失败: \(error)")
            // 错误处理...
        }
    }
    
    // MARK: - 配置文件示例 (仅 Mac)
    static func runProfileExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 获取当前配置文件
            let profile = try await surgeAPI.getCurrentProfile(sensitive: false)
            print("当前配置文件: \(profile)")
            
            // 重新加载配置文件
            try await surgeAPI.reloadProfile()
            print("配置文件重新加载成功")
        } catch {
            print("配置文件操作失败: \(error)")
            // 错误处理...
        }
    }
    
    // MARK: - DNS 示例
    static func runDNSExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 刷新 DNS 缓存
            try await surgeAPI.flushDNS()
            print("DNS 缓存刷新成功")
            
            // 获取 DNS 缓存
            let dnsCache = try await surgeAPI.getDNSCache()
            print("DNS 缓存: \(dnsCache)")
        } catch {
            print("DNS 操作失败: \(error)")
            // 错误处理...
        }
    }
    
    // MARK: - 模块示例
    static func runModuleExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 获取模块状态
            let modules = try await surgeAPI.getModules()
            print("已启用模块: \(modules.enabled)")
            print("可用模块: \(modules.available)")
            
            // 启用模块
            let updatedModules = try await surgeAPI.setModule(moduleName: "TestModule", enabled: true)
            print("模块更新后状态: \(updatedModules.enabled)")
        } catch {
            print("模块操作失败: \(error)")
            // 错误处理...
        }
    }
    
    // MARK: - 杂项示例
    static func runMiscExample(_ surgeAPI: SurgeHTTPAPI) async throws {
        do {
            // 获取流量信息
            let traffic = try await surgeAPI.getTraffic()
            print("流量信息: \(traffic)")
            
            // 获取规则列表
            let rules = try await surgeAPI.getRules()
            print("规则列表: \(rules)")
            
            // 设置日志级别
            let logLevelRequest = LogLevelRequest(level: "verbose")
            try await surgeAPI.setLogLevel(request: logLevelRequest)
            print("日志级别设置成功")
        } catch {
            print("杂项操作失败: \(error)")
            // 错误处理...
        }
    }
}
