//
//  Matrix.swift
//  SwiftQiskit
//
//  Basic matrix implementation for quantum simulation.
//  Supports matrix-matrix and matrix-vector multiplication.
//
//  Created by Ali on 2025-01-XX.
//

import Foundation

public struct Matrix: Equatable, Hashable {

    public let rows: Int
    public let cols: Int
    private var grid: [Complex]

    // MARK: - Initializers

    public init(rows: Int, cols: Int, repeating value: Complex = .zero) {
        precondition(rows > 0 && cols > 0, "Matrix dimensions must be positive")
        self.rows = rows
        self.cols = cols
        self.grid = Array(repeating: value, count: rows * cols)
    }

    public init(_ data: [[Complex]]) {
        precondition(!data.isEmpty && !data[0].isEmpty, "Matrix data cannot be empty")

        let r = data.count
        let c = data[0].count
        precondition(data.allSatisfy { $0.count == c }, "All rows must have the same number of columns")

        self.rows = r
        self.cols = c
        self.grid = data.flatMap { $0 }
    }

    // MARK: - Subscript

    public subscript(row: Int, col: Int) -> Complex {
        get {
            precondition(isValidIndex(row, col), "Index out of range")
            return grid[(row * cols) + col]
        }
        set {
            precondition(isValidIndex(row, col), "Index out of range")
            grid[(row * cols) + col] = newValue
        }
    }

    private func isValidIndex(_ row: Int, _ col: Int) -> Bool {
        row >= 0 && row < rows && col >= 0 && col < cols
    }
}

// MARK: - Matrix Operations
public extension Matrix {

    /// Matrix × Matrix
    static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        precondition(lhs.cols == rhs.rows, "Matrix dimensions not compatible for multiplication")

        var result = Matrix(rows: lhs.rows, cols: rhs.cols)

        for i in 0..<lhs.rows {
            for j in 0..<rhs.cols {
                var sum = Complex.zero
                for k in 0..<lhs.cols {
                    sum = sum + lhs[i, k] * rhs[k, j]
                }
                result[i, j] = sum
            }
        }

        return result
    }

    /// Matrix × Vector (StateVector)
    func multiply(by vector: [Complex]) -> [Complex] {
        precondition(cols == vector.count, "Matrix and vector dimensions not compatible")

        var result = Array(repeating: Complex.zero, count: rows)

        for i in 0..<rows {
            var sum = Complex.zero
            for j in 0..<cols {
                sum = sum + self[i, j] * vector[j]
            }
            result[i] = sum
        }

        return result
    }
}

// MARK: - Identity Matrix
public extension Matrix {

    static func identity(size: Int) -> Matrix {
        var m = Matrix(rows: size, cols: size)
        for i in 0..<size {
            m[i, i] = .one
        }
        return m
    }
}

// MARK: - CustomStringConvertible
extension Matrix: CustomStringConvertible {
    public var description: String {
        var lines: [String] = []
        for i in 0..<rows {
            let row = (0..<cols).map { self[i, $0].description }.joined(separator: ", ")
            lines.append("[\(row)]")
        }
        return lines.joined(separator: "\n")
    }
}
