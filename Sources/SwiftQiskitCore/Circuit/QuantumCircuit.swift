//
//  QuantumCircuit.swift
//  SwiftQiskit
//
//  High-level abstraction for building and running quantum circuits.
//
//  Created by Ali on 2025-01-XX.
//

import Foundation

public final class QuantumCircuit {

    // MARK: - Types

    private struct Operation {
        let matrix: Matrix
    }

    // MARK: - Properties

    public let qubits: Int
    private var operations: [Operation] = []

    // MARK: - Initializer

    public init(qubits: Int) {
        precondition(qubits > 0, "Number of qubits must be positive")
        self.qubits = qubits
    }

    // MARK: - Gate API (v1)

    /// Apply a full-dimension gate (2^n x 2^n)
    public func apply(_ matrix: Matrix) {
        let expectedDim = 1 << qubits
        precondition(matrix.rows == expectedDim && matrix.cols == expectedDim,
                     "Gate matrix must match circuit dimension (2^n x 2^n)")
        operations.append(Operation(matrix: matrix))
    }

    /// Convenience: Hadamard on all qubits (full-dimension H ⊗ H ⊗ ...)
    public func hAll() {
        let fullH = kronAll(HadamardGate.matrix, count: qubits)
        apply(fullH)
    }

    /// Convenience: Pauli-X on all qubits
    public func xAll() {
        let fullX = kronAll(PauliXGate.matrix, count: qubits)
        apply(fullX)
    }

    // MARK: - Execution

    /// Run the circuit and return the final state
    public func run() -> StateVector {
        var state = StateVector(qubits: qubits)
        for op in operations {
            state.apply(op.matrix)
        }
        return state
    }

    /// Run and measure once
    public func runAndMeasure() -> Int {
        var state = run()
        return state.measure()
    }
}

// MARK: - Helpers (Kronecker utilities for v1)
private func kron(_ a: Matrix, _ b: Matrix) -> Matrix {
    var result = Matrix(rows: a.rows * b.rows, cols: a.cols * b.cols)
    for i in 0..<a.rows {
        for j in 0..<a.cols {
            for k in 0..<b.rows {
                for l in 0..<b.cols {
                    result[i*b.rows + k, j*b.cols + l] = a[i, j] * b[k, l]
                }
            }
        }
    }
    return result
}

private func kronAll(_ gate: Matrix, count: Int) -> Matrix {
    precondition(count > 0)
    var result = gate
    if count == 1 { return result }
    for _ in 1..<count {
        result = kron(result, gate)
    }
    return result
}
