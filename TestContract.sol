// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.13;
 
contract TestContract {
    uint count = 0;
    uint[] array = [1, 2, 3, 4, 5, 6];

    modifier IndexValidation(uint index) {
        require(index < array.length && index >= 0, "Invalid index");
        _;
    }
    error NothingToRemove();

    function removeByShifting(uint _indx) IndexValidation(_indx) public {        
        if(array.length == 0) {
            revert NothingToRemove();
        }
        for(_indx; _indx<array.length-1; _indx++){
            array[_indx] = array[_indx+1];
        }
        array.pop();
    }
    function removeByReplace(uint _indx) IndexValidation(_indx) public {        
        if(array.length == 0) {
            revert NothingToRemove();
        }
        array[_indx] = array[array.length-1];
        array.pop();
    }
    function get_array() external view returns(uint[] memory) {
        return array;
    }

    // test
    function test() external {    
        removeByReplace(2); // el: 3
        removeByShifting(3); // el: 4
        assert(array[2] == 6);        
        assert(array[3] == 5);
    }
    // test end
}

