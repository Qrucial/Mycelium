// SPDX-License-Identifier: Apache-2.0
// Draft, example of Mycelium Solidity solution
pragma solidity ^0.8.10;

// DRAFT In this example, 5 parties (threshold = 5) need to agree to execute the critical_impact() function


contract Example_Mycelium {

    mapping (address => uint256) internal unlockers;             // ID to vote number
    mapping (uint256 => uint256) internal function_locks;        // Function required to be unlocked
    uint256 threshold;                                           // Threshold for unlock
    


    constructor() {
        // Add starter unlocker addresses
        threshold = 5;
    }

    function unlocker_role_add() external pure returns (bool){
        // Require to be unlocker
        // IF not listed, list +1 with msg.sender
        // IF listed and unlocker havent voted yet +1
        // First add +1 count
        
        return true;
    } 
    
    
    function function_unlocker() external pure returns (bool){
        // Require to be in list of unlockers
        return true;
        // Also add time limit!
    }

    function critical_impact1() external view returns (bool) {
        require(function_locks[0] > threshold);
        return true;
    }
    
    
    function critical_impact2() external view returns (bool) {
        require(function_locks[1] > threshold);
        return true;
    }


    function minor_impact() external pure returns (bool) {
        return true;                                                    // No unlock check, just execute
    }
}
