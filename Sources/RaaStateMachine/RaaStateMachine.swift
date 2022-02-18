//
//  RaaStateMachine.swift
//
//
//  Created by the Dragon on 18.02.2022.
//


//import Foundation
//	//	//	//	//	//	//	//


public class RaaStateMachine<State: RaaState> {
	
	public private(set) var state: State {
		willSet {
			state.willExit(to: newValue)
		}
		didSet {
			state.didEnter(from: oldValue)
		}
	}
	
	
	public init(_ state: State) {
		self.state = state
	}
}



public extension RaaStateMachine {
	func isValidNextState(_ nextState: State ) -> Bool {
		State.isTransitionAllowed(from: state, to: nextState)
	}
	func enter( state nextState: State ) -> Bool{
		if isValidNextState(nextState) {
			state = nextState
			return true
		}else{
			return false
		}
	}
}
