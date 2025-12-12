# SwiftQiskit 

**SwiftQiskit** is a lightweight **quantum computing simulator** written entirely in **Swift**.  
It brings a **Qiskit-like experience** to the Apple ecosystem, with a strong focus on **clarity**, **correctness**, and **future GUI integration**.

>  This project is **experimental and educational**, but grounded in real quantum mechanics principles.

---

##  Features

- ✅ Complex number arithmetic  
- ✅ Matrix operations (including Kronecker products)  
- ✅ State vector simulation  
- ✅ Quantum gates:
  - Hadamard (H)
  - Pauli-X (X)
  - Pauli-Z (Z)
  - CNOT (Controlled-NOT)
- ✅ Single-qubit gate embedding  
- ✅ Quantum circuit abstraction  
- ✅ Measurement & state collapse  
- ✅ Bell State (Entanglement) example  

---

##  Project Structure

```text
SwiftQiskit/
├── Sources/
│   └── SwiftQiskitCore/
│       ├── Math/
│       │   ├── Complex.swift
│       │   └── Matrix.swift
│       ├── Quantum/
│       │   └── StateVector.swift
│       ├── Gates/
│       │   ├── Hadamard.swift
│       │   ├── PauliX.swift
│       │   ├── PauliZ.swift
│       │   └── CNOT.swift
│       └── Circuit/
│           └── QuantumCircuit.swift
├── Examples/
│   └── main.swift
└── Package.swift
````

---

##  Getting Started

### Requirements

* Swift **5.9+**
* macOS **13+**
  *(iOS 16+ planned for future UI integration)*

---

### Clone the Repository

```bash
git clone https://github.com/a360n/SwiftQiskit.git
cd SwiftQiskit
```

### Run the Bell State Example

```bash
swift run SwiftQiskitExamples
```

---

## 🔗 Bell State Example (Entanglement)

The Bell state **|Φ⁺⟩** is defined as:

```
|Φ⁺⟩ = (|00⟩ + |11⟩) / √2
```

### Code Example

```swift
import SwiftQiskitCore

let circuit = QuantumCircuit(qubits: 2)

circuit.h(0)
circuit.apply(CNOTGate.matrix)

let finalState = circuit.run()
print(finalState)

for _ in 0..<10 {
    let result = circuit.runAndMeasure()
    print(result)
}
```

### Expected Measurement Output

```text
00
11
00
11
11
00
```

>  States **01** and **10** never appear —
> this confirms **quantum entanglement**.

---

##  Design Philosophy

* No hidden magic — everything is **explicit and readable**
* Mathematical correctness over shortcuts
* Modular architecture (**Core / Examples / GUI-ready**)
* Designed for **learning**, **experimentation**, and **extension**

---

##  Roadmap

* ⏳ Pauli-Y and Phase gates
* ⏳ Controlled single-qubit gates
* ⏳ Multi-qubit gate routing
* ⏳ Quantum algorithms (Grover, Deutsch–Jozsa)
* ⏳ SwiftUI Circuit Builder (GUI)
* ⏳ Quantum state visualization
* ⏳ XCTest-based validation

---

##  Contributing

Contributions, ideas, and discussions are welcome.
This project is built **step by step** and open for exploration.

---

##  License

**MIT License** © 2025 **Ali Nasser**

---

##  Final Note

**SwiftQiskit** is not just a simulator —
it’s an attempt to make **quantum computing accessible, visual, and native** on Apple platforms.

Enjoy exploring the quantum world 



