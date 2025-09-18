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

// MARK: - 策略列表响应模型
/// 策略列表响应模型，用于表示 /v1/policies 端点的响应数据
public struct PoliciesResponse: Codable, Sendable {
    /// 代理策略列表
    public let proxies: [String]
    /// 策略组列表
    public let policyGroups: [String]
    
    /// 初始化方法
    /// - Parameters:
    ///   - proxies: 代理策略列表
    ///   - policyGroups: 策略组列表
    public init(proxies: [String], policyGroups: [String]) {
        self.proxies = proxies
        self.policyGroups = policyGroups
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case proxies
        case policyGroups = "policy-groups"
    }
}

// MARK: - 单个策略测试结果模型
/// 单个策略测试结果模型，用于表示单个策略的测试结果
///
/// 该模型包含单个策略测试的结果，其中 tfo 是布尔类型，其他都是整数类型。
public struct SinglePolicyTestResult: Codable, Sendable {
    /// tfo 测试结果（布尔类型）
    public let tfo: Bool
    /// tcp 延迟（整数类型，毫秒）
    public let tcp: Int
    /// receive 延迟（整数类型，毫秒）
    public let receive: Int
    /// available 延迟（整数类型，毫秒）
    public let available: Int
    /// round-one-total 延迟（整数类型，毫秒）
    public let roundOneTotal: Int
    
    /// 初始化方法
    /// - Parameters:
    ///   - tfo: tfo 测试结果
    ///   - tcp: tcp 延迟
    ///   - receive: receive 延迟
    ///   - available: available 延迟
    ///   - roundOneTotal: round-one-total 延迟
    public init(tfo: Bool, tcp: Int, receive: Int, available: Int, roundOneTotal: Int) {
        self.tfo = tfo
        self.tcp = tcp
        self.receive = receive
        self.available = available
        self.roundOneTotal = roundOneTotal
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case tfo
        case tcp
        case receive
        case available
        case roundOneTotal = "round-one-total"
    }
}

// MARK: - 策略组策略项模型
/// 策略组策略项模型，用于表示策略组中的单个策略项
public struct PolicyGroupItem: Codable, Sendable {
    /// 是否为策略组
    public let isGroup: Bool
    /// 策略名称
    public let name: String
    /// 类型描述
    public let typeDescription: String
    /// 行哈希值
    public let lineHash: String
    /// 是否启用
    public let enabled: Bool
    
    /// 初始化方法
    /// - Parameters:
    ///   - isGroup: 是否为策略组
    ///   - name: 策略名称
    ///   - typeDescription: 类型描述
    ///   - lineHash: 行哈希值
    ///   - enabled: 是否启用
    public init(isGroup: Bool, name: String, typeDescription: String, lineHash: String, enabled: Bool) {
        self.isGroup = isGroup
        self.name = name
        self.typeDescription = typeDescription
        self.lineHash = lineHash
        self.enabled = enabled
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case isGroup = "isGroup"
        case name
        case typeDescription = "typeDescription"
        case lineHash = "lineHash"
        case enabled
    }
}

// MARK: - 请求计时记录模型
/// 请求计时记录模型，用于表示请求处理过程中的各个阶段耗时
public struct RequestTimingRecord: Codable, Sendable {
    /// 阶段名称
    public let name: String
    /// 持续时间（秒）
    public let duration: Double
    /// 持续时间（毫秒）
    public let durationInMillisecond: Int
    
    /// 初始化方法
    /// - Parameters:
    ///   - name: 阶段名称
    ///   - duration: 持续时间（秒）
    ///   - durationInMillisecond: 持续时间（毫秒）
    public init(name: String, duration: Double, durationInMillisecond: Int) {
        self.name = name
        self.duration = duration
        self.durationInMillisecond = durationInMillisecond
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case name
        case duration
        case durationInMillisecond = "durationInMillisecond"
    }
}

