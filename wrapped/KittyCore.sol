/// @title Interface for interacting with the CryptoKitties Core contract created by Dapper Labs Inc.
contract KittyCore {
    function ownerOf(uint256 _tokenId) public view returns (address owner);
    function transferFrom(address _from, address _to, uint256 _tokenId) external;
    function transfer(address _to, uint256 _tokenId) external;
    mapping (uint256 => address) public kittyIndexToApproved;
}
