//
//  SearchView.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//

import SwiftUI

struct SearchView: View {
    @StateObject var viewModel = FetchData()
    @State var searchText = ""
    @State var isLoading = false
        
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            if isLoading {
                LoadingView()
            } else {
                ScrollView{
                    LazyVStack{
                        searchBar(text: $searchText) // search bar view. filter searching below
                        Spacer().frame(height:20)
                        ForEach(viewModel.hubData.filter({ ($0.symbol?.localizedCaseInsensitiveContains(searchText))! || searchText.isEmpty }), id: \.self) { item in
                            NavigationLink(destination: StockView(data: stockSymbol(symbol: item.symbol, name: item.name, price: item.price))) {
                                CardView( data: stockSymbol(symbol: item.symbol, name: item.name, price: item.price)) // View for cards
                            }
                            Divider()
                        }
                        Spacer().frame(height: 250)
                        Button(action: {
                            viewModel.getData(name: searchText)
                        }) {
                            Text("Click To Search")
                                .frame(width: 200, height: 50)
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(15)
                        }
                    }
                }.navigationBarTitle("")
                .navigationBarHidden(true)
            }
        }.onAppear() {
            networkCall()
        }
        
    }
    
    // load data
    func networkCall() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline:.now() + 2) {
            isLoading = false
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(viewModel: FetchData())
    }
}

 
struct LoadingView: View {
    var body: some View {
        ZStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .green))
                .scaleEffect(2)
            VStack {
                Text("Search Stock symbols with Uppercase Letters")
                    .foregroundColor(.black)
                Spacer()
            }
            
        }
    }
}
