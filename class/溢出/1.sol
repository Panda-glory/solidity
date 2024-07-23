pragma solidity ^0.4.23;
contract DemoContract {
		uint8 x = 2;
		uint public shift = 250 << x; // result: 232.
		uint public exp = 250 ** x; // result: 36.

}
