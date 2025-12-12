import SwiftUI
import SwiftQiskitCore

struct ContentView: View {

    @State private var circuit = QuantumCircuit(qubits: 2)
    @State private var output: String = "Ready."

    var body: some View {
        HStack(spacing: 16) {

            // Gate panel
            VStack(alignment: .leading, spacing: 12) {
                Text("Quantum Gates")
                    .font(.headline)

                Button("H on q0") {
                    circuit.h(0)
                }

                Button("X on q1") {
                    circuit.x(1)
                }

                Button("CNOT (0 → 1)") {
                    circuit.apply(CNOTGate.matrix)
                }

                Divider()

                Button("Run") {
                    let state = circuit.run()
                    output = state.description
                }

                Button("Measure") {
                    let m = circuit.runAndMeasure()
                    output = "Measured: \(String(m, radix: 2))"
                }

                Spacer()
            }
            .frame(width: 220)
            .padding()
            .background(Color.gray.opacity(0.1))

            // Output panel
            VStack(alignment: .leading) {
                Text("Output")
                    .font(.headline)

                ScrollView {
                    Text(output)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                }
            }
            .padding()
        }
    }
}
