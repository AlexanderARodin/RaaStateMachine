//
//  WrapperMode.swift
//  
//
//  Created by the Dragon on 19.02.2022.
//

//import Foundation
//	//	//	//	//	//	//	//



@propertyWrapper
struct StateMachine<State: RaaState> {
	private var machine:RaaStateMachine<State>
	var wrappedValue:State {
		get {machine.state}
		set {machine.enter(newValue)}
	}
	var projectedValue:RaaStateMachine<State> {machine}
	
	init( wrappedValue: State) {
		self.machine = RaaStateMachine(with: wrappedValue)
	}
}
