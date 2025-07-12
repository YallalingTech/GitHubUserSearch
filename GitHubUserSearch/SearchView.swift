//
//  ContentView.swift
//  GitHubUserSearch
//
//  Created by Yallaling on 11/07/25.
//

import SwiftUI

struct SearchView: View {
    @StateObject private var vm = GitHubViewModel()
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    @EnvironmentObject var appNavigationManager: NavigationManager
    
    var body: some View {
        NavigationStack(path: $appNavigationManager.navigationPath) {
            VStack(spacing: 16) {
                
                // GitHub username input
                TextField("Enter GitHub username", text: $vm.username)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .frame(maxWidth: .infinity)
                    .onChange(of: vm.username) { newValue in
                        vm.username = newValue.filter { $0.isLetter || $0.isNumber }
                    }

                // Search Button
                Button(action: {
                    isLoading = true
                    vm.searchUser { error in
                        isLoading = false
                        if let error = error {
                            alertMessage = error
                            showAlert = true
                        } else {
                            appNavigationManager.pushView(.userSearch)
                        }
                    }
                }) {
                    Text("Search")
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(vm.username.trimmingCharacters(in: .whitespaces).isEmpty ? Color.gray.opacity(0.3) : Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .disabled(vm.username.trimmingCharacters(in: .whitespaces).isEmpty)

                Spacer()
            }
            .padding()
            .navigationTitle("GitHub Search")
            .appLoader(isPresented: isLoading, message: "Please wait...")
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Error!"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }
            .navigationDestination(for: NavigationDestination.self) { destination in
                switch destination {
                case .userSearch:
                    UserDetailView(vm: vm)
                }
            }
        }
    }
}

#Preview {
    SearchView()
        .environmentObject(NavigationManager.shared)
}
