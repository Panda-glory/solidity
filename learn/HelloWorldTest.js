const { expect } = require("chai");

describe("HelloWorld contract", function () {

  let HelloWorld;
  let hardhatHelloWorld;
  let hardhatHelloWorldAddress;
  let hardhatHelloWorldBalance;
  let owner;
  let addr1;
  let addr2;
  let addrs;

  // `beforeEach` will run before each test, re-deploying the contract every
  // time. It receives a callback, which can be async.
  beforeEach(async function () {
    // Get the ContractFactory and Signers here.
    HelloWorld = await ethers.getContractFactory("HelloWorld");
    [owner, addr1, addr2, ...addrs] = await ethers.getSigners();

    // To deploy our contract, we just have to call HelloWorld.deploy() and await
    // for it to be deployed(), which happens onces its transaction has been
    // mined.
    hardhatHelloWorld = await HelloWorld.deploy();
    await hardhatHelloWorld.deployed();

    hardhatHelloWorldAddress = hardhatHelloWorld.address;
    hardhatHelloWorldBalance = await ethers.provider.getBalance(hardhatHelloWorldAddress);
    hardhatHelloWorldBalance = 100;

    //var balancePromise = ethers.provider.getBalance(hardhatHelloWorldAddress);
    //balancePromise.then(function (result) {
    //  hardhatHelloWorldBalance = result;
    //  //console.log("beforeEach hardhatHelloWorldBalance:", hardhatHelloWorldBalance);
    //});
  });

  // You can nest describe calls to create subsections.
  describe("Deployment", function () {
    // `it` is another Mocha function. This is the one you use to define your
    // tests. It receives the test name, and a callback function.
    
    it("Should be 0 balance", async function () {
      // Why compare balance with string "0"?
      expect(hardhatHelloWorldBalance.toString()).to.equal("0");
    });
  });

  describe("Transactions", function () {
  	  var expectedString = "Hello World! My name is Xing Ming."
    it("Should be '" + expectedString + "'", async function () {
    	 var result = await hardhatHelloWorld.myFirstHelloWorld();
      expect(result).to.equal(expectedString);
    });
  });
});