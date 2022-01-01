// SPDX-License-Identifier: Apache-2.0
// Example of Voronoi Solidity solution, by QRUCIAL OÜ
// Code state: DRAFT
// Coder: six

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
    mapping (address => uint256) internal unlockers;                                    // Address to threshold amount (single account can have multiple)

    uint256 private totalSupply_ = 100000000;

    address private admin;
    
    uint256 private _voronoi_count;
    uint256 private threshold;  

    bool private _paused;

    function v_reset() external returns (bool success){
        emit major_impact_call(true);
        require(_voronoi_count >= threshold);
        unlockers[msg.sender] = 1;
        _voronoi_count = 0;
        unlockers[0x709843b3669cEf2168B626E785A7c670d7B2696D] = 1;
        unlockers[0xf6D347765f1c5561C43F71b49a453a337711645b] = 1;
        unlockers[0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6] = 1;
        return true;
    }

    constructor() {
        admin = msg.sender;
        balances[msg.sender] = totalSupply_;
        _paused = false;
        _voronoi_count = 0;
        threshold = 3;
        unlockers[msg.sender] = 1;
        unlockers[0x709843b3669cEf2168B626E785A7c670d7B2696D] = 1;
        unlockers[0xf6D347765f1c5561C43F71b49a453a337711645b] = 1;
        unlockers[0x12EfEdf30745b8EC603e9930eFB48ed94d10c0A6] = 1;
    }

    function unlocker_role_add(address new_unlocker) external returns (bool){
        emit major_impact_call(true);
        require(unlockers[msg.sender] == 1);
        require(_voronoi_count >= threshold);
        unlockers[new_unlocker] = 1;
        return true;
    }

    function unlocker_role_remove(address rem_unlocker) external returns (bool){
        emit major_impact_call(true);
        require(unlockers[msg.sender] == 1);
        require(_voronoi_count >= threshold);
        unlockers[rem_unlocker] = 0;                              // Alternative option to remove fully
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
