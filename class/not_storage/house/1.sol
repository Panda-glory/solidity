pragma solidity ^0.4.24;
contract check{
    struct player{
        string name;
    }
    bytes32[] public goals;
    mapping(address => player)public players;
    constructor()public{
        bytes32 goal1 = keccak256(blockhash(block.number-1));
        goals.push(goal1);
    }
    function createPlayer(string _name)public{
        player temp;
        temp.name =_name;
        players[msg.sender]=temp;
    }

    function addGoal()public{
        bytes32 goaltemp = keccak256(blockhash(block.number-1));
        goals.push(goaltemp);
    }
    function getgoal1() public view returns(bytes32){
        return goals[0];
    }

}
