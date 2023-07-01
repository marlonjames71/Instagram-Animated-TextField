//
//  ContentView.swift
//  InstagramAnimatedTextField-Finished
//
//  Created by Marlon Raskin on 2023-05-23.
//

import SwiftUI

struct ContentView: View {
	
	@State private var text = ""
	@State private var text1 = ""
	@State private var text2 = ""
	
	private let example: Example = .shopping
	private let example2: Example = .locationSearch
	
	@Environment(\.colorScheme) var colorScheme
	
	@State private var initialDemo = true
	
	// MARK: - Body
	
	var body: some View {
		NavigationView {
			VStack(spacing: 20) {
				if initialDemo {
					HintTextField(
						icon: Image(systemName: "magnifyingglass"),
						text: $text1,
						inactivePlaceholder: example.inactivePlaceholder,
						activePlaceholder: example.activePlaceholder,
						hints: example.hints
					)
					.padding(.vertical, 10)
					.padding(.horizontal, 16)
					.background(.regularMaterial)
					.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
					.tint(.cyan)
				} else {
					
					HintTextField(
						icon: Image(systemName: "magnifyingglass"),
						text: $text1,
						inactivePlaceholder: example.inactivePlaceholder,
						activePlaceholder: example.activePlaceholder,
						hints: example.hints
					)
					.padding(.vertical, 10)
					.padding(.horizontal, 16)
					.background(
						ZStack {
							RoundedRectangle(cornerRadius: 12)
								.fill(.orange.opacity(colorScheme == .dark ? 0.1 : 0.2))
							RoundedRectangle(cornerRadius: 12)
								.stroke(.orange, lineWidth:colorScheme == .dark ? 0.5 : 1)
						}
					)
					.clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
					.tint(.orange)
					
					HintTextField(
						icon: Image(systemName: "building.2"),
						text: $text2,
						inactivePlaceholder: example2.inactivePlaceholder,
						activePlaceholder: example2.activePlaceholder,
						hints: example2.hints
					)
					.padding(.vertical, 12)
					.overlay(alignment: .bottom) {
						Rectangle()
							.fill(.primary.opacity(0.4))
							.frame(height: 1)
					}
					.padding(.horizontal, 16)
					.tint(.orange)
				}
				
				Spacer()
			}
			.padding()
			.background(background)
			.navigationTitle("Discover")
		}
	}
	
	@ViewBuilder
	var background: some View {
		if initialDemo {
			LinearGradient(
				colors: [.indigo, .teal, .cyan, .blue],
				startPoint: .top,
				endPoint: .bottom
			)
			.ignoresSafeArea()
			.ignoresSafeArea(.keyboard, edges: .bottom)
		} else {
			Color(uiColor: .secondarySystemBackground)
				.ignoresSafeArea()
				.ignoresSafeArea(.keyboard, edges: .bottom)
		}
	}
}

// MARK: - Previews -

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
