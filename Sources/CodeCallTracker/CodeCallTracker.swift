//
//  CodeCallTracker.swift
//  CodeCallTracker
//
//  Created by Blazej Sleboda on 17/06/2024.
//

public class CodeCallTracker {

    private var store: Set<String> = []

    public init() { }

    func executeOnFirstTimeCall(_ fileId: String = #fileID, _ line: Int = #line, _ column: Int = #column, _ block: () -> Void) {
        let funcIdentifier = "\(fileId):\(line):\(column)"
        if !store.contains(funcIdentifier) {
            store.insert(funcIdentifier)
            block()
        }
    }

    func executeOnNextNotFirstTimeCall(_ fileId: String = #fileID, _ line: Int = #line, _ column: Int = #column, _ block: () -> Void) {
        let funcIdentifier = "\(fileId):\(line):\(column)"
        if store.contains(funcIdentifier) {
            block()
        } else {
            store.insert(funcIdentifier)
        }
    }

    public func isFirstTimeCall(_ fileId: String = #fileID, _ line: Int = #line, _ column: Int = #column) -> Bool {
        let funcIdentifier = "\(fileId):\(line):\(column)"
        if store.contains(funcIdentifier) {
            return false
        } else {
            store.insert(funcIdentifier)
            return true
        }
    }
}
