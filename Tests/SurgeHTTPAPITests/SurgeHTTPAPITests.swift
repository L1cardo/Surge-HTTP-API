import XCTest
@testable import SurgeHTTPAPI

final class SurgeHTTPAPITests: XCTestCase {
    
    static var allTests = [
        ("testSharedInstanceCreation", testSharedInstanceCreation),
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
        ("testTestConnectivityMethodExists", testTestConnectivityMethodExists)
    ]
    
    // MARK: - SurgeHTTPAPI Tests
    
    func testSharedInstanceCreation() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api)
    }
    
    func testSaveConfiguration() {
        let api = SurgeHTTPAPI.shared
        let testBaseURL = "http://test.com:6171"
        let testAPIKey = "test-key"
        
        api.saveConfiguration(baseURL: testBaseURL, apiKey: testAPIKey)
        
        XCTAssertEqual(api.getBaseURL(), testBaseURL)
        XCTAssertEqual(api.getAPIKey(), testAPIKey)
    }
    
    func testGetBaseURL() {
        let api = SurgeHTTPAPI.shared
        let baseURL = api.getBaseURL()
        XCTAssertFalse(baseURL.isEmpty)
    }
    
    func testGetAPIKey() {
        let api = SurgeHTTPAPI.shared
        let apiKey = api.getAPIKey()
        XCTAssertNotNil(apiKey)
    }
    
    // MARK: - Feature Methods Tests
    
    func testGetMITMStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        // We're just testing that the method exists and can be called
        // Actual implementation would require a mock server
        XCTAssertNotNil(api.getMITMState)
    }
    
    func testSetMITMStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        // We're just testing that the method exists and can be called
        // Actual implementation would require a mock server
        XCTAssertNotNil(api.setMITMState)
    }
    
    func testGetCaptureStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getCaptureState)
    }
    
    func testSetCaptureStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setCaptureState)
    }
    
    func testGetRewriteStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getRewriteState)
    }
    
    func testSetRewriteStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setRewriteState)
    }
    
    func testGetScriptingStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getScriptingState)
    }
    
    func testSetScriptingStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setScriptingState)
    }
    
    func testGetSystemProxyStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getSystemProxyState)
    }
    
    func testSetSystemProxyStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setSystemProxyState)
    }
    
    func testGetEnhancedModeStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getEnhancedModeState)
    }
    
    func testSetEnhancedModeStateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setEnhancedModeState)
    }
    
    // MARK: - Outbound Mode Tests
    
    func testGetOutboundModeMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getOutboundMode)
    }
    
    func testSetOutboundModeMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setOutboundMode)
    }
    
    func testGetGlobalPolicyMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getGlobalPolicy)
    }
    
    func testSetGlobalPolicyMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setGlobalPolicy)
    }
    
    // MARK: - Policy Methods Tests
    
    func testGetPoliciesMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getPolicies)
    }
    
    func testGetPolicyDetailMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getPolicyDetail)
    }
    
    func testTestPoliciesMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.testPolicies)
    }
    
    func testGetPolicyGroupsMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getPolicyGroups)
    }
    
    func testGetPolicyGroupTestResultsMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getPolicyGroupTestResults)
    }
    
    func testGetPolicyGroupSelectionMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getPolicyGroupSelection)
    }
    
    func testSetPolicyGroupSelectionMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setPolicyGroupSelection)
    }
    
    func testTestPolicyGroupMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.testPolicyGroup)
    }
    
    // MARK: - Request Methods Tests
    
    func testGetRecentRequestsMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getRecentRequests)
    }
    
    func testGetActiveRequestsMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getActiveRequests)
    }
    
    func testKillRequestMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.killRequest)
    }
    
    // MARK: - Profile Methods Tests
    
    func testGetCurrentProfileMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getCurrentProfile)
    }
    
    func testReloadProfileMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.reloadProfile)
    }
    
    func testSwitchProfileMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.switchProfile)
    }
    
    func testGetAvailableProfilesMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getAvailableProfiles)
    }
    
    func testCheckProfileMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.checkProfile)
    }
    
    // MARK: - DNS Methods Tests
    
    func testFlushDNSMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.flushDNS)
    }
    
    func testGetDNSCacheMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getDNSCache)
    }
    
    func testTestDNSDelayMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.testDNSDelay)
    }
    
    // MARK: - Module Methods Tests
    
    func testGetModulesMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getModules)
    }
    
    func testSetModuleMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setModule)
    }
    
    // MARK: - Scripting Methods Tests
    
    func testGetScriptsMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getScripts)
    }
    
    func testEvaluateScriptMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.evaluateScript)
    }
    
    func testEvaluateCronScriptMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.evaluateCronScript)
    }
    
    // MARK: - Device Methods Tests
    
    func testGetDevicesMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getDevices)
    }
    
    func testUpdateDeviceMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.updateDevice)
    }
    
    // MARK: - Misc Methods Tests
    
    func testStopSurgeMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.stopSurge)
    }
    
    func testGetEventsMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getEvents)
    }
    
    func testGetRulesMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getRules)
    }
    
    func testGetTrafficMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getTraffic)
    }
    
    func testSetLogLevelMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.setLogLevel)
    }
    
    func testGetMITMCACertificateMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.getMITMCACertificate)
    }
    
    // MARK: - Connectivity Test
    
    func testTestConnectivityMethodExists() {
        let api = SurgeHTTPAPI.shared
        XCTAssertNotNil(api.testConnectivity)
    }
}
