pragma solidity ^0.8.0;

contract DemoContract {
		uint x = 200;
		uint public shift1 = 250 << x; // result: 401734511064747568885490523085290650630550748445698208825344000.
		uint y = 350;
		uint public shift2 = 250 << y; // result: 0.
}
