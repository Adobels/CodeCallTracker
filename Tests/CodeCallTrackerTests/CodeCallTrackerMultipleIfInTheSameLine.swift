//
//  CodeCallTrackerMultipleIfInTheSameLine.swift
//  CodeCallTracker
//
//  Created by Blazej Sleboda on 17/06/2024.
//

import XCTest
@testable import CodeCallTracker

final class CodeCallTrackerMultipleIfInTheSameLine: XCTestCase {

    func testMultipleIfInTheSameLine() throws {
        let vc = ViewController()
        vc.start(); vc.start()
        XCTAssertEqual(vc.result.joined(separator: ":"), "str_1:str_1:str_2:str_2")
    }
}

extension CodeCallTrackerMultipleIfInTheSameLine {

    class ViewController {

        let codeTracker = CodeCallTracker()
        var result: [String] = []

        func start() {
            let str = codeTracker.isFirstTimeCall() ? "str_1" : "str_2"; let str2 = codeTracker.isFirstTimeCall() ? "str_1" : "str_2";
            result.append(contentsOf: [str, str2])
        }
    }
}
