@testable import SurgeHTTPAPI
import XCTest

final class SurgeModelsTests: XCTestCase {
    static let allTests = [
        ("testPoliciesResponseInitialization", testPoliciesResponseInitialization),
        ("testPoliciesResponseCodable", testPoliciesResponseCodable),
        ("testSinglePolicyTestResultInitialization", testSinglePolicyTestResultInitialization),
        ("testSinglePolicyTestResultCodable", testSinglePolicyTestResultCodable),
        ("testPolicyGroupItemInitialization", testPolicyGroupItemInitialization),
        ("testPolicyGroupItemCodable", testPolicyGroupItemCodable),
        ("testRequestTimingRecordInitialization", testRequestTimingRecordInitialization),
        ("testRequestTimingRecordCodable", testRequestTimingRecordCodable),
        ("testLogLevelRawValues", testLogLevelRawValues)
    ]
    
    // MARK: - PoliciesResponse Tests
    
    func testPoliciesResponseInitialization() {
        let proxies = ["Proxy1", "Proxy2"]
        let policyGroups = ["Group1", "Group2"]
        let response = PoliciesResponse(proxies: proxies, policyGroups: policyGroups)
        
        XCTAssertEqual(response.proxies, proxies)
        XCTAssertEqual(response.policyGroups, policyGroups)
    }
    
    func testPoliciesResponseCodable() throws {
        let response = PoliciesResponse(proxies: ["Proxy1"], policyGroups: ["Group1"])
        let data = try JSONEncoder().encode(response)
        let decoded = try JSONDecoder().decode(PoliciesResponse.self, from: data)
        
        XCTAssertEqual(decoded.proxies, response.proxies)
        XCTAssertEqual(decoded.policyGroups, response.policyGroups)
    }
    
    // MARK: - SinglePolicyTestResult Tests
    
    func testSinglePolicyTestResultInitialization() {
        let result = SinglePolicyTestResult(
            tfo: true,
            tcp: 100,
            receive: 200,
            available: 300,
            roundOneTotal: 400
        )
        
        XCTAssertTrue(result.tfo)
        XCTAssertEqual(result.tcp, 100)
        XCTAssertEqual(result.receive, 200)
        XCTAssertEqual(result.available, 300)
        XCTAssertEqual(result.roundOneTotal, 400)
    }
    
    func testSinglePolicyTestResultCodable() throws {
        let result = SinglePolicyTestResult(
            tfo: true,
            tcp: 100,
            receive: 200,
            available: 300,
            roundOneTotal: 400
        )
        let data = try JSONEncoder().encode(result)
        let decoded = try JSONDecoder().decode(SinglePolicyTestResult.self, from: data)
        
        XCTAssertEqual(decoded.tfo, result.tfo)
        XCTAssertEqual(decoded.tcp, result.tcp)
        XCTAssertEqual(decoded.receive, result.receive)
        XCTAssertEqual(decoded.available, result.available)
        XCTAssertEqual(decoded.roundOneTotal, result.roundOneTotal)
    }
    
    // MARK: - PolicyGroupItem Tests
    
    func testPolicyGroupItemInitialization() {
        let item = PolicyGroupItem(
            isGroup: true,
            name: "TestPolicy",
            typeDescription: "Direct",
            lineHash: "abc123",
            enabled: true
        )
        
        XCTAssertTrue(item.isGroup)
        XCTAssertEqual(item.name, "TestPolicy")
        XCTAssertEqual(item.typeDescription, "Direct")
        XCTAssertEqual(item.lineHash, "abc123")
        XCTAssertTrue(item.enabled)
    }
    
    func testPolicyGroupItemCodable() throws {
        let item = PolicyGroupItem(
            isGroup: true,
            name: "TestPolicy",
            typeDescription: "Direct",
            lineHash: "abc123",
            enabled: true
        )
        let data = try JSONEncoder().encode(item)
        let decoded = try JSONDecoder().decode(PolicyGroupItem.self, from: data)
        
        XCTAssertEqual(decoded.isGroup, item.isGroup)
        XCTAssertEqual(decoded.name, item.name)
        XCTAssertEqual(decoded.typeDescription, item.typeDescription)
        XCTAssertEqual(decoded.lineHash, item.lineHash)
        XCTAssertEqual(decoded.enabled, item.enabled)
    }
    
    // MARK: - RequestTimingRecord Tests
    
    func testRequestTimingRecordInitialization() {
        let record = RequestTimingRecord(
            name: "DNS Lookup",
            duration: 0.1,
            durationInMillisecond: 100
        )
        
        XCTAssertEqual(record.name, "DNS Lookup")
        XCTAssertEqual(record.duration, 0.1)
        XCTAssertEqual(record.durationInMillisecond, 100)
    }
    
    func testRequestTimingRecordCodable() throws {
        let record = RequestTimingRecord(
            name: "DNS Lookup",
            duration: 0.1,
            durationInMillisecond: 100
        )
        let data = try JSONEncoder().encode(record)
        let decoded = try JSONDecoder().decode(RequestTimingRecord.self, from: data)
        
        XCTAssertEqual(decoded.name, record.name)
        XCTAssertEqual(decoded.duration, record.duration)
        XCTAssertEqual(decoded.durationInMillisecond, record.durationInMillisecond)
    }
    
    // MARK: - LogLevel Tests
    
    func testLogLevelRawValues() {
        XCTAssertEqual(LogLevel.verbose.rawValue, "verbose")
        XCTAssertEqual(LogLevel.info.rawValue, "info")
        XCTAssertEqual(LogLevel.warning.rawValue, "warning")
        XCTAssertEqual(LogLevel.notify.rawValue, "notify")
    }
}
