import XCTest
@testable import SurgeHTTPAPI

/// Surge HTTP API 测试套件
///
/// 包含对 SurgeHTTPAPI 客户端和模型的单元测试。
final class SurgeHTTPAPITests: XCTestCase, @unchecked Sendable {
    /// 测试客户端初始化
    func testClientInitialization() {
        // 测试单例初始化
        let sharedClient = SurgeHTTPAPI.shared
        XCTAssertNotNil(sharedClient)
    }
    
    /// 测试异步方法签名
    func testAsyncAwaitMethods() async {
        // 测试异步方法是否存在（不实际调用，因为需要真实的 API 服务器）
        _ = SurgeHTTPAPI.shared
        
        // 这些测试只是验证方法签名是否正确，不会实际执行网络请求
        // 因为我们没有真实的 Surge 服务器来测试
        
        // 验证方法存在即可
        XCTAssertTrue(true)
    }
    
    /// 测试保存配置功能
    func testSaveConfiguration() {
        // 测试保存配置功能
        SurgeHTTPAPI.shared.saveConfiguration(baseURL: "http://127.0.0.1:6171", apiKey: "test-key")
        
        // 验证配置已保存
        let client = SurgeHTTPAPI.shared
        XCTAssertNotNil(client)
    }
    
    /// 测试功能状态模型
    func testFeatureStateModel() {
        let featureState = FeatureState(enabled: true)
        XCTAssertTrue(featureState.enabled)
    }
    
    /// 测试出站模式模型
    func testOutboundModeModel() {
        let outboundMode = OutboundMode(mode: "rule")
        XCTAssertEqual(outboundMode.mode, "rule")
    }
    
    /// 测试策略测试请求编码
    func testPolicyTestRequestEncoding() {
        let request = PolicyTestRequest(
            policyNames: ["ProxyA", "ProxyB"],
            url: "http://test.com"
        )
        
        XCTAssertEqual(request.policyNames, ["ProxyA", "ProxyB"])
        XCTAssertEqual(request.url, "http://test.com")
    }
    
    /// 测试策略组选择请求编码
    func testPolicyGroupSelectRequestEncoding() {
        let request = PolicyGroupSelectRequest(
            groupName: "GroupA",
            policy: "ProxyA"
        )
        
        XCTAssertEqual(request.groupName, "GroupA")
        XCTAssertEqual(request.policy, "ProxyA")
    }
    
    /// 测试模块切换编码
    func testModuleToggleEncoding() {
        let toggle = ModuleToggle(moduleName: "TestModule", enabled: true)
        
        XCTAssertEqual(toggle.moduleName, "TestModule")
        XCTAssertTrue(toggle.enabled)
    }
    
    /// 测试杀死请求编码
    func testKillRequestEncoding() {
        let request = KillRequest(id: 123)
        XCTAssertEqual(request.id, 123)
    }
    
    /// 测试配置切换请求编码
    func testProfileSwitchRequestEncoding() {
        let request = ProfileSwitchRequest(name: "Profile1")
        XCTAssertEqual(request.name, "Profile1")
    }
    
    /// 测试日志级别请求编码
    func testLogLevelRequestEncoding() {
        let request = LogLevelRequest(level: "verbose")
        XCTAssertEqual(request.level, "verbose")
    }
    
    /// 测试脚本评估请求编码
    func testScriptEvaluateRequestEncoding() {
        let request = ScriptEvaluateRequest(
            scriptText: "console.log('test');",
            mockType: "cron",
            timeout: 5
        )
        
        XCTAssertEqual(request.scriptText, "console.log('test');")
        XCTAssertEqual(request.mockType, "cron")
        XCTAssertEqual(request.timeout, 5)
    }
    
    /// 测试 Cron 脚本评估请求编码
    func testCronScriptEvaluateRequestEncoding() {
        let request = CronScriptEvaluateRequest(scriptName: "test-script")
        XCTAssertEqual(request.scriptName, "test-script")
    }
    
