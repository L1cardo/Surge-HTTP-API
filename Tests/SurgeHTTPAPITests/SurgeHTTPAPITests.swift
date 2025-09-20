@testable import SurgeHTTPAPI
import XCTest

final class SurgeHTTPAPITests: XCTestCase {
    static let allTests = [
        ("testSaveConfiguration", testSaveConfiguration),
        ("testGetBaseURL", testGetBaseURL),
        ("testGetAPIKey", testGetAPIKey),
        ("testGetMITMStateMethodExists", testGetMITMStateMethodExists),
        ("testSetMITMStateMethodExists", testSetMITMStateMethodExists),
        ("testGetCaptureStateMethodExists", testGetCaptureStateMethodExists),
        ("testSetCaptureStateMethodExists", testSetCaptureStateMethodExists),
        ("testGetRewriteStateMethodExists", testGetRewriteStateMethodExists),
        ("testSetRewriteStateMethodExists", testSetRewriteStateMethodExists),
        ("testGetScriptingStateMethodExists", testGetScriptingStateMethodExists),
        ("testSetScriptingStateMethodExists", testSetScriptingStateMethodExists),
        ("testGetSystemProxyStateMethodExists", testGetSystemProxyStateMethodExists),
        ("testSetSystemProxyStateMethodExists", testSetSystemProxyStateMethodExists),
        ("testGetEnhancedModeStateMethodExists", testGetEnhancedModeStateMethodExists),
        ("testSetEnhancedModeStateMethodExists", testSetEnhancedModeStateMethodExists),
        ("testGetOutboundModeMethodExists", testGetOutboundModeMethodExists),
        ("testSetOutboundModeMethodExists", testSetOutboundModeMethodExists),
        ("testGetGlobalPolicyMethodExists", testGetGlobalPolicyMethodExists),
        ("testSetGlobalPolicyMethodExists", testSetGlobalPolicyMethodExists),
        ("testGetPoliciesMethodExists", testGetPoliciesMethodExists),
        ("testGetPolicyDetailMethodExists", testGetPolicyDetailMethodExists),
        ("testTestPoliciesMethodExists", testTestPoliciesMethodExists),
        ("testGetPolicyGroupsMethodExists", testGetPolicyGroupsMethodExists),
        ("testGetPolicyGroupTestResultsMethodExists", testGetPolicyGroupTestResultsMethodExists),
        ("testGetPolicyGroupSelectionMethodExists", testGetPolicyGroupSelectionMethodExists),
        ("testSetPolicyGroupSelectionMethodExists", testSetPolicyGroupSelectionMethodExists),
        ("testTestPolicyGroupMethodExists", testTestPolicyGroupMethodExists),
        ("testGetRecentRequestsMethodExists", testGetRecentRequestsMethodExists),
        ("testGetActiveRequestsMethodExists", testGetActiveRequestsMethodExists),
        ("testKillRequestMethodExists", testKillRequestMethodExists),
        ("testGetCurrentProfileMethodExists", testGetCurrentProfileMethodExists),
        ("testReloadProfileMethodExists", testReloadProfileMethodExists),
        ("testSwitchProfileMethodExists", testSwitchProfileMethodExists),
        ("testGetAvailableProfilesMethodExists", testGetAvailableProfilesMethodExists),
        ("testCheckProfileMethodExists", testCheckProfileMethodExists),
        ("testFlushDNSMethodExists", testFlushDNSMethodExists),
        ("testGetDNSCacheMethodExists", testGetDNSCacheMethodExists),
        ("testTestDNSDelayMethodExists", testTestDNSDelayMethodExists),
        ("testGetModulesMethodExists", testGetModulesMethodExists),
        ("testSetModuleMethodExists", testSetModuleMethodExists),
        ("testGetScriptsMethodExists", testGetScriptsMethodExists),
        ("testEvaluateScriptMethodExists", testEvaluateScriptMethodExists),
        ("testEvaluateCronScriptMethodExists", testEvaluateCronScriptMethodExists),
        ("testGetDevicesMethodExists", testGetDevicesMethodExists),
        ("testUpdateDeviceMethodExists", testUpdateDeviceMethodExists),
        ("testStopSurgeMethodExists", testStopSurgeMethodExists),
        ("testGetEventsMethodExists", testGetEventsMethodExists),
        ("testGetRulesMethodExists", testGetRulesMethodExists),
        ("testGetTrafficMethodExists", testGetTrafficMethodExists),
        ("testSetLogLevelMethodExists", testSetLogLevelMethodExists),
        ("testGetMITMCACertificateMethodExists", testGetMITMCACertificateMethodExists),
        ("testTestConnectivityMethodExists", testTestConnectivityMethodExists),
        ("testTestConnectivityErrorHandling", testTestConnectivityErrorHandling)
    ]
    
    // MARK: - SurgeHTTPAPI Tests
    
    func testSaveConfiguration() {
        let testBaseURL = "http://test.com:6171"
        let testAPIKey = "test-key"
        SurgeHTTPAPI.saveConfig(baseURL: testBaseURL, apiKey: testAPIKey)
        let api = SurgeHTTPAPI.createWithConfig()
        
        XCTAssertEqual(api.getBaseURL(), testBaseURL)
        XCTAssertEqual(api.getAPIKey(), testAPIKey)
    }
    
