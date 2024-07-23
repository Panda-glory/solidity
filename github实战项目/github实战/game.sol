// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "hardhat/console.sol";
contract Game is Ownable{
    
    // // 管理员，用于开奖
    // address public admin;
    // 游戏轮数
    uint256 public currRound;
    // 截至时间
    uint256 public deadline;
    // 手续费
    uint256 public fee;
    // 锁定用户赢取的奖金
    uint256 public lockAmt;
    // 可选择的国家["OK"]
    string[] public  countries = ["GERMANY", "FRANCH", "CHINA", "BRIZAL", "KOREA"];
    // 玩家
    mapping(uint256 => mapping(address => player)) public players;
    // 记录下注地址
    mapping(uint256 => mapping(string => address[])) public countryToAddress;
    // 记录获胜奖金
    mapping(address => uint256) public winnerVaults;
    // 国家对应的投入比例
    mapping(uint256 => mapping(string => uint256)) public countryTotalAmount;

    
    // 玩家
    struct player{
        bool isSet;
        mapping(string => uint256) counts;
    }

    // event 
    event Play(uint256 _currRound, address _player, string _country);
    event Winning_country(uint256 _currRound, string _country);
    event Withdraw(uint256 _amount,address _account);
    

    // 初始化时可以自定国家，也可以后续添加，初始化奖池金额
    constructor(string[] memory _country,uint256 _deadline,uint256 _fee) Ownable(msg.sender){
        addCountry(_country);
        require(_deadline > block.timestamp,"you should set true right time");
        deadline = _deadline;
        fee = _fee;
    }

    receive() external payable { }


    function play(string memory _country) public payable  {
        // 参数校验
        require(msg.value >= 1 wei,"need input value");
        require(block.timestamp < deadline,"it is over");

        // 往对应国家增加用户
        countryToAddress[currRound][_country].push(msg.sender);

        // 更新player
        player storage account = players[currRound][msg.sender];

        account.counts[_country] = msg.value;

        // 增加对应的投入金额

        emit Play(currRound,msg.sender,_country); 
    }

    // 开奖
    function lottery(string memory _country) onlyOwner external {
        // 获取winner的账户
        address[] memory winner_account = countryToAddress[currRound][_country];

        uint256 winnerBonus = getValueBalance() - fee - lockAmt;

        uint256 distributeAmt;

        for(uint i = 0 ; i< winner_account.length;){

            address currWinner = winner_account[i];

            // 获取账户的份额
            player storage currplayer = players[currRound][currWinner];

            if(currplayer.isSet != true){
                console.log("this winner has benn set already");
                continue;
            }

            currplayer.isSet = true;

            uint256 currplayAmount = currplayer.counts[_country];

            // 计算奖励
            uint256 amt = (winnerBonus / countryTotalAmount[currRound][_country]) / currplayAmount;

            winnerVaults[currWinner] += amt;
            distributeAmt += amt;
            lockAmt += amt;

            console.log("winner:",currWinner,"currCounts:",currplayAmount);

            unchecked{
                ++i;
            }
        }
        // 给管理者的手续费和精度缺失的费用
        uint256 giftAmt = winnerBonus - fee - distributeAmt;
        if(giftAmt > 0){
            winnerVaults[owner()] += giftAmt;
        }
        winnerVaults[owner()] += fee;
    }

    function withdraw() external {
        uint256 rewards = winnerVaults[msg.sender];
        require(rewards > 0,"nothing to withdraw");

        winnerVaults[msg.sender] = 0;
        lockAmt -= rewards;
        (bool succeed,) = msg.sender.call{value : rewards}("");
        require(succeed,"withdraw failed!");

        emit Withdraw(rewards,msg.sender);

    }

    // 添加国家
    function addCountry(string[] memory country) onlyOwner public {
        uint len = country.length;
        for(uint i;i < len;){
            countries.push();
            // unchecked可以减少溢出校验
            unchecked{ 
                ++i;
            }
        }
        
    }

    // 获取奖池金额
    function getValueBalance() public view returns(uint256){
        return address(this).balance;
    }

    // 获取某国参与的人数
    function getCountryPlayters(uint256 _round,string memory _country) public view returns(uint256){
        return countryToAddress[_round][_country].length;
    }

    // 获取某个玩家参与某国的投入
    function getPlayerInfo(uint256 _round,string memory _country,address _player) public view returns(uint256){
        return players[_round][_player].counts[_country];
    }
}