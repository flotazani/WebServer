//
//  Result+2vals.swift
//  WebSchedule
//
//  Created by Andrei Konovalov on 05.01.2021.
//
import Foundation

extension String: Error {}

extension String: LocalizedError {
    public var errorDescription: String? { return self }
}
