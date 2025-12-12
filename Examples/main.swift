//
//  BellStateExample.swift
//  SwiftQiskit
//
//  Demonstrates creation of a Bell State (|Φ⁺⟩)
//  |Φ⁺⟩ = (|00⟩ + |11⟩) / √2
//

import Foundation
import SwiftQiskitCore

// Create a 2-qubit quantum circuit
let circuit = QuantumCircuit(qubits: 2)
extension String {
    func leftPadded(to length: Int, with pad: Character = "0") -> String {
        if self.count >= length { return self }
        return String(repeating: pad, count: length - self.count) + self
    }
}

// Step 1: Apply Hadamard to qubit 0
circuit.h(0)

// Step 2: Apply CNOT (control=0, target=1)
circuit.apply(CNOTGate.matrix)

// Run the circuit
let finalState = circuit.run()

print("Final quantum state:")
print(finalState)

// Measure multiple times to show correlation
print("\nMeasurement results:")
for _ in 0..<10 {
    let result = circuit.runAndMeasure()
    let binary = String(result, radix: 2).leftPadded(to: 2)
    print(binary)
}
