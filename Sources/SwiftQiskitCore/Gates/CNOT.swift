//
//  CNOT.swift
//  SwiftQiskit
//
//  Controlled-NOT gate (CNOT)
//  Two-qubit gate used to create entanglement.
//
//  Control = qubit 0, Target = qubit 1
//
//  Truth table:
//  |00⟩ → |00⟩
//  |01⟩ → |01⟩
//  |10⟩ → |11⟩
//  |11⟩ → |10⟩
//
//  Matrix form (4x4):
//  | 1  0  0  0 |
//  | 0  1  0  0 |
//  | 0  0  0  1 |
//  | 0  0  1  0 |
//
//  Created by Ali on 2025-01-XX.
//

import Foundation

public enum CNOTGate {

    /// CNOT matrix (control qubit = 0, target qubit = 1)
    public static let matrix: Matrix = {
        Matrix([
            [Complex.one,  Complex.zero, Complex.zero, Complex.zero],
            [Complex.zero, Complex.one,  Complex.zero, Complex.zero],
            [Complex.zero, Complex.zero, Complex.zero, Complex.one ],
            [Complex.zero, Complex.zero, Complex.one,  Complex.zero]
        ])
    }()
}
