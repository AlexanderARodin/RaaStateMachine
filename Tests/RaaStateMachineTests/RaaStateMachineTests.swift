import XCTest

@testable import RaaStateMachine
//	//	//	//	//	//	//	//



final class RaaStateMachineTests: XCTestCase {
	@StateMachine var state:StateA = .one
	
	func testSimpleTransitions() throws {
		let stateMachine = RaaStateMachine(with: StateA.one)
		XCTAssert(stateMachine.state == .one)
		XCTAssert(stateMachine.isValidNextState(.one))
		XCTAssert(stateMachine.isValidNextState(.two))
		XCTAssert(stateMachine.isValidNextState(.three(i: 3)))
		XCTAssert(stateMachine.isValidNextState(.three(i: 4)))
		XCTAssert(stateMachine.attemptToEnter( .three(i: 5)) )
		XCTAssert(stateMachine.state == .three(i: 5))
		XCTAssert(stateMachine.state != .one)
		XCTAssert(stateMachine.state != .two)
		XCTAssert(stateMachine.state != .three(i: 2))
		
		XCTAssert(stateMachine.isValidNextState(.one))
		XCTAssert(stateMachine.isValidNextState(.two))
		XCTAssert(stateMachine.isValidNextState(.three(i: 3)))
		XCTAssert(!stateMachine.isValidNextState(.three(i: 10)))
		XCTAssert(!stateMachine.attemptToEnter( .three(i: 15)) )
		XCTAssert(stateMachine.state == .three(i: 5))
		XCTAssert(stateMachine.attemptToEnter( .two) )
		XCTAssert(stateMachine.state == .two)
	}
	
	func testWrappedValue() throws {
		XCTAssert(state == .one)
		XCTAssert($state.isValidNextState(.one))
		XCTAssert($state.isValidNextState(.two))
		XCTAssert($state.isValidNextState(.three(i: 3)))
		XCTAssert($state.isValidNextState(.three(i: 4)))
		XCTAssert($state.attemptToEnter( .three(i: 5)) )
		XCTAssert(state == .three(i: 5))
		XCTAssert(state != .one)
		XCTAssert(state != .two)
		XCTAssert(state != .three(i: 2))
		
		XCTAssert($state.isValidNextState(.one))
		XCTAssert($state.isValidNextState(.two))
		XCTAssert($state.isValidNextState(.three(i: 3)))
		XCTAssert(!$state.isValidNextState(.three(i: 10)))
		XCTAssert(!$state.attemptToEnter( .three(i: 15)) )
		XCTAssert(state == .three(i: 5))
		XCTAssert($state.attemptToEnter( .two) )
		XCTAssert(state == .two)
		state = .three(i: 3)
		XCTAssert(state != .three(i: 5))
		XCTAssert(state == .three(i: 3))
	}
}


extension RaaStateMachineTests {
	override func setUpWithError() throws {
		suppressLogs = false
		raaLog("")
		raaLog("---->")
	}
	override func tearDownWithError() throws {
		suppressLogs = false
		raaLog("###############################")
		raaLog("")
	}
}


enum StateA: StateProtocol {
	typealias StateType = StateA
	
	
	static func !=(left: StateA, right: StateA) -> Bool {
		!(left == right)
	}
	static func ==(left: StateA, right: StateA) -> Bool {
		switch (left, right) {
			case (one, one), (two, two):
				return true
			case ( three(let i1), three(let i2) ):
				return i1 == i2
			default:
				return false
		}
	}
	func isValidNextState<StateType>(_ nextState: StateType) -> Bool {
		//	func isValidNextState(_ nextState: RaaState) -> Bool {
		guard let nextState = nextState as? StateA else {return false}
		switch nextState {
			case .three(let i):
				return i < 10
			default:
				return true
		}
	}
	
	
	case one
	case two
	case three( i: Int)
}
