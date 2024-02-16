//
//  SettingsView.swift
// CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct SettingsView: View {
    @State var darkModeEnabled = false
    @State var enableFaceId = false
    @State var enableNotifications = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Appearance")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    SettingsToggleRowView(imageName: "moon.circle.fill",
                                          title: "Dark Mode",
                                          imageTintColor: .purple,
                                          isOn: $darkModeEnabled)
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Privacy")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    VStack {
                        SettingsToggleRowView(imageName: "faceid",
                                              title: "Enable Face ID",
                                              imageTintColor: Color(.darkGray),
                                              isOn: $enableFaceId)
                        
                        Divider()
                            .padding(.horizontal)
                        
                        SettingsRowView(imageName: "lock.circle.fill", title: "Password", imageTintColor: .blue)
                    }
    //                .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 10))
                    .foregroundColor(Color.theme.itemBackgroundColor)
                    
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("Notifications")
                        .font(.headline)
                        .fontWeight(.semibold)

                    SettingsToggleRowView(imageName: "bell.circle.fill",
                                          title: "Push Notifications",
                                          imageTintColor: Color(.systemPink),
                                          isOn: $enableNotifications)
                }
                .padding()
                
    //            Spacer()
                
                VStack(alignment: .leading) {
                    Text("Account")
                        .font(.headline)
                        .fontWeight(.semibold)
                    
                    Button {
                        AuthViewModel.shared.signOut()
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward.square.fill")
                                .font(.title)
                                .foregroundColor(Color(.systemRed))

                            Text("Logout")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundColor(Color.theme.accent)
                            
                            Spacer()
                        }
                        .padding(.leading)
                    }
                    .frame(height: 48)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.theme.itemBackgroundColor)
                    )
                    .padding(.vertical)
                }
                .padding()
                
                Spacer()
                
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }

                }
            }
            .background(Color.theme.background)
        }
    }
}

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let imageTintColor: Color
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: imageName)
                    .font(.title2)
                    .imageScale(.large)
                    .foregroundColor(imageTintColor)

                Text(title)
                    .font(.subheadline)
                    .foregroundColor(Color.theme.accent)
                
                Spacer()
            }
            .frame(height: 48)
            .padding(.leading)
        }
    }
}

struct SettingsToggleRowView: View {
    let imageName: String
    let title: String
    let imageTintColor: Color
    @Binding var isOn: Bool
    
    var body: some View {
        Toggle(isOn: $isOn) {
            Image(systemName: imageName)
                .font(.title2)
                .imageScale(.large)
                .foregroundColor(imageTintColor)
            
            Text(title)
                .font(.subheadline)
                .foregroundColor(Color.theme.accent)
        }
        .padding(.horizontal)
        .frame(height: 48)
        .background(Color.theme.itemBackgroundColor)
        .cornerRadius(10)
        .toggleStyle(SwitchToggleStyle(tint: .blue))
    }
}


struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .preferredColorScheme(.dark)
    }
}
