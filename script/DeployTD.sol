pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/ExerciseSolution.sol";


contract DeployTokenScript is Script{
    function run() external{
        vm.startBroadcast();
        ExerciceSolution token = new ExerciceSolution(0x25eAAb6F813137fC9BE0b4ada462aA535e2ea37a);
        vm.stopBroadcast();
    }
}