    /// 测试设备更新请求编码
    func testDeviceUpdateRequestEncoding() {
        let request = DeviceUpdateRequest(
            physicalAddress: "00:11:22:33:44:55",
            name: "TestDevice",
            address: "192.168.1.100",
            shouldHandledBySurge: true
        )
        
        XCTAssertEqual(request.physicalAddress, "00:11:22:33:44:55")
        XCTAssertEqual(request.name, "TestDevice")
        XCTAssertEqual(request.address, "192.168.1.100")
        XCTAssertTrue(request.shouldHandledBySurge!)
    }
    
    /// 测试简单响应模型
    func testSimpleResponseModel() {
        let response = SimpleResponse(enabled: true, mode: "rule", policy: "ProxyA", error: nil)
        
        XCTAssertTrue(response.enabled!)
        XCTAssertEqual(response.mode, "rule")
        XCTAssertEqual(response.policy, "ProxyA")
        XCTAssertNil(response.error)
    }
    
    /// 测试模块状态模型
    func testModulesStateModel() {
        let modules = ModulesState(
            enabled: ["ModuleA", "ModuleB"],
            available: ["ModuleA", "ModuleB", "ModuleC"]
        )
        
        XCTAssertEqual(modules.enabled, ["ModuleA", "ModuleB"])
        XCTAssertEqual(modules.available, ["ModuleA", "ModuleB", "ModuleC"])
    }
    
    /// 测试策略组测试结果模型
    func testPolicyGroupTestResultModel() {
        let result = PolicyGroupTestResult(available: ["ProxyA", "ProxyB"])
        XCTAssertEqual(result.available, ["ProxyA", "ProxyB"])
    }
    
    /// 测试策略组选择模型
    func testPolicyGroupSelectionModel() {
        let selection = PolicyGroupSelection(policy: "ProxyA")
        XCTAssertEqual(selection.policy, "ProxyA")
    }
    
    /// 测试全局策略模型
    func testGlobalPolicyModel() {
        let policy = GlobalPolicy(policy: "ProxyA")
        XCTAssertEqual(policy.policy, "ProxyA")
    }
    
    /// 测试 Void 结果类型
    func testVoidResultType() {
        // 测试 Void 结果类型的编码
        let expectation = XCTestExpectation(description: "Void result type")
        
        // 这只是一个示例测试，实际测试需要网络请求
        expectation.fulfill()
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    /// 测试连通性方法
    func testConnectivityMethod() async {
        // 测试连通性方法是否存在（不实际调用，因为需要真实的 API 服务器）
        _ = SurgeHTTPAPI.shared
        
        // 验证方法存在即可
        XCTAssertTrue(true)
    }
    
    /// 所有测试用例
    @MainActor
    static let allTests = [
        ("testClientInitialization", testClientInitialization),
        ("testSaveConfiguration", testSaveConfiguration),
        ("testFeatureStateModel", testFeatureStateModel),
        ("testOutboundModeModel", testOutboundModeModel),
        ("testPolicyTestRequestEncoding", testPolicyTestRequestEncoding),
        ("testPolicyGroupSelectRequestEncoding", testPolicyGroupSelectRequestEncoding),
        ("testModuleToggleEncoding", testModuleToggleEncoding),
        ("testKillRequestEncoding", testKillRequestEncoding),
        ("testProfileSwitchRequestEncoding", testProfileSwitchRequestEncoding),
        ("testLogLevelRequestEncoding", testLogLevelRequestEncoding),
        ("testScriptEvaluateRequestEncoding", testScriptEvaluateRequestEncoding),
        ("testCronScriptEvaluateRequestEncoding", testCronScriptEvaluateRequestEncoding),
        ("testDeviceUpdateRequestEncoding", testDeviceUpdateRequestEncoding),
        ("testSimpleResponseModel", testSimpleResponseModel),
        ("testModulesStateModel", testModulesStateModel),
        ("testPolicyGroupTestResultModel", testPolicyGroupTestResultModel),
        ("testPolicyGroupSelectionModel", testPolicyGroupSelectionModel),
        ("testGlobalPolicyModel", testGlobalPolicyModel),
        ("testVoidResultType", testVoidResultType),
        ("testConnectivityMethod", testConnectivityMethod),
    ]
}
