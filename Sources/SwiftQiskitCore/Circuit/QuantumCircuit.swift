//
//  QuantumCircuit.swift
//  SwiftQiskit
//
//  High-level abstraction for building and running quantum circuits.
//
//  Created by Ali on 2025-01-XX.
//

import Foundation

// MARK: - QuantumCircuit
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

    // MARK: - Core Gate API

    /// Apply a full-dimension gate (2^n x 2^n)
    public func apply(_ matrix: Matrix) {
        let expectedDim = 1 << qubits
        precondition(
            matrix.rows == expectedDim && matrix.cols == expectedDim,
            "Gate matrix must match circuit dimension (2^n x 2^n)"
        )
        operations.append(Operation(matrix: matrix))
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

    /// Run the circuit and measure once
    public func runAndMeasure() -> Int {
        var state = run()
        return state.measure()
    }
}

// MARK: - Single-Qubit Gates
public extension QuantumCircuit {

    /// Apply Hadamard gate to a specific qubit
    func h(_ qubit: Int) {
        let full = embedSingleQubitGate(
            HadamardGate.matrix,
            qubits: qubits,
            target: qubit
        )
        apply(full)
    }

    /// Apply Pauli-X gate to a specific qubit
    func x(_ qubit: Int) {
        let full = embedSingleQubitGate(
            PauliXGate.matrix,
            qubits: qubits,
            target: qubit
        )
        apply(full)
    }
}

// MARK: - Kronecker Utilities (file-private)

private func kron(_ a: Matrix, _ b: Matrix) -> Matrix {
    var result = Matrix(rows: a.rows * b.rows, cols: a.cols * b.cols)
    for i in 0..<a.rows {
        for j in 0..<a.cols {
            for k in 0..<b.rows {
                for l in 0..<b.cols {
                    result[i * b.rows + k, j * b.cols + l] = a[i, j] * b[k, l]
                }
            }
        }
    }
    return result
}

private func identity(_ size: Int) -> Matrix {
    Matrix.identity(size: size)
}

/// Embed a single-qubit gate into an n-qubit system at a specific qubit index.
/// Qubit indexing: 0 = most-significant (leftmost)
private func embedSingleQubitGate(
    _ gate: Matrix,
    qubits: Int,
    target: Int
) -> Matrix {
    precondition(target >= 0 && target < qubits, "Target qubit out of range")

    var result: Matrix? = nil

    for i in 0..<qubits {
        let factor: Matrix = (i == target) ? gate : identity(2)
        if result == nil {
            result = factor
        } else {
            result = kron(result!, factor)
        }
    }

    return result!
}
