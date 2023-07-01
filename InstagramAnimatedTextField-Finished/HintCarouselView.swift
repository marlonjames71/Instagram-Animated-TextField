//
//  HintCarouselView.swift
//  InstagramAnimatedTextField-Finished
//
//  Created by Marlon Raskin on 2023-05-24.
//

import SwiftUI

struct HintCarouselView: View {
	
	private let placeholder: String?
	private let hints: [String]
	
	@State private var currentIndex: Int
	@State private var id: Bool = false
	
	private let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
	
	private let hintsCount: Int
	
	enum StartIndex {
		case random
		case first
	}
	
	// MARK: - Init
	
	init(placeholder: String?, hints: [String], startIndex: StartIndex) {
		self.placeholder = placeholder
		self.hints = hints
		
		hintsCount = hints.count
		
		switch startIndex {
		case .random:
			_currentIndex = State(initialValue: Int.random(in: 0..<hints.count))
		case .first:
			_currentIndex = State(initialValue: 0)
		}
	}
	
	// MARK: - Body
	
	var body: some View {
		HStack(spacing: 10) {
			if let placeholder {
				Text(placeholder)
			}
			
			Text(hints[currentIndex].quoted())
				.transition(textTransition)
				.id(id)
			
			Spacer()
		}
		.foregroundStyle(.secondary)
		.tint(.secondary)
		.onReceive(timer) { _ in
			withAnimation { updateCurrentIndex() }
		}
	}
	
	// MARK: - Helpers
	
	private var textTransition: AnyTransition {
		AnyTransition.asymmetric(
			insertion: .move(edge: .bottom).combined(with: .opacity),
			removal: .move(edge: .top).combined(with: .opacity)
		)
	}
	
	private func updateCurrentIndex() {
		currentIndex = (currentIndex + 1) % hintsCount
		id.toggle()
	}
}

// MARK: - Previews -

struct HintCarouselView_Previews: PreviewProvider {
	static var previews: some View {
		VStack {
			HintCarouselView(
				placeholder: "Search",
				hints: ExampleHints.shopping,
				startIndex: .random
			)
		}
	}
}
