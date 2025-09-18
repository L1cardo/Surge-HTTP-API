import Alamofire
import SwiftyJSON
import Foundation
import Defaults

/// Surge HTTP API 客户端
///
/// 用于与 Surge 的 HTTP API 进行交互，支持所有 Surge 提供的 API 端点。
/// 使用单例模式，通过 UserDefaults 存储配置信息。
public class SurgeHTTPAPI: @unchecked Sendable {
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
        
        // 创建自定义 Session 并设置超时时间为 5 秒
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5.0
        configuration.timeoutIntervalForResource = 5.0
        self.session = Session(configuration: configuration)
    }
    
    /// 保存配置到 UserDefaults 以便单例使用
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
        return Defaults[.baseURL]
    }
    
    /// 获取当前配置的 apiKey
    ///
    /// - Returns: 当前配置的 apiKey
    public func getAPIKey() -> String {
        return Defaults[.apiKey]
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
    
    // MARK: - Toggle capabilities (功能切换)
    
    /// 获取 MITM 功能状态
    /// GET /v1/features/mitm
    public func getMITMState() async throws -> FeatureState {
        let url = "\(baseURL)/v1/features/mitm"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置 MITM 功能状态
    /// POST /v1/features/mitm
    public func setMITMState(enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/mitm"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    /// 获取 Capture 功能状态
    /// GET /v1/features/capture
    public func getCaptureState() async throws -> FeatureState {
        let url = "\(baseURL)/v1/features/capture"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置 Capture 功能状态
    /// POST /v1/features/capture
    public func setCaptureState(enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/capture"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    /// 获取 Rewrite 功能状态
    /// GET /v1/features/rewrite
    public func getRewriteState() async throws -> FeatureState {
        let url = "\(baseURL)/v1/features/rewrite"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置 Rewrite 功能状态
    /// POST /v1/features/rewrite
    public func setRewriteState(enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/rewrite"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    /// 获取 Scripting 功能状态
    /// GET /v1/features/scripting
    public func getScriptingState() async throws -> FeatureState {
        let url = "\(baseURL)/v1/features/scripting"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置 Scripting 功能状态
    /// POST /v1/features/scripting
    public func setScriptingState(enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/scripting"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    /// 获取 System Proxy 功能状态 (仅 Mac)
    /// GET /v1/features/system_proxy
    public func getSystemProxyState() async throws -> FeatureState {
        let url = "\(baseURL)/v1/features/system_proxy"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置 System Proxy 功能状态 (仅 Mac)
    /// POST /v1/features/system_proxy
    public func setSystemProxyState(enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/system_proxy"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    /// 获取 Enhanced Mode 功能状态 (仅 Mac)
    /// GET /v1/features/enhanced_mode
    public func getEnhancedModeState() async throws -> FeatureState {
        let url = "\(baseURL)/v1/features/enhanced_mode"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置 Enhanced Mode 功能状态 (仅 Mac)
    /// POST /v1/features/enhanced_mode
    public func setEnhancedModeState(enabled: Bool) async throws {
        let url = "\(baseURL)/v1/features/enhanced_mode"
        let parameters = ["enabled": enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(request)
    }
    
    // MARK: - Outbound Mode (出站模式)
    
    /// 获取出站模式
    /// GET /v1/outbound
    public func getOutboundMode() async throws -> OutboundMode {
        let url = "\(baseURL)/v1/outbound"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置出站模式
    /// POST /v1/outbound
    public func setOutboundMode(mode: String) async throws -> OutboundMode {
        let url = "\(baseURL)/v1/outbound"
        let parameters = ["mode": mode]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(request)
    }
    
    /// 测试连通性
    /// 使用 GET /v1/outbound 测试与 Surge 的连接
    /// - Returns: 如果能成功返回结果，则说明连接正常；否则抛出异常
    public func testConnectivity() async throws -> Bool {
        let url = "\(baseURL)/v1/outbound"
        let request = self.request(url)
        _ = try await performDecodableRequest(request) as OutboundMode
        return true
    }
    
    /// 获取全局出站策略
    /// GET /v1/outbound/global
    public func getGlobalPolicy() async throws -> GlobalPolicy {
        let url = "\(baseURL)/v1/outbound/global"
        let request = self.request(url)
        return try await performDecodableRequest(request)
    }
    
    /// 设置全局出站策略
    /// POST /v1/outbound/global
    public func setGlobalPolicy(policy: String) async throws -> GlobalPolicy {
        let url = "\(baseURL)/v1/outbound/global"
        let parameters = ["policy": policy]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(request)
    }
    
    // MARK: - Proxy Policy (代理策略)
    
    /// 列出所有策略
    /// GET /v1/policies
    public func getPolicies() async throws -> JSON {
        let url = "\(baseURL)/v1/policies"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 获取策略详情
    /// GET /v1/policies/detail?policy_name=ProxyNameHere
    public func getPolicyDetail(policyName: String) async throws -> JSON {
        let url = "\(baseURL)/v1/policies/detail"
        let parameters = ["policy_name": policyName]
        let request = self.request(url, parameters: parameters)
        return try await performJSONRequest(request)
    }
    
    /// 测试策略
    /// POST /v1/policies/test
    public func testPolicies(request: PolicyTestRequest) async throws -> JSON {
        let url = "\(baseURL)/v1/policies/test"
        let parameters: [String: Sendable] = [
            "policy_names": request.policyNames,
            "url": request.url
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performJSONRequest(requestObj)
    }
    
    /// 列出所有策略组及其选项
    /// GET /v1/policy_groups
    public func getPolicyGroups() async throws -> JSON {
        let url = "\(baseURL)/v1/policy_groups"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 获取策略组测试结果
    /// GET /v1/policy_groups/test_results
    public func getPolicyGroupTestResults() async throws -> JSON {
        let url = "\(baseURL)/v1/policy_groups/test_results"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 获取选择策略组的选项
    /// GET /v1/policy_groups/select?group_name=GroupNameHere
    public func getPolicyGroupSelection(groupName: String) async throws -> PolicyGroupSelection {
        let url = "\(baseURL)/v1/policy_groups/select"
        let parameters = ["group_name": groupName]
        let request = self.request(url, parameters: parameters)
        return try await performDecodableRequest(request)
    }
    
    /// 更改选择策略组的选项
    /// POST /v1/policy_groups/select
    public func setPolicyGroupSelection(request: PolicyGroupSelectRequest) async throws -> PolicyGroupSelection {
        let url = "\(baseURL)/v1/policy_groups/select"
        let parameters = [
            "group_name": request.groupName,
            "policy": request.policy
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(requestObj)
    }
    
    /// 立即测试策略组
    /// POST /v1/policy_groups/test
    public func testPolicyGroup(request: PolicyGroupTestRequest) async throws -> PolicyGroupTestResult {
        let url = "\(baseURL)/v1/policy_groups/test"
        let parameters = [
            "group_name": request.groupName
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(requestObj)
    }
    
    // MARK: - Requests (请求管理)
    
    /// 列出最近的请求
    /// GET /v1/requests/recent
    public func getRecentRequests() async throws -> JSON {
        let url = "\(baseURL)/v1/requests/recent"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 列出所有活动请求
    /// GET /v1/requests/active
    public func getActiveRequests() async throws -> JSON {
        let url = "\(baseURL)/v1/requests/active"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 杀死活动请求
    /// POST /v1/requests/kill
    public func killRequest(request: KillRequest) async throws {
        let url = "\(baseURL)/v1/requests/kill"
        let parameters = [
            "id": request.id
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(requestObj)
    }
    
    // MARK: - Profiles (配置文件)
    
    /// 获取当前配置文件内容
    /// GET /v1/profiles/current?sensitive=0
    public func getCurrentProfile(sensitive: Bool = false) async throws -> String {
        let url = "\(baseURL)/v1/profiles/current"
        let parameters = ["sensitive": sensitive ? 1 : 0]
        let request = self.request(url, parameters: parameters)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.responseString { response in
                switch response.result {
                case .success(let string):
                    continuation.resume(returning: string)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
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
    public func switchProfile(request: ProfileSwitchRequest) async throws -> SimpleResponse {
        let url = "\(baseURL)/v1/profiles/switch"
        let parameters: [String: Sendable] = [
            "name": request.name
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(requestObj)
    }
    
    /// 获取所有可用的配置文件名称 (仅 Mac 4.0.6+)
    /// GET /v1/profiles
    public func getAvailableProfiles() async throws -> JSON {
        let url = "\(baseURL)/v1/profiles"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 检查配置文件 (仅 Mac 4.0.6+)
    /// POST /v1/profiles/check
    public func checkProfile(request: ProfileSwitchRequest) async throws -> SimpleResponse {
        let url = "\(baseURL)/v1/profiles/check"
        let parameters: [String: Sendable] = [
            "name": request.name
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(requestObj)
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
    public func getDNSCache() async throws -> JSON {
        let url = "\(baseURL)/v1/dns"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 测试 DNS 延迟
    /// POST /v1/test/dns_delay
    public func testDNSDelay() async throws -> JSON {
        let url = "\(baseURL)/v1/test/dns_delay"
        let request = self.request(url, method: .post)
        return try await performJSONRequest(request)
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
    public func setModule(moduleName: String, enabled: Bool) async throws -> ModulesState {
        let url = "\(baseURL)/v1/modules"
        let parameters = [moduleName: enabled]
        let request = self.request(url, method: .post, parameters: parameters)
        return try await performDecodableRequest(request)
    }
    
    // MARK: - Scripting (脚本)
    
    /// 列出所有脚本
    /// GET /v1/scripting
    public func getScripts() async throws -> JSON {
        let url = "\(baseURL)/v1/scripting"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 评估脚本
    /// POST /v1/scripting/evaluate
    public func evaluateScript(request: ScriptEvaluateRequest) async throws -> JSON {
        let url = "\(baseURL)/v1/scripting/evaluate"
        var parameters: [String: Sendable] = [
            "script_text": request.scriptText
        ]
        
        if let mockType = request.mockType {
            parameters["mock_type"] = mockType
        }
        
        if let timeout = request.timeout {
            parameters["timeout"] = timeout
        }
        
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performJSONRequest(requestObj)
    }
    
    /// 立即评估 Cron 脚本
    /// POST /v1/scripting/cron/evaluate
    public func evaluateCronScript(request: CronScriptEvaluateRequest) async throws -> JSON {
        let url = "\(baseURL)/v1/scripting/cron/evaluate"
        let parameters: [String: Sendable] = [
            "script_name": request.scriptName
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performJSONRequest(requestObj)
    }
    
    // MARK: - Device Management (设备管理) (仅 Mac 4.0.6+)
    
    /// 获取当前活动和保存的设备列表
    /// GET /v1/devices
    public func getDevices() async throws -> JSON {
        let url = "\(baseURL)/v1/devices"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 获取设备图标
    /// GET /v1/devices/icon?id={iconID}
    public func getDeviceIcon(iconID: String) async throws -> Data {
        let url = "\(baseURL)/v1/devices/icon"
        let parameters = ["id": iconID]
        let request = self.request(url, parameters: parameters)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.responseData { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    /// 更改设备属性
    /// POST /v1/devices
    public func updateDevice(request: DeviceUpdateRequest) async throws -> JSON {
        let url = "\(baseURL)/v1/devices"
        var parameters: [String: Sendable] = [
            "physicalAddress": request.physicalAddress
        ]
        
        if let name = request.name {
            parameters["name"] = name
        }
        
        if let address = request.address {
            parameters["address"] = address
        }
        
        if let shouldHandledBySurge = request.shouldHandledBySurge {
            parameters["shouldHandledBySurge"] = shouldHandledBySurge
        }
        
        let requestObj = self.request(url, method: .post, parameters: parameters)
        return try await performJSONRequest(requestObj)
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
    public func getEvents() async throws -> JSON {
        let url = "\(baseURL)/v1/events"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 获取规则列表
    /// GET /v1/rules
    public func getRules() async throws -> JSON {
        let url = "\(baseURL)/v1/rules"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 获取流量信息
    /// GET /v1/traffic
    public func getTraffic() async throws -> JSON {
        let url = "\(baseURL)/v1/traffic"
        let request = self.request(url)
        return try await performJSONRequest(request)
    }
    
    /// 更改当前会话的日志级别
    /// POST /v1/log/level
    public func setLogLevel(request: LogLevelRequest) async throws {
        let url = "\(baseURL)/v1/log/level"
        let parameters: [String: Sendable] = [
            "level": request.level
        ]
        let requestObj = self.request(url, method: .post, parameters: parameters)
        try await performVoidRequest(requestObj)
    }
    
    /// 获取 MITM 的 CA 证书 (DER 二进制格式)
    /// GET /v1/mitm/ca
    public func getMITMCACertificate() async throws -> Data {
        let url = "\(baseURL)/v1/mitm/ca"
        let request = self.request(url)
        
        return try await withCheckedThrowingContinuation { continuation in
            request.responseData { response in
                switch response.result {
                case .success(let data):
                    continuation.resume(returning: data)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
}