// MARK: - 配置文件响应模型
/// 配置文件响应模型，用于表示 /v1/profiles/current 端点的响应数据
public struct ProfileResponse: Codable, Sendable {
    /// 配置文件内容
    public let profile: String
    /// 原始配置文件内容
    public let originalProfile: String
    /// 配置文件名称
    public let name: String
    
    /// 初始化方法
    /// - Parameters:
    ///   - profile: 配置文件内容
    ///   - originalProfile: 原始配置文件内容
    ///   - name: 配置文件名称
    public init(profile: String, originalProfile: String, name: String) {
        self.profile = profile
        self.originalProfile = originalProfile
        self.name = name
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case profile
        case originalProfile = "originalProfile"
        case name
    }
}

// MARK: - 本地 DNS 记录模型
/// 本地 DNS 记录模型，用于表示本地 DNS 缓存中的单个记录
public struct LocalDNSRecord: Codable, Sendable {
    /// IP 地址数据
    public let data: String
    /// 注释（可选）
    public let comment: String?
    /// 域名
    public let domain: String
    /// 来源（可选）
    public let source: String?
    /// 服务器（可选）
    public let server: String?
    
    /// 初始化方法
    /// - Parameters:
    ///   - data: IP 地址数据
    ///   - comment: 注释
    ///   - domain: 域名
    ///   - source: 来源
    ///   - server: 服务器
    public init(data: String, comment: String?, domain: String, source: String?, server: String?) {
        self.data = data
        self.comment = comment
        self.domain = domain
        self.source = source
        self.server = server
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case data
        case comment
        case domain
        case source
        case server
    }
}

// MARK: - DNS 缓存记录模型
/// DNS 缓存记录模型，用于表示 DNS 缓存中的单个记录
public struct DNSCacheRecord: Codable, Sendable {
    /// 域名
    public let domain: String
    /// 服务器 URL
    public let server: String
    /// 日志信息数组
    public let logs: [String]
    /// IP 地址数据数组
    public let data: [String]
    /// 路径
    public let path: String
    /// 耗时（秒）
    public let timeCost: Double
    /// 过期时间戳
    public let expiresTime: Double
    
    /// 初始化方法
    /// - Parameters:
    ///   - domain: 域名
    ///   - server: 服务器 URL
    ///   - logs: 日志信息数组
    ///   - data: IP 地址数据数组
    ///   - path: 路径
    ///   - timeCost: 耗时（秒）
    ///   - expiresTime: 过期时间戳
    public init(domain: String, server: String, logs: [String], data: [String], path: String, timeCost: Double, expiresTime: Double) {
        self.domain = domain
        self.server = server
        self.logs = logs
        self.data = data
        self.path = path
        self.timeCost = timeCost
        self.expiresTime = expiresTime
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case domain
        case server
        case logs
        case data
        case path
        case timeCost = "timeCost"
        case expiresTime = "expiresTime"
    }
}

// MARK: - DNS 缓存响应模型
/// DNS 缓存响应模型，用于表示 /v1/dns 端点的响应数据
public struct DNSCacheResponse: Codable, Sendable {
    /// 本地 DNS 记录数组
    public let local: [LocalDNSRecord]
    /// DNS 缓存记录数组
    public let dnsCache: [DNSCacheRecord]
    
    /// 初始化方法
    /// - Parameters:
    ///   - local: 本地 DNS 记录数组
    ///   - dnsCache: DNS 缓存记录数组
    public init(local: [LocalDNSRecord], dnsCache: [DNSCacheRecord]) {
        self.local = local
        self.dnsCache = dnsCache
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case local
        case dnsCache = "dnsCache"
    }
}

/// 脚本类型枚举
public enum ScriptType: String, Codable, Sendable {
    case httpRequest = "http-request"
    case httpResponse = "http-response"
    case cron = "cron"
    case event = "event"
    case rule = "rule"
    case dns = "dns"
    case generic = "generic"
}

// MARK: - 脚本模型
/// 脚本模型，用于表示单个脚本的信息
public struct Script: Sendable {
    /// 脚本路径
    public let path: String
    /// 是否启用
    public let enabled: Bool
    /// 脚本名称
    public let name: String
    /// 脚本类型
    public let type: ScriptType
    /// 脚本参数
    public let parameters: [String: Sendable]
    
