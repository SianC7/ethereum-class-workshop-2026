// SPDX-License-Identifier: MIT
// compiler version must be greater than or equal to 0.8.26 and less than 0.9.0

// StakingContract.sol is a small contract where users add ETH to a staking pool.
// Contributions are stored on-chain; users can withdraw at any time. 
// A user may join only once until they withdraw—after withdrawal they can join again.
// Tests are in packages/hardhat/test/StakingContract.ts. 
// (We are doing test driven development, so the tests are written before the implementation of the functions in the contract.)

pragma solidity >=0.8.26 <0.9.0;

import "@openzeppelin/contracts/utils/math/Math.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "hardhat/console.sol";

// Contract to demonstrate Solidity basics
contract StakingContract {
    // Variables
    address public immutable owner;

    enum Ethnicity {
        African,
        European,
        Asian
    }

    // Struct: a custom data type that can group several variables
    struct User {
        string name; // Sender's name
        uint8 age; // Sender's age
        Ethnicity ethnicity; // Sender's ethnicity
        uint256 balance; // Amount of Ether the user has staked in the contract
        uint256 index; // Index of the user in the userAddresses array
        bool exists; // Boolean to track if the user exists in the contract, since mappings do not have a built-in way to check for key existence
    }

    /**
        Mappings in Solidity (mapping(address => uint256)) do not have a built-in way to check if a key exists 
            because all possible keys default to their zero value if not explicitly set.
        You can use an additional boolean mapping to track whether a key has been set
     */
    mapping(address => User) public users; // Key value mapping to store user information, where the key is the user's address and the value is a User struct
    // Array with dynamic size
    address[] public userAddresses;

    // Constants
    // uint256 public constant MAX_PEOPLE = 10;
    uint256 public immutable MAX_PEOPLE = 10;
    bytes32 constant SLOT = 0;

    // Events
    event NumberUpdated(uint256 oldNumber, uint256 newNumber);
    // Indexed parameters help you filter the logs by the indexed parameter
    event UserAdded(address indexed account, string name, uint8 age, uint256 balance);
    event UserWithdrew(address indexed account, string name, uint8 age, uint256 balance);
    // Log of the contract
    event Log(string func, uint256 gas);

    // Modifiers
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

    // Lock implemented using transient state
    modifier lock() {
        assembly {
            if tload(SLOT) {
                revert(0, 0)
            }
            tstore(SLOT, 1)
        }
        _;
        assembly {
            tstore(SLOT, 0)
        }
    }

    // Constructor
    constructor(address _owner, uint256 _max_people) {
        owner = _owner;
        MAX_PEOPLE = _max_people;
    }

    // Fallback function must be declared as external.
    fallback() external payable {
        // send / transfer (forwards 2300 gas to this fallback function)
        // call (forwards all of the gas)
        emit Log("fallback", gasleft());
    }

    // Receive is a variant of fallback that is triggered when msg.data is empty
    receive() external payable {
        emit Log("receive", gasleft());
    }

    /**
        Get the age of the calling address after x years
     */
    function getAge(uint8 _years) public view returns (uint8) {
        User memory user = users[msg.sender];
        user.age = user.age + _years;
        return user.age;
    }

    // Pure function
    function add(uint256 a, uint256 b) public pure returns (uint256) {
        // sum and overflow are local variables
        // it might result in overflow; use SafeMath library
        (bool overflow, uint256 sum) = Math.tryAdd(a, b);
        require(!overflow, "Addition has resulted in an overflow :(");
        return sum;
    }

    /**
        Function returns the number of users in the smart contract
     */
    function getUserCount() public view returns (uint256) {
        uint256 count = userAddresses.length;
        return count;
    }

    /**
     * Function that allows users to store Ether in the smart contract
     */
    function addUser(string memory _name, uint8 _age, Ethnicity ethnicity) public payable{
        // TODO: make sure the function can receive ether -> add payable to the function signature

        // TODO: use require to check if the user sent ether in the calling transaction:
        // msg is a global variable in Solidity that contains information about the current transaction, 
        // including the amount of Ether sent with the transaction (msg.value).
        require(msg.value > 0, "The staking value is 0");

        // TODO: use require to check if user already exists or not
        // msg.sender is the address of the calling user, we use the value as an index to find the user in the users mapping
        require(!users[msg.sender].exists, "User already exists");

        // TODO: use require to check if the users are over the set limit
        require(userAddresses.length < MAX_PEOPLE, "Users are over the limit of 2");

        // TODO: create the user object in memory
        User memory user = User({
            name: _name,
            age: _age,
            ethnicity: ethnicity,
            balance: msg.value,
            index: userAddresses.length,
            exists: true
        });
        
        // TODO: store the user in the users key value mapping
        users[msg.sender] = user; // user object already made in memory, so we can directly assign it to the mapping and persistent storage

        // TODO: store the user address in the userAddresses array
        userAddresses.push(msg.sender);

        // TODO: emit the UserAdded log -> used by people reading the blockchain.
        emit UserAdded(msg.sender, _name, _age, msg.value); // reciept of the transaction, name, age and balance of the user are logged in the event
    }

    // Return many
    function userDetails(address _address) public view returns (string memory name, uint8 age) {
        User memory user = users[_address];
        return (user.name, user.age);
    }

    /**
     * Function that allows the users to withdraw all the Ether they deposited in the smart contract
     */
    function withdraw() external lock {
        // TODO: get the amount to be withdrawn 
        // TODO: use require to check if the user has any money to withdraw
        User memory user = users[msg.sender];
        require(user.exists, "User does not exist"); // Check if the user exists before allowing withdrawal
        require(user.balance > 0, "No balance to withdraw");

        // TODO: uncomment below to view print log messages during testing
        string memory name = users[msg.sender].name;
        console.log(string.concat(name, ' <-> withdrawing '));

        // TODO: use the call function on an address object to send Ether to the user
        // For sending money from a contract
        (bool success, ) = msg.sender.call{value: user.balance}(""); //!!!
        user.balance = 0; // Update the user's balance to 0 after attempting withdrawal

        // TODO: uncomment below to log if withdrawal fails
        console.log(success ? "withdrawal successful": "withdrawal failed");

        // TODO: use require to check if the transfer was successful
        require(success, "Withdrawal failed");

        // TODO: uncomment to call the _delete function
        _delete(msg.sender);
    }

    /**
     * Function that deletes the user record from users and userAddresses after withdrawal
     */
    function _delete(address userAddress) internal {
        // TODO: uncomment this to check for user existence
        // NOTE: We could have used require, but we can't illustrate the attack because the sm logic would fail after the first recursive withdrawal
        if (!users[userAddress].exists){
            return;
        }
        // TODO: get the user object into memory
        User memory user = users[userAddress];

        // TODO: delete the user from the users mapping
        delete users[userAddress]; // delete is a keyword in Solidity that resets the value of the specified key to its default value (for structs, it resets all fields to their default values)

        // TODO: delete the user from users and from the userAddresses array
        // NOTE: first re-locate the address in the last position to the position we are deleting
        address lastUserAddress = userAddresses[userAddresses.length - 1]; // Get the last user address in the array
        userAddresses[user.index] = lastUserAddress; // Move the last user address to the index of the user being deleted
        users[lastUserAddress].index = user.index; // Update the index of the last user in the users mapping to reflect its new position in the userAddresses array

        // NOTE: second edit the re-located user object's index
        // TODO: use pop() to remove the last element of the userAddresses array
        userAddresses.pop(); // Remove the last element of the userAddresses array, which is now a duplicate after the previous step
    }

    // Internal function
    function _internalFunction() internal pure returns (string memory) {
        return "Internal function called";
    }
}

/**
    Inheritance
    List in order of most base-like to most derived
 */
contract ExtendedSolidity is StakingContract {
    constructor(address owner, uint256 _max_people) StakingContract(owner, _max_people) {}

    // New function in derived contract
    function getInternalFunctionResult() public pure returns (string memory) {
        return _internalFunction();
    }
}
