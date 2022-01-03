// SPDX-License-Identifier: Apache-2.0
// Example of Voronoi Solidity solution, by QRUCIAL OÜ
// Code state: Beta
// Coder: Six

pragma solidity ^0.8.11;

contract VoronoiToken {
    string public constant name     = "VoronoiERC20";
    string public constant symbol   = "VE2";
    uint8  public constant decimals = 0;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event major_impact_call(bool value);                                                // Event when a Major Impact Function is called
    event minor_impact_call(bool value);                                                // Event when a Minor Impact Function is called
    event function_unlock(uint256 value);                                               // Unlock event, when a function gets unlocked, unit256 -> func ID

    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;
    
    mapping (uint256 => address) internal unlocker_ids;                                      // Needs to be in sync with the unlocker_ids, max 10
    mapping (uint256 => uint256) internal unlocker_stakes;                                   // Address to threshold amount (single account can have multiple)

    uint256 private totalSupply_ = 100000000;

    address private admin;
    
    uint256 private _voronoi_count;
    uint256 private threshold;
    uint256 private _voronoi_last_time;

    bool private _paused;

    constructor() {
        admin = msg.sender;
        balances[msg.sender] = totalSupply_;
        _paused = false;
        _voronoi_count = 0;
        threshold = 3;
        _voronoi_last_time = block.timestamp;
        unlocker_ids[0] = 0x709843b3669cEf2168B626E785A7c670d7B2696D;
        unlocker_ids[1] = 0xf6D347765f1c5561C43F71b49a453a337711645b;
        unlocker_ids[2] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[3] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[4] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[5] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[6] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[7] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[8] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
        unlocker_ids[9] = 0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6;
    }

    function v_reset() external returns (bool success){
        emit major_impact_call(true);
        require(block.timestamp >= _voronoi_last_time + 1 hours);                           // You can only do it once every hour to secure voting logic
        _voronoi_last_time = block.timestamp;
        _voronoi_count = 0;
        unlocker_stakes[0] = 1;
        unlocker_stakes[1] = 1;
        unlocker_stakes[2] = 1;
        unlocker_stakes[3] = 1;
        unlocker_stakes[4] = 1;
        unlocker_stakes[5] = 1;
        unlocker_stakes[6] = 1;
        unlocker_stakes[7] = 1;
        unlocker_stakes[8] = 1;
        unlocker_stakes[9] = 1;
        return true;
    }

    function unlocker_role_change(uint256 _id, address _new_unlocker) external returns (bool){
        emit major_impact_call(true);
        require(msg.sender == unlocker_ids[0]);
        require(_voronoi_count >= threshold);
        unlocker_ids[_id] = _new_unlocker;
        return true;
    }


    function pause() external returns (bool success) {
        require(msg.sender == admin, "Not authorized");
        emit major_impact_call(true);
        require(_voronoi_count >= threshold);
        _paused = true;
        return _paused;
    }

    function unpause() external returns (bool success) {
        require(msg.sender == admin, "Not authorized");
        emit major_impact_call(true);
        require(_voronoi_count >= threshold);
        _paused = false;
        return _paused;
    }

    function adminChange(address newAdmin) external returns (address to) {
        require(msg.sender == admin, "Not authorized");
        emit major_impact_call(true);
        require(_voronoi_count >= threshold);
        admin = newAdmin;
        return newAdmin;
    }


    function totalSupply() external view returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address _owner) external view returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) external returns (bool success) {
        require(_paused == false);
        require(_value <= balances[msg.sender]);
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success) {
        require(_paused == false);
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);


        balances[_from] -= _value;
        allowed[_from][msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) external returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function allowance(address _owner, address _spender) external view returns (uint remaining) {
        return allowed[_owner][_spender];
    }

    function adminWithdraw() external returns (bool success) {
        require(msg.sender == admin, "Not authorized");
        emit major_impact_call(true);
        require(_voronoi_count >= threshold);
        payable(msg.sender).transfer(address(this).balance);
        return true;
    }

    fallback() external payable {}
    receive() external payable {}
}
