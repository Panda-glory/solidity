pragma solidity ^0.7.0;

contract DemoContract {
		uint8 x = 2;
		uint public shift = 250 << x; // result: 1000.
		uint public exp = 250 ** x; // result: 62500.

}
