import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(SurgeModelsTests.allTests),
        testCase(SurgeHTTPAPITests.allTests)
    ]
}
#endif
