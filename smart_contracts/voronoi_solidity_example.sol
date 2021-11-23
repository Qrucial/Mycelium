// SPDX-License-Identifier: Apache-2.0
// Draft, example of Voronoi Solidity solution, by QRUCIAL OÜ
// Coder: Six
pragma solidity ^0.8.10;

// DRAFT In this example, 4 parties (threshold = 4) out of 6 need to agree to execute the critical_impact() function
// Requirement: no single account should be able to call any Major Impact function.

contract Voronoi_Example {

    mapping (address => uint256) internal unlockers;                // Address to threshold amount (single account can have multiple)
    mapping (uint256 => uint256) internal function_locks;           // Function required to be unlocked
    uint256 private threshold;                                              // Threshold for unlock
    
    event major_impact_call(bool value);                            // Event when a Major Impact Function is called
    event minor_impact_call(bool value);                            // Event when a Minor Impact Function is called
    event function_unlock(uint256 value);                           // Unlock event, when a function gets unlocked, unit256 -> func ID

    constructor() {
        threshold = 4;                                              // An unlock happens when this threshold is reached or passed
        unlockers[msg.sender] = 1;                                  // Add starter unlocker addresses, in this example 6
        unlockers[0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2] = 1;
        unlockers[0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c] = 1;
        unlockers[0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db] = 1;
        unlockers[0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB] = 1;
        unlockers[0x617F2E2fD72FD9D5503197092aC168c91465E7f2] = 1;
        function_locks[0] = 0;                                      // Locked function [0] - unlocker_role_add()
        function_locks[1] = 0;                                      // Locked function [1] - critical_impact1()
        function_locks[2] = 0;                                      // Locked function [1] - critical_impact2()
    }

    function unlocker_role_add(address new_unlocker) external returns (bool){
        emit major_impact_call(true);
        require(unlockers[msg.sender] == 1);
        require(function_locks[0] >= threshold);
        unlockers[new_unlocker] = 1;
        return true;
    }
    
    function unlock_voter(uint256 func_id) external returns (bool){
        require(unlockers[msg.sender] == 1);
        unlockers[msg.sender] = 0;                                 // This needs to be improved, as now everyone can only vote once
        function_locks[func_id] = function_locks[func_id] + 1;
        return true;
    }
    
    function critical_impact1() external returns (bool) {
        emit major_impact_call(true);
        require(function_locks[1] >= threshold);
        function_locks[1] = 0;  // Can be called only once and threshold is reset.
        return true;
    }
    
    function critical_impact2() external returns (bool) {
        emit major_impact_call(true);
        require(function_locks[2] >= threshold);
        function_locks[2] = 0;  // Can be called only once and threshold is reset.
        return true;
    }

    function minor_impact() external returns (bool) {    // No unlock check, just execute
        emit minor_impact_call(true);
        return true;
    }
}
