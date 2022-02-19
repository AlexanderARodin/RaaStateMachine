//
//  RaaStateMachine.swift
//
//
//  Created by the Dragon on 18.02.2022.
//


//import Foundation
//	//	//	//	//	//	//	//


public class RaaStateMachine<State: StateProtocol> {
	
	private(set) var state: State
	
	
	init( with state: State) {
		self.state = state
	}
}



public extension RaaStateMachine {
	func isValidNextState(_ nextState: State ) -> Bool {
		state.isValidNextState(nextState)
	}
	func enter( _ nextState: State ){
		if isValidNextState(nextState) {
			state = nextState
		}
	}
	func attemptToEnter( _ nextState: State ) -> Bool{
		if isValidNextState(nextState) {
			state = nextState
			return true
		}else{
			return false
		}
	}
}
