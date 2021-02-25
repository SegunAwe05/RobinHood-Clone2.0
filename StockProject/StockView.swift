//
//  StockView.swift
//  StockProject
//
//  Created by Segun Awe on 2/13/21.
//


import SwiftUI
import SwiftUICharts

struct StockView: View {
    @StateObject var viewer = HistoryClass()
    @Environment(\.managedObjectContext) var managedObjectContext
    @StateObject var fetcher = LongHistory()
    var data: stockSymbol
    var hist = historicalData(open: 0.4)
    var histL = LongHist(historical: [result(open: 23.0)])
    @State var oneDay = true
    @State var oneWeek = false
    @State var oneMonth = false
    @State var threeMonth = false
    @State var oneYear = false
    @State var fiveYear = false
    @Environment( \.presentationMode) var goBack
    
    // fetching data from core data
    @FetchRequest(entity: StockData.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \StockData.open, ascending: true)]) var results : FetchedResults<StockData>
    
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    // back arrow
                    Button(action: {
                        self.goBack.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left").font(.system(size: 30))
                            .frame(width: 40 , height: 40)
                            .foregroundColor(.green)
                            .padding(5)
                            .modifier(BarShadows())
                        Spacer()
                        
                        
                        Button(action: {
                            // add to list. Doesn't work
                            print("added to list")
                        }) {
                            Image(systemName: "plus")
                                .font(.system(size: 30))
                                .foregroundColor(.green)
                                .padding(5)
                        }
                        Spacer().frame(width: 25)
                    }
                }
                Spacer().frame(height:20)
                HStack {
                    VStack(alignment: .leading) {
                        Text(data.symbol ?? "NA").font(.subheadline)
                            .foregroundColor(.black)
                            .padding(5)
                        Text(data.name ?? "NA").font(.title)
                            .foregroundColor(.black)
                            .padding(5)
                        Text("$\(data.price ?? 20.0)")
                            .foregroundColor(.black)
                    }
                    Spacer()
                }
                Spacer().frame(height: 20)
                /// chart with conditionals,  one day and one week share the same graph
                Group {
                    if oneMonth == true {
                        GraphView(viewer: HistoryClass(), fetcher: LongHistory(), dub: fetcher.longData.historical.map{$0.open}, data: stockSymbol())
                    } else if threeMonth == true{
                        GraphView(viewer: HistoryClass(), fetcher: LongHistory(), dub: fetcher.longData.historical.map{$0.open}, data: stockSymbol())
                    } else if oneYear == true {
                        GraphView(viewer: HistoryClass(), fetcher: LongHistory(), dub: fetcher.longData.historical.map{$0.open}, data: stockSymbol())
                    } else if fiveYear == true {
                        GraphView(viewer: HistoryClass(), fetcher: LongHistory(), dub: fetcher.longData.historical.map{$0.open}, data: stockSymbol())
                    } else {
                        GraphView(viewer: HistoryClass(), fetcher: LongHistory(), dub: viewer.histData.map{$0.open}, data: stockSymbol())
                    }
                    Text("Today")
                        .foregroundColor(.green)
                        .bold()
                        .padding(.trailing, 350)
                        
                }
              
                Spacer().frame(height: 25)
                Divider()
                Spacer().frame(height: 25)
                // button HStack
                HStack {
                    Button( action: {
                        oneDay = true
                        oneWeek = false
                        oneMonth = false
                         threeMonth = false
                         oneYear = false
                        fiveYear = false
                        viewer.getHistData(name: data.symbol ?? "AAPL", context: managedObjectContext)
                    }) {
                        Text("1D").foregroundColor( oneDay ? .white : .green)
                            .frame(width: 30)
                            .background(oneDay ? Color.green : Color.white)
                            .cornerRadius(5)
                            .padding(8)
                    }
                    Button( action: {
                        oneWeek = true
                        oneDay = false
                        oneMonth = false
                         threeMonth = false
                         oneYear = false
                        fiveYear = false
                        viewer.getHistData(name: data.symbol ?? "AAPL", context: managedObjectContext)
                    }) {
                        Text("1W").foregroundColor( oneWeek ? .white : .green)
                            .frame(width: 30)
                            .background(oneWeek ? Color.green : Color.white)
                            .cornerRadius(5)
                            .padding(8)
                    }
                    Button( action: {
                        oneDay = false
                        oneWeek = false
                        oneMonth = true
                         threeMonth = false
                         oneYear = false
                        fiveYear = false
                        fetcher.getHistData(name: data.symbol ?? "AAPL", date: "30")
                    }) {
                        Text("1M").foregroundColor( oneMonth ? .white : .green)
                            .frame(width: 30)
                            .background(oneMonth ? Color.green : Color.white)
                            .cornerRadius(5)
                            .padding(8)
                    }
                    Button( action: {
                        oneDay = false
                        oneWeek = false
                        oneMonth = false
                         threeMonth = true
                         oneYear = false
                        fiveYear = false
                        fetcher.getHistData(name: data.symbol ?? "AAPL", date: "60")
                    }) {
                        Text("3M").foregroundColor( threeMonth ? .white : .green)
                            .frame(width: 30)
                            .background( threeMonth ? Color.green : Color.white)
                            .cornerRadius(5)
                            .padding(8)
                    }
                    Button( action: {
                        oneDay = false
                        oneWeek = false
                        oneMonth = false
                         threeMonth = false
                         oneYear = true
                        fiveYear = false
                        fetcher.getHistData(name: data.symbol ?? "AAPL", date: "250")
                    }) {
                        Text("1Y").foregroundColor( oneYear ? .white : .green)
                            .frame(width: 30)
                            .background(oneYear ? Color.green : Color.white)
                            .cornerRadius(5)
                            .padding(8)
                    }
                    Button( action: {
                        oneDay = false
                        oneWeek = false
                        oneMonth = false
                         threeMonth = false
                         oneYear = false
                        fiveYear = true
                        fetcher.getHistData(name: data.symbol ?? "AAPL", date: "1260")
                    }) {
                        Text("5Y").foregroundColor( fiveYear ? .white : .green)
                            .frame(width: 30)
                            .background(fiveYear ? Color.green : Color.white)
                            .cornerRadius(5)
                            .padding(8)
                    }
                }
                Spacer()
            }
        }.onAppear() {
            viewer.getHistData(name: data.symbol ?? "APPL", context: managedObjectContext)
        }
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct StockView_Previews: PreviewProvider {
    static var previews: some View {
        StockView(data: stockSymbol(), hist: historicalData(open: 0.4))
    }
}



