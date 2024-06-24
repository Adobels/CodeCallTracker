//
//  CodeCallTrackerTests.swift
//  CodeCallTracker
//
//  Created by Blazej Sleboda on 17/06/2024.
//


import XCTest
@testable import CodeCallTracker

final class CodeCallTrackerTests: XCTestCase {

    typealias SUT = SpyViewController
    private var spy: SUT!

    override func setUp() {
        super.setUp()
        spy = .init()
    }

    func testisFirstTimeCallIsCalledOnlyOnFirstCall() throws {
        spy.viewDidLoad()
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, .zero)

        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)

        spy.viewDidLoad()
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)

        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewDidLoadCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
    }

    func testisFirstTimeCallArgumentValuesNoImpact() throws {
        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)

        spy.viewWillAppear(true)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
    }

    func testisFirstTimeCallArgumentTypesNoInterference() throws {
        spy.viewWillAppear(false)
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentStringCallCounter, .zero)

        spy.viewWillAppear("")
        XCTAssertEqual(spy.viewWillAppearArgumentBoolCallCounter, 1)
        XCTAssertEqual(spy.viewWillAppearArgumentStringCallCounter, 1)
    }
}

extension CodeCallTrackerTests {

    class BaseViewController {

        func viewDidLoad() {}

        func viewWillAppear(_ animated: Bool) {}
    }

    class ViewController: BaseViewController {

        var codeTracker = CodeCallTracker()
    }

    class SpyViewController: ViewController {

        var viewDidLoadCallCounter = Int.zero
        var viewWillAppearArgumentBoolCallCounter = Int.zero
        var viewWillAppearArgumentStringCallCounter = Int.zero

        override func viewDidLoad() {
            super.viewDidLoad()
            if codeTracker.isFirstTimeCall() {
                viewDidLoadCallCounter += 1
            }
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if codeTracker.isFirstTimeCall() {
                viewWillAppearArgumentBoolCallCounter += 1
            }
        }

        func viewWillAppear(_ animated: String) {
            if codeTracker.isFirstTimeCall() {
                viewWillAppearArgumentStringCallCounter += 1
            }
        }
    }
}
