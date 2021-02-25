//
//  ContentView.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var viewModel: FetchData
    
    var body: some View {
        NavigationView {
            ZStack {
                TabView {
                    HomeView()
                        .tabItem{
                            Image(systemName: "house")
                                .foregroundColor(.white)
                        }
                    SearchView()
                        .tabItem{
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                            
                        }
                }.accentColor(.green)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: FetchData())
    }
}
