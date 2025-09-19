import Alamofire
import SwiftyJSON
import Foundation
import Defaults

/// Surge HTTP API 客户端
///
/// 用于与 Surge 的 HTTP API 进行交互，支持所有 Surge 提供的 API 端点。
/// 使用单例模式，通过 UserDefaults 存储配置信息。
public final class SurgeHTTPAPI: Sendable {
    private let baseURL: String
    private let apiKey: String
    private let session: Session

    /// 单例实例
    ///
    /// 使用共享实例可以避免重复配置，推荐在应用中使用此实例。
    public static let shared = SurgeHTTPAPI()

    /// 私有初始化方法，从 UserDefaults 读取配置
    ///
    /// 从 UserDefaults 中读取 baseURL 和 apiKey 配置。
    /// 如果没有配置，则使用默认值。
    private init() {
        self.baseURL = Defaults[.baseURL]
        self.apiKey = Defaults[.apiKey]

        // 创建自定义 Session 并设置超时时间为 10 秒
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10.0
        configuration.timeoutIntervalForResource = 10.0
        self.session = Session(configuration: configuration)
    }
    
    /// 保存配置到 UserDefaults
    ///
    /// - Parameters:
    ///   - baseURL: Surge HTTP API 的完整基础 URL (例如: "http://127.0.0.1:6171")
    ///   - apiKey: API 密钥 (在 Surge 配置文件中设置)
    public func saveConfiguration(baseURL: String, apiKey: String) {
        Defaults[.baseURL] = baseURL
        Defaults[.apiKey] = apiKey
    }

    /// 获取当前配置的 baseURL
    ///
    /// - Returns: 当前配置的 baseURL
    public func getBaseURL() -> String {
        return baseURL
    }

    /// 获取当前配置的 apiKey
    ///
    /// - Returns: 当前配置的 apiKey
    public func getAPIKey() -> String {
        return apiKey
    }
    
    // MARK: - Private Methods

    /// 创建带有认证头的请求
    ///
    /// - Parameters:
    ///   - url: 请求的完整 URL
    ///   - method: HTTP 方法，默认为 .get
    ///   - parameters: 请求参数，默认为 nil
    /// - Returns: 配置好的 DataRequest 对象
    private func request(_ url: String, method: HTTPMethod = .get, parameters: [String: Sendable]? = nil) -> DataRequest {
        let headers: HTTPHeaders = [
            "X-Key": apiKey
        ]

        return session.request(
            url,
            method: method,
            parameters: parameters,
            encoding: method == .get ? URLEncoding.default : JSONEncoding.default,
            headers: headers
        )
    }
    
    /// 执行请求并处理响应 (用于 Decodable 对象)
    ///
    /// - Parameter request: 要执行的 DataRequest 对象
    /// - Returns: 解析后的 Decodable 对象
    /// - Throws: 网络错误或解析错误
    private func performDecodableRequest<T: Decodable & Sendable>(_ request: DataRequest) async throws -> T {
        // 使用 Alamofire 的并发支持
        let dataTask = request.serializingDecodable(T.self)
        return try await dataTask.value
    }

    /// 执行请求并返回JSON响应
    ///
    /// - Parameter request: 要执行的 DataRequest 对象
    /// - Returns: 解析后的 JSON 对象
    /// - Throws: 网络错误或解析错误
    private func performJSONRequest(_ request: DataRequest) async throws -> JSON {
        let dataTask = request.serializingData()
        let data = try await dataTask.value
        return try JSON(data: data)
    }

    /// 执行请求不处理响应内容
    ///
    /// - Parameter request: 要执行的 DataRequest 对象
    /// - Throws: 网络错误
    private func performVoidRequest(_ request: DataRequest) async throws {
        let dataTask = request.serializingData()
        _ = try await dataTask.value
    }

    /// 执行请求并返回二进制数据响应
    ///
    /// - Parameter request: 要执行的 DataRequest 对象
    /// - Returns: 响应的二进制数据
    /// - Throws: 网络错误
    private func performDataRequest(_ request: DataRequest) async throws -> Data {
        let dataTask = request.serializingData()
        return try await dataTask.value
    }

    // MARK: - Connectivity Test (连通性测试)

