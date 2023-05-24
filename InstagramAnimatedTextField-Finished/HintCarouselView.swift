//
//  HintCarouselView.swift
//  InstagramAnimatedTextField-Finished
//
//  Created by Marlon Raskin on 2023-05-24.
//

import SwiftUI

struct HintCarouselView: View {
	
	let placeholder: String?
	let hints: [String]
	
	@State private var currentIndex: Int = 0
	
	private let timer = Timer.publish(every: 2.5, on: .main, in: .common).autoconnect()
	
	init(placeholder: String?, hints: [String]) {
		self.placeholder = placeholder
		self.hints = hints
		self.currentIndex = randomStartIndex
	}
	
	// MARK: - Body
	
	var body: some View {
		HStack(spacing: 10) {
			if let placeholder {
				Text(placeholder)
			}
			
			ForEach(hintData, id: \.0) { (index, hint) in
				if currentIndex % hints.count == index {
					Text(hint.quoted())
						.transition(textTransition)
				}
			}
			
			Spacer()
		}
		.foregroundStyle(.secondary)
		.tint(.secondary)
		.onAppear { currentIndex = randomStartIndex }
		.onReceive(timer) { _ in
			withAnimation { updateCurrentIndex() }
		}
	}
	
	// MARK: - Helpers
	
	private var hintData: [(Int, String)] {
		Array(zip(hints.indices, hints))
	}
	
	private var textTransition: AnyTransition {
		AnyTransition.asymmetric(
			insertion: .move(edge: .bottom).combined(with: .opacity),
			removal: .move(edge: .top).combined(with: .opacity)
		)
	}
	
	private var randomStartIndex: Int {
		Int.random(in: 0..<hints.count)
	}
	
	private func updateCurrentIndex() {
		if currentIndex == hints.count - 1 {
			currentIndex = 0
		} else {
			currentIndex += 1
		}
	}
}

struct HintCarouselView_Previews: PreviewProvider {
	static var previews: some View {
		HintCarouselView(placeholder: "Search", hints: ExampleHints.items)
	}
}