    /// 初始化方法
    public init(path: String, enabled: Bool, name: String, type: ScriptType, parameters: [String: Sendable]) {
        self.path = path
        self.enabled = enabled
        self.name = name
        self.type = type
        self.parameters = parameters
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case path
        case enabled
        case name
        case type
        case parameters
    }
}

// MARK: - Script Codable 实现
extension Script: Codable {
    public init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<Script.CodingKeys> = try decoder.container(keyedBy: CodingKeys.self)
        path = try container.decode(String.self, forKey: .path)
        enabled = try container.decode(Bool.self, forKey: .enabled)
        name = try container.decode(String.self, forKey: .name)
        type = try container.decode(ScriptType.self, forKey: .type)
        
        // 解码 parameters 为字典，保持原始类型
        let parametersContainer = try container.nestedContainer(keyedBy: DynamicKey.self, forKey: .parameters)
        var parametersDict: [String: Sendable] = [:]
        
        for key in parametersContainer.allKeys {
            // 尝试解码为不同类型的值
            if let value = try? parametersContainer.decode(Bool.self, forKey: key) {
                parametersDict[key.stringValue] = value
            } else if let value = try? parametersContainer.decode(Int.self, forKey: key) {
                parametersDict[key.stringValue] = value
            } else if let value = try? parametersContainer.decode(Double.self, forKey: key) {
                parametersDict[key.stringValue] = value
            } else if let value = try? parametersContainer.decode(String.self, forKey: key) {
                parametersDict[key.stringValue] = value
            } else {
                // 如果所有类型都失败，存储为 nil
                parametersDict[key.stringValue] = nil
            }
        }
        
        parameters = parametersDict
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(path, forKey: .path)
        try container.encode(enabled, forKey: .enabled)
        try container.encode(name, forKey: .name)
        try container.encode(type, forKey: .type)
        
        // 创建动态键容器来编码 parameters
        var parametersContainer = container.nestedContainer(keyedBy: DynamicKey.self, forKey: .parameters)
        for (key, value) in parameters {
            let dynamicKey = DynamicKey(stringValue: key)!
            if let boolValue = value as? Bool {
                try parametersContainer.encode(boolValue, forKey: dynamicKey)
            } else if let intValue = value as? Int {
                try parametersContainer.encode(intValue, forKey: dynamicKey)
            } else if let doubleValue = value as? Double {
                try parametersContainer.encode(doubleValue, forKey: dynamicKey)
            } else if let stringValue = value as? String {
                try parametersContainer.encode(stringValue, forKey: dynamicKey)
            }
        }
    }
}

// MARK: - 动态键
/// 动态键，用于处理未知键名的编码/解码
struct DynamicKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = "\(intValue)"
        self.intValue = intValue
    }
}

// MARK: - 脚本响应模型
/// 脚本响应模型，用于表示 /v1/scripting 端点的响应数据
public struct ScriptsResponse: Codable, Sendable {
    /// 脚本数组
    public let scripts: [Script]
    
    /// 初始化方法
    public init(scripts: [Script]) {
        self.scripts = scripts
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case scripts
    }
}

