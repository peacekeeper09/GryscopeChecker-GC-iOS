import SwiftUI
import CoreMotion

struct GyroscopeCheckView: View {
    @State private var gyroStatus = "Checking gyroscope..."
    @State private var backgroundColor: Color = .blue.opacity(0.8)

    var body: some View {
        VStack {
            Text("Gyroscope Check")
                .font(.title)
                .foregroundColor(.white)
                .padding(.bottom, 20)

            Text(gyroStatus)
                .font(.headline)
                .foregroundColor(.white)
                .padding(.top, 20)
                .opacity(0.7)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5.0) {
                        self.checkGyroscope()
                    }
                }
                .onChange(of: backgroundColor) { newColor, _ in
                    withAnimation {
                        // Apply a smooth background color transition
                    }
                }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor.edgesIgnoringSafeArea(.all))
    }

    private func checkGyroscope() {
        let motionManager = CMMotionManager()

        motionManager.deviceMotionUpdateInterval = 1.0

        motionManager.startDeviceMotionUpdates(to: .main) { (motion, error) in
            guard let motion = motion else { return }

            if motion.rotationRate.x != 0 || motion.rotationRate.y != 0 || motion.rotationRate.z != 0 {
                self.gyroStatus = "Your device supports the gyroscope feature."
                self.backgroundColor = Color.green.opacity(0.8)
            } else {
                self.gyroStatus = "Your device does not support the gyroscope feature."
                self.backgroundColor = Color.red.opacity(0.8)
            }

            motionManager.stopDeviceMotionUpdates()
        }
    }
}

@main
struct GyroscopeCheckApp: App {
    var body: some Scene {
        WindowGroup {
            GyroscopeCheckView()
        }
    }
}
