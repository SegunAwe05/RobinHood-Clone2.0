//
//  GraphView.swift
//  StockProject
//
//  Created by Segun Awe on 2/18/21.
//

import SwiftUI
import SwiftUICharts

struct GraphView: View {
    @StateObject var viewer = HistoryClass()
    @StateObject var fetcher = LongHistory()
    var dub: [Double]
    var data: stockSymbol
    let chartStyle = ChartStyle(backgroundColor: Color.white, accentColor: Color.green, gradientColor: GradientColor(start: Color.green, end: Color.green), textColor: Color.black, legendTextColor: Color.black, dropShadowColor: Color.white)
    let myCustomStyle = CGSize(width: 410, height: 200)
    var body: some View {
        ZStack {
            LineChartView(data: dub,  title: "", style: chartStyle, form: myCustomStyle, rateValue: 0)
            MultiLineChartView(data: [( dub, GradientColor(start: Color.green, end: Color.green)), ( dub, GradientColor(start: Color.green, end: Color.green)), ( dub, GradientColor.init(start: Color.green, end: Color.green))], title: "", style: chartStyle, form: myCustomStyle, rateValue: 0).opacity(0.5)
        }
    }
}

struct GraphView_Previews: PreviewProvider {
    static var previews: some View {
        GraphView(dub: [2.0,1.0,1.2,2.0], data: stockSymbol())
    }
}