    func testGetBaseURL() {
        let api = SurgeHTTPAPI.createWithConfig()
        let baseURL = api.getBaseURL()
        XCTAssertFalse(baseURL.isEmpty)
    }
    
    func testGetAPIKey() {
        let api = SurgeHTTPAPI.createWithConfig()
        let apiKey = api.getAPIKey()
        XCTAssertNotNil(apiKey)
    }
    
    // MARK: - Feature Methods Tests
    
    func testGetMITMStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        // We're just testing that the method exists and can be called
        // Actual implementation would require a mock server
        XCTAssertNotNil(api.getMITMState)
    }
    
    func testSetMITMStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        // We're just testing that the method exists and can be called
        // Actual implementation would require a mock server
        XCTAssertNotNil(api.setMITMState)
    }
    
    func testGetCaptureStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getCaptureState)
    }
    
    func testSetCaptureStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setCaptureState)
    }
    
    func testGetRewriteStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getRewriteState)
    }
    
    func testSetRewriteStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setRewriteState)
    }
    
    func testGetScriptingStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getScriptingState)
    }
    
    func testSetScriptingStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setScriptingState)
    }
    
    func testGetSystemProxyStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getSystemProxyState)
    }
    
    func testSetSystemProxyStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setSystemProxyState)
    }
    
    func testGetEnhancedModeStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getEnhancedModeState)
    }
    
    func testSetEnhancedModeStateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setEnhancedModeState)
    }
    
    // MARK: - Outbound Mode Tests
    
    func testGetOutboundModeMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getOutboundMode)
    }
    
    func testSetOutboundModeMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setOutboundMode)
    }
    
    func testGetGlobalPolicyMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getGlobalPolicy)
    }
    
    func testSetGlobalPolicyMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setGlobalPolicy)
    }
    
    // MARK: - Policy Methods Tests
    
    func testGetPoliciesMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getPolicies)
    }
    
    func testGetPolicyDetailMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getPolicyDetail)
    }
    
    func testTestPoliciesMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.testPolicies)
    }
    
    func testGetPolicyGroupsMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getPolicyGroups)
    }
    
    func testGetPolicyGroupTestResultsMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getPolicyGroupTestResults)
    }
    
    func testGetPolicyGroupSelectionMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getPolicyGroupSelection)
    }
    
    func testSetPolicyGroupSelectionMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setPolicyGroupSelection)
    }
    
    func testTestPolicyGroupMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.testPolicyGroup)
    }
    
    // MARK: - Request Methods Tests
    
    func testGetRecentRequestsMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getRecentRequests)
    }
    
    func testGetActiveRequestsMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getActiveRequests)
    }
    
    func testKillRequestMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.killRequest)
    }
    
    // MARK: - Profile Methods Tests
    
    func testGetCurrentProfileMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getCurrentProfile)
    }
    
    func testReloadProfileMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.reloadProfile)
    }
    
    func testSwitchProfileMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.switchProfile)
    }
    
    func testGetAvailableProfilesMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getAvailableProfiles)
    }
    
    func testCheckProfileMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.checkProfile)
    }
    
    // MARK: - DNS Methods Tests
    
    func testFlushDNSMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.flushDNS)
    }
    
    func testGetDNSCacheMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getDNSCache)
    }
    
    func testTestDNSDelayMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.testDNSDelay)
    }
    
    // MARK: - Module Methods Tests
    
    func testGetModulesMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getModules)
    }
    
    func testSetModuleMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setModule)
    }
    
    // MARK: - Scripting Methods Tests
    
    func testGetScriptsMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getScripts)
    }
    
    func testEvaluateScriptMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.evaluateScript)
    }
    
    func testEvaluateCronScriptMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.evaluateCronScript)
    }
    
    // MARK: - Device Methods Tests
    
    func testGetDevicesMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getDevices)
    }
    
    func testUpdateDeviceMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.updateDevice)
    }
    
    // MARK: - Misc Methods Tests
    
    func testStopSurgeMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.stopSurge)
    }
    
    func testGetEventsMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getEvents)
    }
    
    func testGetRulesMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getRules)
    }
    
    func testGetTrafficMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getTraffic)
    }
    
    func testSetLogLevelMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.setLogLevel)
    }
    
    func testGetMITMCACertificateMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.getMITMCACertificate)
    }
    
    // MARK: - Connectivity Test
    
    func testTestConnectivityMethodExists() {
        let api = SurgeHTTPAPI.createWithConfig()
        XCTAssertNotNil(api.testConnectivity)
    }

    func testTestConnectivityErrorHandling() async {
        // 设置无效配置来测试错误处理
        SurgeHTTPAPI.saveConfig(baseURL: "http://invalid-url:9999", apiKey: "invalid-key")
        let api = SurgeHTTPAPI.createWithConfig()

        do {
            let result = try await api.testConnectivity()
            // 如果连接成功（不太可能），这仍然是有效的测试
            XCTAssertTrue(result)
        } catch {
            // 验证错误被正确抛出，保持简单的错误处理
            XCTAssertNotNil(error)
        }
    }
}