// MARK: - 请求模型
/// 请求模型，用于表示单个网络请求的详细信息
public struct Request: Codable, Sendable {
    /// 请求ID
    public let id: Int
    /// 远程地址
    public let remoteAddress: String
    /// 入站最大速度
    public let inMaxSpeed: Int
    /// 网络接口
    public let interface: String
    /// 原始策略名称
    public let originalPolicyName: String
    /// 注释列表
    public let notes: [String]
    /// 入站当前速度
    public let inCurrentSpeed: Int
    /// 是否失败
    public let failed: Bool
    /// 状态
    public let status: String
    /// 出站当前速度
    public let outCurrentSpeed: Int
    /// 是否完成
    public let completed: Bool
    /// 源端口
    public let sourcePort: Int
    /// 完成时间戳
    public let completedDate: Double
    /// 出站字节数
    public let outBytes: Int
    /// 源地址
    public let sourceAddress: String
    /// 本地地址
    public let localAddress: String
    /// 请求头
    public let requestHeader: String
    /// 是否为本地请求
    public let local: Bool
    /// 策略名称
    public let policyName: String
    /// 入站字节数
    public let inBytes: Int
    /// 设备名称
    public let deviceName: String
    /// 副本目录路径
    public let replicaDirectoryPath: String?
    /// 接管模式
    public let takeoverMode: Int
    /// 请求方法
    public let method: String
    /// 是否有副本
    public let replica: Bool
    /// 进程ID
    public let pid: Int
    /// 统计路径
    public let pathForStatistics: String?
    /// 规则
    public let rule: String
    /// 开始时间戳
    public let startDate: Double
    /// 是否有响应体
    public let streamHasResponseBody: Bool
    /// 设置完成时间戳
    public let setupCompletedDate: Double
    /// URL
    public let url: String
    /// 进程路径
    public let processPath: String?
    /// 出站最大速度
    public let outMaxSpeed: Int
    /// 是否已修改
    public let modified: Bool
    /// 响应头
    public let responseHeader: String?
    /// 是否被拒绝
    public let rejected: Bool
    /// 引擎标识符
    public let engineIdentifier: Int
    /// 计时记录列表
    public let timingRecords: [RequestTimingRecord]
    /// 远程主机
    public let remoteHost: String
    /// 是否有请求体
    public let streamHasRequestBody: Bool
    /// 备注（仅在某些情况下存在）
    public let remark: String?
    /// 远程客户端物理地址（仅在某些情况下存在）
    public let remoteClientPhysicalAddress: String?
    
