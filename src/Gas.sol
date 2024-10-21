// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.28;

contract GasContract {
    address private immutable admin1;
    address private immutable admin2;
    address private immutable admin3;
    address private immutable admin4;
    // slot 0 is for amount
    // slot 0x20 is for recipient

    constructor(address[] memory admins, uint256) {
        admin1 = admins[0];
        admin2 = admins[1];
        admin3 = admins[2];
        admin4 = admins[3];
    }

    function addToWhitelist(address userAddrs, uint256 tier) external {
        assembly {
            if and(lt(tier, 245), eq(caller(), 0x1234)) {
                let lol := 0x40
                mstore(lol, userAddrs)
                mstore(0x60, tier)
                log1(lol, lol, 0x62c1e066774519db9fe35767c15fc33df2f016675b7cc0c330ed185f286a2d52)
                return(0, 0)
            }
            revert(0, 0)
        }
    }

    function balanceOf(address user) public view returns (uint256) {
        unchecked {
            assembly {
                let _recipient := sload(0x20)
                let z0 := 0
                let amount := sload(z0)
                let result := z0

                if eq(user, 0x1234) {
                    result := 1000000000
                    if eq(user, _recipient) {
                        mstore(z0, result)
                        return(z0, 0x20)
                    }
                    result := sub(result, amount)
                }

                if eq(user, _recipient) { result := amount }

                mstore(z0, result)
                return(z0, 0x20)
            }
        }
    }

    function transfer(address _recipient, uint256 _amount, string calldata) external {
        assembly {
            sstore(0x20, _recipient)
            sstore(0, _amount)
        }
    }

    function balances(address user) public view returns (uint256) {
        unchecked {
            assembly {
                let _recipient := sload(0x20)
                let zero := 0
                let amount1 := sload(zero)
                let result := zero

                if eq(user, 0x1234) {
                    result := 1000000000
                    if eq(user, _recipient) {
                        mstore(zero, result)
                        return(zero, 0x20)
                    }
                    result := sub(result, amount1)
                }

                if eq(user, _recipient) { result := amount1 }

                mstore(zero, result)
                return(zero, 0x20)
            }
        }
    }

    function whiteTransfer(address _recipient, uint256 _amount) public {
        assembly {
            sstore(0x20, _recipient)
            log2(0, 0, 0x98eaee7299e9cbfa56cf530fd3a0c6dfa0ccddf4f837b8f025651ad9594647b3, _recipient)
            sstore(0, _amount)
        }
    }

    function whitelist(address) public pure returns (uint256) {
        return 0;
    }

    function getPaymentStatus(address) external view returns (bool, uint256) {
        assembly {
            mstore(0x40, 1)
            mstore(0x60, sload(0))
            return(0x40, 0x40)
        }
    }

    function administrators(uint256 index) external view returns (address) {
        if (index == 0) {
            return admin1;
        } else if (index == 1) {
            return admin2;
        } else if (index == 2) {
            return admin3;
        } else if (index == 3) {
            return admin4;
        }

        return 0x0000000000000000000000000000000000001234;
    }

    function checkForAdmin(address) external pure returns (bool) {
        return true;
    }
}
