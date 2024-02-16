//
//  HomeView.swift
//  CryptoPulse
//
//  Created by Magdalena Samuel on 04/07/22.
//

import SwiftUI

struct HomeView: View {
    @State private var showSettings = false
    @State private var showPortfolio = false
    @State private var showLoginView = false
    @EnvironmentObject private var viewModel: HomeViewModel
    @EnvironmentObject private var authViewModel: AuthViewModel
    @Namespace var animation
    
    var body: some View {
        ZStack {
            Color.theme.background
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HomeViewHeader(showSettings: $showSettings)
                    
                    PortfolioHeader(animation: animation)
                        .frame(width: UIScreen.main.bounds.width - 32, height: 120)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                if AuthViewModel.shared.userSession == nil {
                                    self.showLoginView.toggle()
                                } else {
                                    self.showPortfolio.toggle()
                                }
                            }
                        }
                        .padding(.bottom)
                    
                    TopMoversView(viewModel: viewModel)
                        .padding(.horizontal)
                    
                    Divider()
                    
                    Text("All Coins")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                        .padding(.vertical, 8)
                    
                    SearchBarView(searchText: $viewModel.searchText)
                    
                    columnTitles
                    
                    allCoinsList
                }
            }
            
            if showPortfolio, let user = authViewModel.user {
                UserPortfolioView(show: $showPortfolio, user: user)
            }
        }
        .fullScreenCover(isPresented: $showLoginView) {
            LoginView()
        }
        .fullScreenCover(isPresented: $showSettings) {
            SettingsView()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            HomeView()
                .navigationBarHidden(true)
        }
        .preferredColorScheme(.dark)
        .environmentObject(dev.viewModel)
    }
}

extension HomeView {
    private var allCoinsList: some View {
        ZStack {
            ScrollView {
                ForEach(viewModel.allCoins) { coin in
                    NavigationLink {
                        //                        LazyNavigationView(CoinDetailView(coin: coin))
                        CoinDetailView(coin: coin)
                    } label: {
                        CoinRowView(coin: coin)
                            .padding(.leading, 4)
                            .padding(.trailing)
                            .padding(.bottom, 8)
                    }
                }
            }
            
            if viewModel.isLoading {
                CustomProgressView()
            }
        }
    }
    
    
    private var columnTitles: some View {
        HStack {
            Text("Coin")
            
            Spacer()
            
            if showPortfolio {
                Text("Holdings")
            }
            
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryText)
        .padding(.horizontal)
    }
}
