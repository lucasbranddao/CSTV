//
//  ListView.swift
//  CSTV
//
//  Created by Lucas Brandão on 24/08/24.
//

import SwiftUI

fileprivate enum Destination: Hashable {
    case matchDetails(Match)
}

struct MatchListView<ViewModelObservable>: View where ViewModelObservable: MatchListViewModelProtocol {

    @ObservedObject var viewModel: ViewModelObservable

    var body: some View {

        if $viewModel.isLoading.wrappedValue {
            VStack {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .tint(.lightGray)
                    .scaleEffect(2)
                    .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.darkBlue)
        }
        else {
            NavigationStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        Spacer()
                        ForEach($viewModel.matches, id: \.self) { match in
                            NavigationLink(value: Destination.matchDetails(match.wrappedValue)) {
                                MatchCardView(match: match.wrappedValue)
                                    .padding([.leading, .trailing], 24)
                                    .frame(height: 176)
                            }
                        }
                    }
                }
                .background(Color.darkBlue)
                .navigationTitle("Partidas")
                .navigationBarTitleDisplayMode(.large)
                .navigationDestination(for: Destination.self) { destination in
                    switch destination {
                        case .matchDetails(let match):
                            MatchDetailsView(match: match, viewModel: MatchDetailsViewModel(service: MatchDetailsService()))
                    }
                }
                .refreshable {
                    viewModel.fetchMatches()
                }
            }
            .onAppear {
                UIRefreshControl.appearance().tintColor = .lightGray
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

    init(viewModel: ViewModelObservable) {
        self.viewModel = viewModel
        viewModel.fetchMatches()
    }
}


#Preview {
    MatchListView(viewModel: MatchListViewModel(service: MatchListService()))
}
