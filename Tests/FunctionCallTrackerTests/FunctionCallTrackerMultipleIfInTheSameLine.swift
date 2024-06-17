//
//  FunctionCallTrackerMultipleIfInTheSameLine.swift
//
//
//  Created by Blazej Sleboda on 17/06/2024.
//

import XCTest
@testable import FunctionCallTracker

final class FunctionCallTrackerMultipleIfInTheSameLine: XCTestCase {

    func testMultipleIfInTheSameLine() throws {
        let vc = ViewController()
        vc.start(); vc.start()
        XCTAssertEqual(vc.result.joined(separator: ":"), "str_1:str_1:str_2:str_2")
    }
}

extension FunctionCallTrackerMultipleIfInTheSameLine {

    class ViewController {

        let funcTracker = FunctionCallTracker()
        var result: [String] = []

        func start() {
            let str = funcTracker.isFirstTimeCall() ? "str_1" : "str_2"; let str2 = funcTracker.isFirstTimeCall() ? "str_1" : "str_2";
            result.append(contentsOf: [str, str2])
        }
    }
}