    /// 测试连通性
    /// 使用 GET /v1/outbound 测试与 Surge 的连接
    /// - Returns: 如果能成功返回结果，则说明连接正常；否则抛出异常
    /// - Throws: 连接失败时抛出原始错误
    public func testConnectivity() async throws -> Bool {
        do {
            _ = try await getOutboundMode()
            return true
        } catch {
            throw error
        }
    }
    
    // MARK: - Toggle capabilities (功能切换)
    
    /// 获取 MITM 功能状态
    /// GET /v1/features/mitm
    public func getMITMState() async throws -> Bool {
        return try await getFeatureState(feature: "mitm")
    }
    
    /// 设置 MITM 功能状态
    /// POST /v1/features/mitm
    public func setMITMState(enabled: Bool) async throws {
        try await setFeatureState(feature: "mitm", enabled: enabled)
    }
    
    /// 获取 Capture 功能状态
    /// GET /v1/features/capture
    public func getCaptureState() async throws -> Bool {
        return try await getFeatureState(feature: "capture")
    }
    
    /// 设置 Capture 功能状态
    /// POST /v1/features/capture
    public func setCaptureState(enabled: Bool) async throws {
        try await setFeatureState(feature: "capture", enabled: enabled)
    }
    
    /// 获取 Rewrite 功能状态
    /// GET /v1/features/rewrite
    public func getRewriteState() async throws -> Bool {
        return try await getFeatureState(feature: "rewrite")
    }
    
    /// 设置 Rewrite 功能状态
    /// POST /v1/features/rewrite
    public func setRewriteState(enabled: Bool) async throws {
        try await setFeatureState(feature: "rewrite", enabled: enabled)
    }
    
    /// 获取 Scripting 功能状态
    /// GET /v1/features/scripting
    public func getScriptingState() async throws -> Bool {
        return try await getFeatureState(feature: "scripting")
    }
    
    /// 设置 Scripting 功能状态
    /// POST /v1/features/scripting
    public func setScriptingState(enabled: Bool) async throws {
        try await setFeatureState(feature: "scripting", enabled: enabled)
    }
    
    /// 获取 System Proxy 功能状态 (仅 Mac)
    /// GET /v1/features/system_proxy
    public func getSystemProxyState() async throws -> Bool {
        return try await getFeatureState(feature: "system_proxy")
    }
    
    /// 设置 System Proxy 功能状态 (仅 Mac)
    /// POST /v1/features/system_proxy
    public func setSystemProxyState(enabled: Bool) async throws {
        try await setFeatureState(feature: "system_proxy", enabled: enabled)
    }
    
    /// 获取 Enhanced Mode 功能状态 (仅 Mac)
    /// GET /v1/features/enhanced_mode
    public func getEnhancedModeState() async throws -> Bool {
        return try await getFeatureState(feature: "enhanced_mode")
    }
    
    /// 设置 Enhanced Mode 功能状态 (仅 Mac)
    /// POST /v1/features/enhanced_mode
    public func setEnhancedModeState(enabled: Bool) async throws {
        try await setFeatureState(feature: "enhanced_mode", enabled: enabled)
    }
    
    // MARK: - Private Feature Methods
    
    /// 获取功能状态的通用方法
    /// - Parameter feature: 功能名称
    /// - Returns: 功能是否启用
    private func getFeatureState(feature: String) async throws -> Bool {
        let url = "\(baseURL)/v1/features/\(feature)"
        let request = self.request(url)
        let json = try await performJSONRequest(request)
        return json["enabled"].boolValue
    }

