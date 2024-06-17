//
//  FunctionCallTracker.swift
//
//
//  Created by Blazej Sleboda on 17/06/2024.
//

public class FunctionCallTracker {

    public struct Configuration {
        let functionNameAndLine = true
    }
    private var store: [String] = []
    private let configuration: Configuration

    init(configuration: Configuration = .init()) {
        self.configuration = configuration
    }

    func executeOnFirstTimeCall(_ functionName: String = #function, _ line: Int = #line, block: () -> Void) {
        let funcIdentifier = if configuration.functionNameAndLine {
            functionName + ":" + String(line)
        } else {
            functionName
        }
        if !store.contains(funcIdentifier) {
            store.append(funcIdentifier)
            block()
        }
    }

    public func isFirstTimeCall(_ functionName: String = #function, _ line: Int = #line) -> Bool {
        let funcIdentifier = if configuration.functionNameAndLine {
            functionName + ":" + String(line)
        } else {
            functionName
        }
        if store.contains(funcIdentifier) {
            return false
        } else {
            store.append(funcIdentifier)
            return true
        }
    }
}
