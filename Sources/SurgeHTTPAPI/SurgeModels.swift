import Foundation

// MARK: - 基础响应模型
/// 通用响应模型，用于解析简单的 API 响应
public struct SimpleResponse: Codable, Sendable {
    /// 功能是否启用
    public let enabled: Bool?
    /// 模式
    public let mode: String?
    /// 策略
    public let policy: String?
    /// 错误信息
    public let error: String?
    
    /// 初始化方法
    /// - Parameters:
    ///   - enabled: 功能是否启用
    ///   - mode: 模式
    ///   - policy: 策略
    ///   - error: 错误信息
    public init(enabled: Bool? = nil, mode: String? = nil, policy: String? = nil, error: String? = nil) {
        self.enabled = enabled
        self.mode = mode
        self.policy = policy
        self.error = error
    }
}

// MARK: - 功能状态模型
/// 功能状态模型，用于表示某个功能的启用状态
public struct FeatureState: Codable, Sendable {
    /// 功能是否启用
    public let enabled: Bool
    
    /// 初始化方法
    /// - Parameter enabled: 功能是否启用
    public init(enabled: Bool) {
        self.enabled = enabled
    }
}

// MARK: - 出站模式模型
/// 出站模式模型，用于表示当前的出站模式
public struct OutboundMode: Codable, Sendable {
    /// 出站模式 (direct, proxy, rule)
    public let mode: String
    
    /// 初始化方法
    /// - Parameter mode: 出站模式
    public init(mode: String) {
        self.mode = mode
    }
}

// MARK: - 全局出站策略模型
/// 全局出站策略模型，用于表示全局默认的代理策略
public struct GlobalPolicy: Codable, Sendable {
    /// 策略名称
    public let policy: String
    
    /// 初始化方法
    /// - Parameter policy: 策略名称
    public init(policy: String) {
        self.policy = policy
    }
}

// MARK: - 策略组选择模型
/// 策略组选择模型，用于表示当前选中的策略
public struct PolicyGroupSelection: Codable, Sendable {
    /// 选中的策略名称
    public let policy: String
    
    /// 初始化方法
    /// - Parameter policy: 选中的策略名称
    public init(policy: String) {
        self.policy = policy
    }
}

// MARK: - 策略组测试结果模型
/// 策略组测试结果模型，用于表示策略组的测试结果
public struct PolicyGroupTestResult: Codable, Sendable {
    /// 可用的策略列表
    public let available: [String]
    
    /// 初始化方法
    /// - Parameter available: 可用的策略列表
    public init(available: [String]) {
        self.available = available
    }
}

// MARK: - 模块状态模型
/// 模块状态模型，用于表示模块的启用和可用状态
public struct ModulesState: Codable, Sendable {
    /// 已启用的模块列表
    public let enabled: [String]
    /// 可用的模块列表
    public let available: [String]
    
    /// 初始化方法
    /// - Parameters:
    ///   - enabled: 已启用的模块列表
    ///   - available: 可用的模块列表
    public init(enabled: [String], available: [String]) {
        self.enabled = enabled
        self.available = available
    }
}

// MARK: - 模块切换参数模型
/// 模块切换参数模型，用于启用或禁用模块
public struct ModuleToggle: Codable, Sendable {
    /// 模块名称
    public let moduleName: String
    /// 是否启用
    public let enabled: Bool
    
    /// 初始化方法
    /// - Parameters:
    ///   - moduleName: 模块名称
    ///   - enabled: 是否启用
    public init(moduleName: String, enabled: Bool) {
        self.moduleName = moduleName
        self.enabled = enabled
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case moduleName = "module_name"
        case enabled
    }
}

// MARK: - 请求杀死参数模型
/// 请求杀死参数模型，用于杀死指定的活动请求
public struct KillRequest: Codable, Sendable {
    /// 请求 ID
    public let id: Int
    
    /// 初始化方法
    /// - Parameter id: 请求 ID
    public init(id: Int) {
        self.id = id
    }
}

// MARK: - 策略测试参数模型
/// 策略测试参数模型，用于测试多个策略的连通性
public struct PolicyTestRequest: Codable, Sendable {
    /// 要测试的策略名称列表
    public let policyNames: [String]
    /// 测试 URL
    public let url: String
    
