//
// This source file is part of the Stanford HealthGPT project
//
// SPDX-FileCopyrightText: 2023 Stanford University & Project Contributors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import HealthKit
import SpeziLLMOpenAI
import SpeziOnboarding
import SwiftUI


/// Displays an multi-step onboarding flow for the HealthGPT Application.
struct OnboardingFlow: View {
    @AppStorage(StorageKeys.onboardingFlowComplete) var completedOnboardingFlow = false
    @AppStorage(StorageKeys.llmSource) var llmSource = StorageKeys.Defaults.llmSource
    
    
    var body: some View {
        OnboardingStack(onboardingFlowComplete: $completedOnboardingFlow) {
            Welcome()
            Disclaimer()
            
            if FeatureFlags.localLLM {
                LLMLocalDownload()
            } else {
                LLMSourceSelection()
            }
            
            if HKHealthStore.isHealthDataAvailable() {
                HealthKitPermissions()
            }
        }
            .navigationBarTitleDisplayMode(.inline)
            .interactiveDismissDisabled(!completedOnboardingFlow)
    }
}


#if DEBUG
struct OnboardingFlow_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFlow()
    }
}
#endif
