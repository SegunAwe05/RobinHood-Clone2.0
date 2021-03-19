//
//  HomeView.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel = FetchData()
    
    @State var stockList = "TSLA,BCRX,CRSR,AAPL,ELY,GME"

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            VStack{
                HStack {
                    VStack (alignment: .leading, spacing: 5) {
                        Text("RobinHood")
                            .font(.title)
                            .bold()
                            .foregroundColor(.green)
                        
                        Text("My Stocks")
                            .foregroundColor(.green)
                    }
                    Spacer()
                    // add to list button
                    Button(action: {
                        // function doesnt work tried to make list dynamic. cant append without id. APi doesnt come with ids
                        print("added to list")
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 30))
                            .foregroundColor(.green)
                            .padding(5)
                    }
                    Spacer().frame(width: 25)
                }
                Spacer().frame(height:20)
                //List of stocks being displayed
                ForEach(viewModel.hubData, id: \.self) { item in
                    NavigationLink(destination: StockView(data: stockSymbol(symbol: item.symbol, name: item.name, price: item.price))) {
                        CardView( data: stockSymbol(symbol: item.symbol, name: item.name, price: item.price))
                    }
                    Divider()
                }
                Spacer()
            }
            // api allows me to pull a list of stocks.probably not best practice eats a lot of api key if used too much
        }.onAppear() {
            viewModel.getData(name: stockList)
        }
        .navigationTitle("")
        .navigationBarHidden(true)
    }
    
    
    struct HomeView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }
}



                        
                    
