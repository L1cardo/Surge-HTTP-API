import Foundation

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
        case isGroup
        case name
        case typeDescription
        case lineHash
        case enabled
    }
}

// MARK: - 最近请求响应模型

/// 最近请求响应模型，用于表示 /v1/requests/recent 端点的响应数据
public struct RequestsResponse: Codable, Sendable {
    /// 请求数组
    public let requests: [Request]
    
    /// 初始化方法
    /// - Parameter requests: 请求数组
    public init(requests: [Request]) {
        self.requests = requests
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case requests
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
        case durationInMillisecond
    }
}

// MARK: - 请求模型

/// 请求模型，用于表示单个网络请求的详细信息
public struct Request: Codable, Sendable {
    /// 请求 ID
    public let id: Int
    /// 远程地址（可选）
    public let remoteAddress: String?
    /// 入站最大速度
    public let inMaxSpeed: Int
    /// 网络接口（可选）
    public let interface: String?
    /// 原始策略名称（可选）
    public let originalPolicyName: String?
    /// 注释数组
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
    /// 完成日期时间戳
    public let completedDate: Double
    /// 出站字节数
    public let outBytes: Int
    /// 源地址
    public let sourceAddress: String
    /// 本地地址（可选）
    public let localAddress: String?
    /// 是否为本地请求
    public let local: Bool
    /// 远程客户端物理地址（可选）
    public let remoteClientPhysicalAddress: String?
    /// 策略名称
    public let policyName: String?
    /// 入站字节数
    public let inBytes: Int
    /// 设备名称
    public let deviceName: String?
    /// 接管模式
    public let takeoverMode: Int
    /// 方法 (TCP/UDP等)
    public let method: String
    /// 是否为副本
    public let replica: Bool
    /// 进程 ID
    public let pid: Int
    /// 统计路径（可选）
    public let pathForStatistics: String?
    /// 备注（可选）
    public let remark: String?
    /// 规则（可选）
    public let rule: String?
    /// 开始日期时间戳
    public let startDate: Double
    /// 是否有响应体
    public let streamHasResponseBody: Bool
    /// 设置完成日期时间戳
    public let setupCompletedDate: Double
    /// URL
    public let url: String
    /// 进程路径（可选）
    public let processPath: String?
    /// 出站最大速度
    public let outMaxSpeed: Int
    /// 是否已修改
    public let modified: Bool
    /// 引擎标识符
    public let engineIdentifier: Int
    /// 是否被拒绝
    public let rejected: Bool
    /// 计时记录数组（可选）
    public let timingRecords: [RequestTimingRecord]?
    /// 远程主机
    public let remoteHost: String
    /// 是否有请求体
    public let streamHasRequestBody: Bool
    