    /// 初始化方法
    /// - Parameters:
    ///   - policyNames: 要测试的策略名称列表
    ///   - url: 测试 URL
    public init(policyNames: [String], url: String) {
        self.policyNames = policyNames
        self.url = url
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case policyNames = "policy_names"
        case url
    }
}

// MARK: - 策略组选择参数模型
/// 策略组选择参数模型，用于更改策略组的选择
public struct PolicyGroupSelectRequest: Codable, Sendable {
    /// 策略组名称
    public let groupName: String
    /// 要选择的策略名称
    public let policy: String
    
    /// 初始化方法
    /// - Parameters:
    ///   - groupName: 策略组名称
    ///   - policy: 要选择的策略名称
    public init(groupName: String, policy: String) {
        self.groupName = groupName
        self.policy = policy
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
        case policy
    }
}

// MARK: - 策略组测试参数模型
/// 策略组测试参数模型，用于立即测试策略组
public struct PolicyGroupTestRequest: Codable, Sendable {
    /// 策略组名称
    public let groupName: String
    
    /// 初始化方法
    /// - Parameter groupName: 策略组名称
    public init(groupName: String) {
        self.groupName = groupName
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case groupName = "group_name"
    }
}

// MARK: - 配置切换参数模型
/// 配置切换参数模型，用于切换到指定的配置文件
public struct ProfileSwitchRequest: Codable, Sendable {
    /// 配置文件名称
    public let name: String
    
    /// 初始化方法
    /// - Parameter name: 配置文件名称
    public init(name: String) {
        self.name = name
    }
}

// MARK: - 日志级别参数模型
/// 日志级别参数模型，用于更改当前会话的日志级别
public struct LogLevelRequest: Codable, Sendable {
    /// 日志级别 (verbose, info, warning, error)
    public let level: String
    
    /// 初始化方法
    /// - Parameter level: 日志级别
    public init(level: String) {
        self.level = level
    }
}

// MARK: - 脚本评估参数模型
/// 脚本评估参数模型，用于评估脚本
public struct ScriptEvaluateRequest: Codable, Sendable {
    /// 脚本文本
    public let scriptText: String
    /// 模拟类型
    public let mockType: String?
    /// 超时时间（秒）
    public let timeout: Int?
    
    /// 初始化方法
    /// - Parameters:
    ///   - scriptText: 脚本文本
    ///   - mockType: 模拟类型
    ///   - timeout: 超时时间（秒）
    public init(scriptText: String, mockType: String? = nil, timeout: Int? = nil) {
        self.scriptText = scriptText
        self.mockType = mockType
        self.timeout = timeout
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case scriptText = "script_text"
        case mockType = "mock_type"
        case timeout
    }
}

// MARK: - Cron脚本评估参数模型
/// Cron脚本评估参数模型，用于立即评估 Cron 脚本
public struct CronScriptEvaluateRequest: Codable, Sendable {
    /// 脚本名称
    public let scriptName: String
    
    /// 初始化方法
    /// - Parameter scriptName: 脚本名称
    public init(scriptName: String) {
        self.scriptName = scriptName
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case scriptName = "script_name"
    }
}

// MARK: - 设备管理参数模型
/// 设备管理参数模型，用于更新设备属性
public struct DeviceUpdateRequest: Codable, Sendable {
    /// 物理地址（MAC地址）
    public let physicalAddress: String
    /// 设备名称
    public let name: String?
    /// IP地址
    public let address: String?
    /// 是否由 Surge 处理
    public let shouldHandledBySurge: Bool?
    
    /// 初始化方法
    /// - Parameters:
    ///   - physicalAddress: 物理地址（MAC地址）
    ///   - name: 设备名称
    ///   - address: IP地址
    ///   - shouldHandledBySurge: 是否由 Surge 处理
    public init(physicalAddress: String, name: String? = nil, address: String? = nil, shouldHandledBySurge: Bool? = nil) {
        self.physicalAddress = physicalAddress
        self.name = name
        self.address = address
        self.shouldHandledBySurge = shouldHandledBySurge
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case physicalAddress = "physicalAddress"
        case name
        case address
        case shouldHandledBySurge = "shouldHandledBySurge"
    }
}