    /// 设置功能状态的通用方法
    /// - Parameters:
    ///   - feature: 功能名称
    ///   - enabled: 是否启用
    private func setFeatureState(feature: String, enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/\(feature)"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    // MARK: - Outbound Mode (出站模式)
    
    /// 获取出站模式
    /// GET /v1/outbound
    public func getOutboundMode() async throws -> String {
        let url = "\(baseURL)/v1/outbound"
        let request = self.request(url)
        let json = try await performJSONRequest(request)
        return json["mode"].stringValue
    }
    
    /// 设置出站模式
    /// POST /v1/outbound
    public func setOutboundMode(mode: String) async throws {
        let url = "\(baseURL)/v1/outbound"
        let parameters = ["mode": mode]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performVoidRequest(request)
    }
    
    /// 获取全局出站策略
    /// GET /v1/outbound/global
    public func getGlobalPolicy() async throws -> String {
        let url = "\(baseURL)/v1/outbound/global"
        let request = self.request(url)
        let json = try await performJSONRequest(request)
        return json["policy"].stringValue
    }
    
    /// 设置全局出站策略
    /// POST /v1/outbound/global
    public func setGlobalPolicy(policy: String) async throws {
        let url = "\(baseURL)/v1/outbound/global"
        let parameters = ["policy": policy]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performVoidRequest(request)
    }
    
    // MARK: - Proxy Policy (代理策略)
    
    /// 列出所有策略
    /// GET /v1/policies
    public func getPolicies() async throws -> PoliciesResponse {
        let url = "\(baseURL)/v1/policies"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 获取策略详情
    /// GET /v1/policies/detail?policy_name=ProxyNameHere
    public func getPolicyDetail(policyName: String) async throws -> String {
        let url = "\(baseURL)/v1/policies/detail"
        let parameters = ["policy_name": policyName]
        let request = self.request(url, parameters: parameters)
        let json = try await performJSONRequest(request)
        return json[policyName].stringValue
    }
    
    /// 测试策略
    /// POST /v1/policies/test
    public func testPolicies(policyNames: [String], url: String) async throws -> [String: SinglePolicyTestResult] {
        let url = "\(baseURL)/v1/policies/test"
        let parameters: [String: Sendable] = [
            "policy_names": policyNames,
            "url": url
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        let json = try await performJSONRequest(request)
        
        // 如果响应为空，返回空字典
        guard !json.isEmpty else {
            return [:]
        }
        
        // 解析响应数据
        var results: [String: SinglePolicyTestResult] = [:]
        
        // 遍历 JSON 响应中的所有键值对
        for (policyName, value) in json {
            // 直接访问字段值，不使用可选绑定
            let tfo = value["tfo"].boolValue
            let tcp = value["tcp"].intValue
            let receive = value["receive"].intValue
            let available = value["available"].intValue
            let roundOneTotal = value["round-one-total"].intValue
            
            let singleResult = SinglePolicyTestResult (
                tfo: tfo,
                tcp: tcp,
                receive: receive,
                available: available,
                roundOneTotal: roundOneTotal
            )
            results[policyName] = singleResult
        }
        
        return results
    }
    
    /// 列出所有策略组及其选项
    /// GET /v1/policy_groups
    public func getPolicyGroups() async throws -> [String: [PolicyGroupItem]] {
        let url = "\(baseURL)/v1/policy_groups"
        let request = self.request(url)
        let json = try await performJSONRequest(request)
        
        // 解析 JSON 响应为策略组数据模型
        var policyGroups: [String: [PolicyGroupItem]] = [:]
        
        for (groupName, groupData) in json {
            var items: [PolicyGroupItem] = []
            
            // 遍历组中的每个策略项
            for item in groupData.arrayValue {
                let policyItem = PolicyGroupItem(
                    isGroup: item["isGroup"].boolValue,
                    name: item["name"].stringValue,
                    typeDescription: item["typeDescription"].stringValue,
                    lineHash: item["lineHash"].stringValue,
                    enabled: item["enabled"].boolValue
                )
                items.append(policyItem)
            }
            
            policyGroups[groupName] = items
        }
        
        return policyGroups
    }
    
    /// 获取url-test/fallback/load-balance策略组测试结果
    /// GET /v1/policy_groups/test_results
    public func getPolicyGroupTestResults() async throws -> [String: [String]] {
        let url = "\(baseURL)/v1/policy_groups/test_results"
        let request = self.request(url)
        let json = try await performJSONRequest(request)
        
        // 解析 JSON 响应为策略组测试结果数据模型
        var testResults: [String: [String]] = [:]
        
        for (groupName, groupData) in json {
            testResults[groupName] = groupData.arrayValue.map { $0.stringValue }
        }
        
        return testResults
    }
    
    /// 获取选择策略组的所选项
    /// GET /v1/policy_groups/select?group_name=GroupNameHere
    public func getPolicyGroupSelection(groupName: String) async throws -> String {
        let url = "\(baseURL)/v1/policy_groups/select"
        let parameters = ["group_name": groupName]
        let request = self.request(url, parameters: parameters)
        let json = try await performJSONRequest(request)
        return json["policy"].stringValue
    }
    
    /// 更改选择策略组的选项
    /// POST /v1/policy_groups/select
    public func setPolicyGroupSelection(groupName: String, policy: String) async throws{
        let url = "\(baseURL)/v1/policy_groups/select"
        let parameters = [
            "group_name": groupName,
            "policy": policy
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performVoidRequest(request)
    }
    
    /// 立即测试策略组
    /// POST /v1/policy_groups/test
    public func testPolicyGroup(groupName: String) async throws -> [String] {
        let url = "\(baseURL)/v1/policy_groups/test"
        let parameters = [
            "group_name": groupName
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        let json = try await performJSONRequest(request)
        return json["available"].arrayValue.map { $0.stringValue}
    }
    
    // MARK: - Requests (请求管理)
    
    /// 列出最近的请求
    /// GET /v1/requests/recent
    public func getRecentRequests() async throws -> [Request] {
        let url = "\(baseURL)/v1/requests/recent"
        let request = self.request(url)
        let response: RequestsResponse =  try await performDecodableRequest(request)
        return response.requests
    }

    /// 列出所有活动请求
    /// GET /v1/requests/active
    public func getActiveRequests() async throws -> [Request] {
        let url = "\(baseURL)/v1/requests/active"
        let request = self.request(url)
        let response: RequestsResponse =  try await performDecodableRequest(request)
        return response.requests
    }
    
    /// 终止活动请求
    /// POST /v1/requests/kill
    public func killRequest(id: Int) async throws {
        let url = "\(baseURL)/v1/requests/kill"
        let parameters = [
            "id": id
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    // MARK: - Profiles (配置文件)
    
    /// 获取当前配置文件内容
    /// GET /v1/profiles/current?sensitive=0
    public func getCurrentProfile(sensitive: Bool = true) async throws -> ProfileResponse {
        let url = "\(baseURL)/v1/profiles/current"
        let parameters = ["sensitive": sensitive ? 1 : 0]
        let request = self.request(url, parameters: parameters)
        return try await performDecodableRequest(request)
    }
    
    /// 立即重新加载配置文件
    /// POST /v1/profiles/reload
    public func reloadProfile() async throws {
        let url = "\(baseURL)/v1/profiles/reload"
        let request = self.request(url, method: .post)
        try await performVoidRequest(request)
    }
    
    /// 切换到另一个配置文件 (仅 Mac)
    /// POST /v1/profiles/switch
    public func switchProfile(name: String) async throws {
        let url = "\(baseURL)/v1/profiles/switch"
        let parameters: [String: String] = [
            "name": name
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performVoidRequest(request)
    }
    
    /// 获取所有可用的配置文件名称 (仅 Mac 4.0.6+)
    /// GET /v1/profiles
    public func getAvailableProfiles() async throws -> [String] {
        let url = "\(baseURL)/v1/profiles"
        let request = self.request(url)
        let json = try await performJSONRequest(request)
        return json["profiles"].arrayValue.map { $0.stringValue }
    }
    
    /// 检查配置文件 (仅 Mac 4.0.6+)
    /// POST /v1/profiles/check
    public func checkProfile(name: String) async throws -> String {
        let url = "\(baseURL)/v1/profiles/check"
        let parameters: [String: String] = [
            "name": name
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        let json = try await performJSONRequest(request)
        return json["error"].string ?? ""
    }
    
    // MARK: - DNS
    
    /// 刷新 DNS 缓存
    /// POST /v1/dns/flush
    public func flushDNS() async throws {
        let url = "\(baseURL)/v1/dns/flush"
        let request = self.request(url, method: .post)
        try await performVoidRequest(request)
    }
    
    /// 获取当前 DNS 缓存内容
    /// GET /v1/dns
    public func getDNSCache() async throws -> DNSCacheResponse {
        let url = "\(baseURL)/v1/dns"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 测试 DNS 延迟
    /// POST /v1/test/dns_delay
    public func testDNSDelay() async throws -> Double {
        let url = "\(baseURL)/v1/test/dns_delay"
        let request = self.request(url, method: .post)
        let json = try await performJSONRequest(request)
        return json["delay"].doubleValue
    }
    
    // MARK: - Modules (模块)
    
    /// 列出可用和已启用的模块
    /// GET /v1/modules
    public func getModules() async throws -> ModulesState {
        let url = "\(baseURL)/v1/modules"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 启用或禁用模块
    /// POST /v1/modules
    public func setModule(moduleName: String, enabled: Bool) async throws {
        let url = "\(baseURL)/v1/modules"
        let parameters = [moduleName: enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performVoidRequest(request)
    }
    
    // MARK: - Scripting (脚本)
    
    /// 列出所有脚本
    /// GET /v1/scripting
    public func getScripts() async throws -> [Script] {
        let url = "\(baseURL)/v1/scripting"
        let request = self.request(url)
        let response: ScriptsResponse = try await performDecodableRequest(request)
        return response.scripts
    }
    
    /// 执行脚本
    /// POST /v1/scripting/evaluate
    public func evaluateScript(scriptText: String, mockType: String, timeout: Double) async throws -> String {
        let url = "\(baseURL)/v1/scripting/evaluate"
        let parameters: [String: Sendable] = [
            "script_text": scriptText,
            "mock_type": mockType,
            "timeout": timeout
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        let response =  try await performJSONRequest(request)
        return response["output"].string ?? ""
    }
    
    /// 立即执行 Cron 脚本
    /// POST /v1/scripting/cron/evaluate
    public func evaluateCronScript(scriptName: String) async throws -> String {
        let url = "\(baseURL)/v1/scripting/cron/evaluate"
        let parameters: [String: String] = [
            "script_name": scriptName
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        let response =  try await performJSONRequest(request)
        return response["output"].string ?? ""
    }
    
    // MARK: - Device Management (设备管理) (仅 Mac 4.0.6+)
    
    /// 获取当前活动和保存的设备列表
    /// GET /v1/devices
    public func getDevices() async throws -> [Device] {
        let url = "\(baseURL)/v1/devices"
        let request = self.request(url)
        let response: DevicesResponse =  try await performDecodableRequest(request)
        return response.devices
    }

    // Todo: 无法获取，可能 Surge API 有所改变
    // /// 获取设备图标
    // /// GET /v1/devices/icon?id={iconID}
    // public func getDeviceIcon(iconID: String) async throws -> Data {
    //     let url = "\(baseURL)/v1/devices/icon"
    //     let parameters = ["id": iconID]
    //     let request = self.request(url, parameters: parameters)
    //     let response: DevicesResponse =  try await performDecodableRequest(request)
    //     return response
    // }
    
    /// 更改设备属性
    /// POST /v1/devices
    public func updateDevice(physicalAddress: String, name: String? = nil, address: String? = nil, shouldHandledBySurge: Bool? = nil) async throws -> String {
        let url = "\(baseURL)/v1/devices"
        var parameters: [String: Sendable] = [
            "physicalAddress": physicalAddress
        ]

        if let name = name {
            parameters["name"] = name
        }
        if let address = address {
            parameters["address"] = address
        }
        if let shouldHandledBySurge = shouldHandledBySurge {
            parameters["shouldHandledBySurge"] = shouldHandledBySurge
        }

        let request = self.request(url, method: .post, parameters: parameters)
        let response =  try await performJSONRequest(request)
        return response["error"].string ?? ""
    }
    
    // MARK: - Misc (杂项)
    
    /// 关闭 Surge 引擎
    /// POST /v1/stop
    public func stopSurge() async throws {
        let url = "\(baseURL)/v1/stop"
        let request = self.request(url, method: .post)
        try await performVoidRequest(request)
    }
    
    /// 获取事件中心内容
    /// GET /v1/events
    public func getEvents() async throws -> [Event] {
        let url = "\(baseURL)/v1/events"
        let request = self.request(url)
        let response: EventsResponse =  try await performDecodableRequest(request)
        return response.events
    }
    
    /// 获取规则列表
    /// GET /v1/rules
    public func getRules() async throws -> RulesResponse {
        let url = "\(baseURL)/v1/rules"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 获取流量信息
    /// GET /v1/traffic
    public func getTraffic() async throws -> TrafficResponse {
        let url = "\(baseURL)/v1/traffic"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 更改当前会话的日志级别
    /// POST /v1/log/level
    /// - Parameter level: 日志级别枚举值
    public func setLogLevel(level: LogLevel) async throws {
        let url = "\(baseURL)/v1/log/level"
        let parameters: [String: Sendable] = [
            "level": level.rawValue
        ]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    /// 获取 MITM 的 CA 证书 (DER 二进制格式)
    /// GET /v1/mitm/ca
    public func getMITMCACertificate() async throws -> Data {
        let url = "\(baseURL)/v1/mitm/ca"
        let request = self.request(url)
        return try await performDataRequest(request)
    }
}