    /// 初始化方法
    public init(
        id: Int,
        remoteAddress: String? = nil,
        inMaxSpeed: Int,
        interface: String? = nil,
        originalPolicyName: String? = nil,
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
        localAddress: String? = nil,
        local: Bool,
        remoteClientPhysicalAddress: String? = nil,
        policyName: String? = nil,
        inBytes: Int,
        deviceName: String? = nil,
        takeoverMode: Int,
        method: String,
        replica: Bool,
        pid: Int,
        pathForStatistics: String? = nil,
        remark: String? = nil,
        rule: String? = nil,
        startDate: Double,
        streamHasResponseBody: Bool,
        setupCompletedDate: Double,
        url: String,
        processPath: String? = nil,
        outMaxSpeed: Int,
        modified: Bool,
        engineIdentifier: Int,
        rejected: Bool,
        timingRecords: [RequestTimingRecord]? = nil,
        remoteHost: String,
        streamHasRequestBody: Bool
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
        self.local = local
        self.remoteClientPhysicalAddress = remoteClientPhysicalAddress
        self.policyName = policyName
        self.inBytes = inBytes
        self.deviceName = deviceName
        self.takeoverMode = takeoverMode
        self.method = method
        self.replica = replica
        self.pid = pid
        self.pathForStatistics = pathForStatistics
        self.remark = remark
        self.rule = rule
        self.startDate = startDate
        self.streamHasResponseBody = streamHasResponseBody
        self.setupCompletedDate = setupCompletedDate
        self.url = url
        self.processPath = processPath
        self.outMaxSpeed = outMaxSpeed
        self.modified = modified
        self.engineIdentifier = engineIdentifier
        self.rejected = rejected
        self.timingRecords = timingRecords
        self.remoteHost = remoteHost
        self.streamHasRequestBody = streamHasRequestBody
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case id
        case remoteAddress
        case inMaxSpeed
        case interface
        case originalPolicyName
        case notes
        case inCurrentSpeed
        case failed
        case status
        case outCurrentSpeed
        case completed
        case sourcePort
        case completedDate
        case outBytes
        case sourceAddress
        case localAddress
        case local
        case remoteClientPhysicalAddress
        case policyName
        case inBytes
        case deviceName
        case takeoverMode
        case method
        case replica
        case pid
        case pathForStatistics
        case remark
        case rule
        case startDate
        case streamHasResponseBody
        case setupCompletedDate
        case url = "URL"
        case processPath
        case outMaxSpeed
        case modified
        case engineIdentifier
        case rejected
        case timingRecords
        case remoteHost
        case streamHasRequestBody
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
        case originalProfile
        case name
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
        case dnsCache
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
        case timeCost
        case expiresTime
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

/// 脚本类型枚举
public enum ScriptType: String, Codable, Sendable {
    case httpRequest = "http-request"
    case httpResponse = "http-response"
    case cron
    case event
    case rule
    case dns
    case generic
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
        intValue = nil
    }
    
    init?(intValue: Int) {
        stringValue = "\(intValue)"
        self.intValue = intValue
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

// MARK: - 设备响应模型

/// 设备响应模型，用于表示 /v1/devices 端点的响应数据
public struct DevicesResponse: Codable, Sendable {
    /// 设备数组
    public let devices: [Device]
    
    /// 初始化方法
    /// - Parameter devices: 设备数组
    public init(devices: [Device]) {
        self.devices = devices
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case devices
    }
}

// MARK: - 字节统计模型

/// 字节统计模型，用于表示设备的流量统计信息
public struct BytesStat: Codable, Sendable {
    /// 5分钟内字节数
    public let m5: Int
    /// 15分钟内字节数
    public let m15: Int
    /// 1小时内字节数
    public let m60: Int
    /// 6小时内字节数
    public let h6: Int
    /// 12小时内字节数
    public let h12: Int
    /// 24小时内字节数
    public let h24: Int
    /// 今天字节数
    public let today: Int
    /// 本月字节数
    public let thisMonth: Int
    /// 上月字节数
    public let lastMonth: Int
    /// 总字节数
    public let total: Int
    
    /// 初始化方法
    public init(
        m5: Int,
        m15: Int,
        m60: Int,
        h6: Int,
        h12: Int,
        h24: Int,
        today: Int,
        thisMonth: Int,
        lastMonth: Int,
        total: Int
    ) {
        self.m5 = m5
        self.m15 = m15
        self.m60 = m60
        self.h6 = h6
        self.h12 = h12
        self.h24 = h24
        self.today = today
        self.thisMonth = thisMonth
        self.lastMonth = lastMonth
        self.total = total
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case m5
        case m15
        case m60
        case h6
        case h12
        case h24
        case today
        case thisMonth
        case lastMonth
        case total
    }
}

// MARK: - DHCP 设备模型

/// DHCP 设备模型，用于表示 DHCP 设备信息
public struct DHCPDevice: Codable, Sendable {
    /// 是否应由 Surge 处理
    public let shouldHandledBySurge: Bool
    /// 当前 IP 地址
    public let currentIP: String?
    /// 物理地址（MAC地址）
    public let physicalAddress: String?
    /// 是否由 Surge 处理
    public let handledBySurge: Bool
    /// 显示名称
    public let displayName: String?
    /// 是否等待重新连接
    public let waitingToReconnect: Bool
    /// DNS 名称
    public let dnsName: String?
    /// 图标
    public let icon: String?
    
    /// 初始化方法
    public init(
        shouldHandledBySurge: Bool,
        currentIP: String? = nil,
        physicalAddress: String? = nil,
        handledBySurge: Bool,
        displayName: String? = nil,
        waitingToReconnect: Bool,
        dnsName: String? = nil,
        icon: String? = nil
    ) {
        self.shouldHandledBySurge = shouldHandledBySurge
        self.currentIP = currentIP
        self.physicalAddress = physicalAddress
        self.handledBySurge = handledBySurge
        self.displayName = displayName
        self.waitingToReconnect = waitingToReconnect
        self.dnsName = dnsName
        self.icon = icon
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case shouldHandledBySurge
        case currentIP
        case physicalAddress
        case handledBySurge
        case displayName
        case waitingToReconnect
        case dnsName
        case icon
    }
}

// MARK: - 设备模型

/// 设备模型，用于表示网络中的设备信息
public struct Device: Codable, Sendable {
    /// DHCP 最后分配的 IP 地址
    public let dhcpLastIP: String?
    /// 显示的 IP 地址
    public let displayIPAddress: String
    /// 总字节数
    public let totalBytes: Int
    /// DHCP 网关是否启用
    public let dhcpGatewayEnabled: Bool
    /// 标识符（可能是 IP 地址或 MAC 地址）
    public let identifier: String
    /// 单个连接流量最高的主机
    public let topHostBySingleConnectionTraffic: String?
    /// 是否有 TCP 连接
    public let hasTCPConnection: Bool
    /// 入站字节统计
    public let inBytesStat: BytesStat
    /// 出站字节数
    public let outBytes: Int
    /// DHCP 图标
    public let dhcpIcon: String?
    /// 入站字节数
    public let inBytes: Int
    /// 设备名称
    public let name: String
    /// 当前入站速度
    public let currentInSpeed: Int
    /// 物理地址（MAC地址）
    public let physicalAddress: String?
    /// 当前出站速度
    public let currentOutSpeed: Int
    /// 活动连接数
    public let activeConnections: Int
    /// 厂商信息
    public let vendor: String?
    /// 出站字节统计
    public let outBytesStat: BytesStat
    /// DNS 名称
    public let dnsName: String?
    /// DHCP 是否等待重新连接
    public let dhcpWaitingToReconnect: Bool
    /// 总连接数
    public let totalConnections: Int
    /// 当前速度
    public let currentSpeed: Int
    /// DHCP 设备信息
    public let dhcpDevice: DHCPDevice?
    /// DHCP 最后出现时间戳
    public let dhcpLastSeenTimestamp: Int
    /// 是否有代理连接
    public let hasProxyConnection: Bool
    
    /// 初始化方法
    public init(
        dhcpLastIP: String? = nil,
        displayIPAddress: String,
        totalBytes: Int,
        dhcpGatewayEnabled: Bool,
        identifier: String,
        topHostBySingleConnectionTraffic: String? = nil,
        hasTCPConnection: Bool,
        inBytesStat: BytesStat,
        outBytes: Int,
        dhcpIcon: String? = nil,
        inBytes: Int,
        name: String,
        currentInSpeed: Int,
        physicalAddress: String? = nil,
        currentOutSpeed: Int,
        activeConnections: Int,
        vendor: String? = nil,
        outBytesStat: BytesStat,
        dnsName: String? = nil,
        dhcpWaitingToReconnect: Bool,
        totalConnections: Int,
        currentSpeed: Int,
        dhcpDevice: DHCPDevice? = nil,
        dhcpLastSeenTimestamp: Int,
        hasProxyConnection: Bool
    ) {
        self.dhcpLastIP = dhcpLastIP
        self.displayIPAddress = displayIPAddress
        self.totalBytes = totalBytes
        self.dhcpGatewayEnabled = dhcpGatewayEnabled
        self.identifier = identifier
        self.topHostBySingleConnectionTraffic = topHostBySingleConnectionTraffic
        self.hasTCPConnection = hasTCPConnection
        self.inBytesStat = inBytesStat
        self.outBytes = outBytes
        self.dhcpIcon = dhcpIcon
        self.inBytes = inBytes
        self.name = name
        self.currentInSpeed = currentInSpeed
        self.physicalAddress = physicalAddress
        self.currentOutSpeed = currentOutSpeed
        self.activeConnections = activeConnections
        self.vendor = vendor
        self.outBytesStat = outBytesStat
        self.dnsName = dnsName
        self.dhcpWaitingToReconnect = dhcpWaitingToReconnect
        self.totalConnections = totalConnections
        self.currentSpeed = currentSpeed
        self.dhcpDevice = dhcpDevice
        self.dhcpLastSeenTimestamp = dhcpLastSeenTimestamp
        self.hasProxyConnection = hasProxyConnection
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case dhcpLastIP
        case displayIPAddress
        case totalBytes
        case dhcpGatewayEnabled
        case identifier
        case topHostBySingleConnectionTraffic
        case hasTCPConnection
        case inBytesStat
        case outBytes
        case dhcpIcon
        case inBytes
        case name
        case currentInSpeed
        case physicalAddress
        case currentOutSpeed
        case activeConnections
        case vendor
        case outBytesStat
        case dnsName
        case dhcpWaitingToReconnect
        case totalConnections
        case currentSpeed
        case dhcpDevice
        case dhcpLastSeenTimestamp
        case hasProxyConnection
    }
}

// MARK: - 事件响应模型

/// 事件响应模型，用于表示 /v1/events 端点的响应数据
public struct EventsResponse: Codable, Sendable {
    /// 事件数组
    public let events: [Event]
    
    /// 初始化方法
    /// - Parameter events: 事件数组
    public init(events: [Event]) {
        self.events = events
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case events
    }
}

// MARK: - 事件模型

/// 事件模型，用于表示事件中心的单个事件
public struct Event: Codable, Sendable {
    /// 事件标识符
    public let identifier: String
    /// 事件日期
    public let date: String
    /// 事件类型
    public let type: Int
    /// 是否允许关闭
    public let allowDismiss: Bool
    /// 事件内容
    public let content: String
    
    /// 初始化方法
    public init(
        identifier: String,
        date: String,
        type: Int,
        allowDismiss: Bool,
        content: String
    ) {
        self.identifier = identifier
        self.date = date
        self.type = type
        self.allowDismiss = allowDismiss
        self.content = content
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case identifier
        case date
        case type
        case allowDismiss
        case content
    }
}

// MARK: - 规则响应模型

/// 规则响应模型，用于表示 /v1/rules 端点的响应数据
public struct RulesResponse: Codable, Sendable {
    /// 规则数组
    public let rules: [String]
    /// 可用策略数组
    public let availablePolicies: [String]
    
    /// 初始化方法
    /// - Parameters:
    ///   - rules: 规则数组
    ///   - availablePolicies: 可用策略数组
    public init(rules: [String], availablePolicies: [String]) {
        self.rules = rules
        self.availablePolicies = availablePolicies
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case rules
        case availablePolicies = "available-policies"
    }
}

// MARK: - 流量统计模型

/// 流量统计模型，用于表示单个连接器或接口的流量信息
public struct TrafficStat: Codable, Sendable {
    /// 当前入站速度
    public let inCurrentSpeed: Int
    /// 当前出站速度
    public let outCurrentSpeed: Int
    /// 入站总字节数
    public let `in`: Int
    /// 出站总字节数
    public let out: Int
    /// 入站最大速度
    public let inMaxSpeed: Int
    /// 出站最大速度
    public let outMaxSpeed: Int
    /// 行哈希值（仅连接器）
    public let lineHash: String?
    
    /// 初始化方法
    public init(
        inCurrentSpeed: Int,
        outCurrentSpeed: Int,
        in: Int,
        out: Int,
        inMaxSpeed: Int,
        outMaxSpeed: Int,
        lineHash: String? = nil
    ) {
        self.inCurrentSpeed = inCurrentSpeed
        self.outCurrentSpeed = outCurrentSpeed
        self.in = `in`
        self.out = out
        self.inMaxSpeed = inMaxSpeed
        self.outMaxSpeed = outMaxSpeed
        self.lineHash = lineHash
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case inCurrentSpeed
        case outCurrentSpeed
        case `in`
        case out
        case inMaxSpeed
        case outMaxSpeed
        case lineHash
    }
}

// MARK: - 流量响应模型

/// 流量响应模型，用于表示 /v1/traffic 端点的响应数据
public struct TrafficResponse: Codable, Sendable {
    /// 连接器流量统计字典
    public let connector: [String: TrafficStat]
    /// 开始时间戳
    public let startTime: Double
    /// 网络接口流量统计字典
    public let interface: [String: TrafficStat]
    
    /// 初始化方法
    public init(
        connector: [String: TrafficStat],
        startTime: Double,
        interface: [String: TrafficStat]
    ) {
        self.connector = connector
        self.startTime = startTime
        self.interface = interface
    }
    
    /// 编码键值
    enum CodingKeys: String, CodingKey {
        case connector
        case startTime
        case interface
    }
}

// MARK: - 日志级别枚举

/// 日志级别枚举，用于表示不同的日志详细程度
public enum LogLevel: String, Sendable {
    /// 详细级别 - 输出所有日志信息
    case verbose
    /// 信息级别 - 输出一般信息和警告
    case info
    /// 警告级别 - 只输出警告和错误
    case warning
    /// 通知级别 - 只输出通知信息
    case notify
}
