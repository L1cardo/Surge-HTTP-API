import XCTest
@testable import SurgeHTTPAPITests

XCTMain([
    testCase(SurgeModelsTests.allTests),
    testCase(SurgeHTTPAPITests.allTests)
])