    /// 初始化方法
    /// - Parameters:
    ///   - id: 请求ID
    ///   - remoteAddress: 远程地址
    ///   - inMaxSpeed: 入站最大速度
    ///   - interface: 网络接口
    ///   - originalPolicyName: 原始策略名称
    ///   - notes: 注释列表
    ///   - inCurrentSpeed: 入站当前速度
    ///   - failed: 是否失败
    ///   - status: 状态
    ///   - outCurrentSpeed: 出站当前速度
    ///   - completed: 是否完成
    ///   - sourcePort: 源端口
    ///   - completedDate: 完成时间戳
    ///   - outBytes: 出站字节数
    ///   - sourceAddress: 源地址
    ///   - localAddress: 本地地址
    ///   - requestHeader: 请求头
    ///   - local: 是否为本地请求
    ///   - policyName: 策略名称
    ///   - inBytes: 入站字节数
    ///   - deviceName: 设备名称
    ///   - replicaDirectoryPath: 副本目录路径
    ///   - takeoverMode: 接管模式
    ///   - method: 请求方法
    ///   - replica: 是否有副本
    ///   - pid: 进程ID
    ///   - pathForStatistics: 统计路径
    ///   - rule: 规则
    ///   - startDate: 开始时间戳
    ///   - streamHasResponseBody: 是否有响应体
    ///   - setupCompletedDate: 设置完成时间戳
    ///   - url: URL
    ///   - processPath: 进程路径
    ///   - outMaxSpeed: 出站最大速度
    ///   - modified: 是否已修改
    ///   - responseHeader: 响应头
    ///   - rejected: 是否被拒绝
    ///   - engineIdentifier: 引擎标识符
    ///   - timingRecords: 计时记录列表
    ///   - remoteHost: 远程主机
    ///   - streamHasRequestBody: 是否有请求体
    ///   - remark: 备注
    ///   - remoteClientPhysicalAddress: 远程客户端物理地址
    public init(
        id: Int,
        remoteAddress: String,
        inMaxSpeed: Int,
        interface: String,
        originalPolicyName: String,
        notes: [String],
        inCurrentSpeed: Int,
        failed: Bool,
        status: String,
        outCurrentSpeed: Int,
        completed: Bool,
        sourcePort: Int,
        completedDate: Double,
        outBytes: Int,
        sourceAddress: String,
        localAddress: String,
        requestHeader: String,
        local: Bool,
        policyName: String,
        inBytes: Int,
        deviceName: String,
        replicaDirectoryPath: String?,
        takeoverMode: Int,
        method: String,
        replica: Bool,
        pid: Int,
        pathForStatistics: String?,
        rule: String,
        startDate: Double,
        streamHasResponseBody: Bool,
        setupCompletedDate: Double,
        url: String,
        processPath: String?,
        outMaxSpeed: Int,
        modified: Bool,
        responseHeader: String?,
        rejected: Bool,
        engineIdentifier: Int,
        timingRecords: [RequestTimingRecord],
        remoteHost: String,
        streamHasRequestBody: Bool,
        remark: String? = nil,
        remoteClientPhysicalAddress: String? = nil
    ) {
        self.id = id
        self.remoteAddress = remoteAddress
        self.inMaxSpeed = inMaxSpeed
        self.interface = interface
        self.originalPolicyName = originalPolicyName
        self.notes = notes
        self.inCurrentSpeed = inCurrentSpeed
        self.failed = failed
        self.status = status
        self.outCurrentSpeed = outCurrentSpeed
        self.completed = completed
        self.sourcePort = sourcePort
        self.completedDate = completedDate
        self.outBytes = outBytes
        self.sourceAddress = sourceAddress
        self.localAddress = localAddress
        self.requestHeader = requestHeader
        self.local = local
        self.policyName = policyName
        self.inBytes = inBytes
        self.deviceName = deviceName
        self.replicaDirectoryPath = replicaDirectoryPath
        self.takeoverMode = takeoverMode
        self.method = method
        self.replica = replica
        self.pid = pid
        self.pathForStatistics = pathForStatistics
        self.rule = rule
        self.startDate = startDate
        self.streamHasResponseBody = streamHasResponseBody
        self.setupCompletedDate = setupCompletedDate
        self.url = url
        self.processPath = processPath
        self.outMaxSpeed = outMaxSpeed
        self.modified = modified
        self.responseHeader = responseHeader
        self.rejected = rejected
        self.engineIdentifier = engineIdentifier
        self.timingRecords = timingRecords
        self.remoteHost = remoteHost
        self.streamHasRequestBody = streamHasRequestBody
        self.remark = remark
        self.remoteClientPhysicalAddress = remoteClientPhysicalAddress
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case id
        case remoteAddress = "remoteAddress"
        case inMaxSpeed = "inMaxSpeed"
        case interface
        case originalPolicyName = "originalPolicyName"
        case notes
        case inCurrentSpeed = "inCurrentSpeed"
        case failed
        case status
        case outCurrentSpeed = "outCurrentSpeed"
        case completed
        case sourcePort = "sourcePort"
        case completedDate = "completedDate"
        case outBytes = "outBytes"
        case sourceAddress = "sourceAddress"
        case localAddress = "localAddress"
        case requestHeader = "requestHeader"
        case local
        case policyName = "policyName"
        case inBytes = "inBytes"
        case deviceName = "deviceName"
        case replicaDirectoryPath = "replicaDirectoryPath"
        case takeoverMode = "takeoverMode"
        case method
        case replica
        case pid
        case pathForStatistics = "pathForStatistics"
        case rule
        case startDate = "startDate"
        case streamHasResponseBody = "streamHasResponseBody"
        case setupCompletedDate = "setupCompletedDate"
        case url = "URL"
        case processPath = "processPath"
        case outMaxSpeed = "outMaxSpeed"
        case modified
        case responseHeader = "responseHeader"
        case rejected
        case engineIdentifier = "engineIdentifier"
        case timingRecords = "timingRecords"
        case remoteHost = "remoteHost"
        case streamHasRequestBody = "streamHasRequestBody"
        case remark
        case remoteClientPhysicalAddress = "remoteClientPhysicalAddress"
    }
}
