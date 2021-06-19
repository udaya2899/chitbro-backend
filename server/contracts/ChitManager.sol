pragma solidity ^0.8.5;

contract ChitManager {
    uint256 chitLength = 0;

    struct Participant {
	    string walletId;
    }

    struct Chit {
        string chitOwner;
        uint256 chitId;
        string chitName;
        string createdAt;
        string nextPaymentDate;
        uint256 roomCapacity;
        uint256 timePeriod; // Time period from one auction to another
        uint256 poolAmount;
        uint256 chitDuration; // Entire chit duration eg. 5 months
        bool roomFilled;
	    string[] participants;
    }


    mapping(uint256 => Chit) public chits;

    string[] tempParticipantList;

    function createChit(
        string memory _walletId,
        string memory chitName,
        string memory createdAt,
        string memory nextPaymentDate,
        uint256 roomCapacity,
        uint256 timePeriod,
        uint256 poolAmount,
        uint256 chitDuration
    ) public {
        chitLength++;
        tempParticipantList = [_walletId];

        chits[chitLength] = Chit(
            _walletId,
            chitLength,
            chitName,
            createdAt,
            nextPaymentDate,
            roomCapacity,
            timePeriod,
            poolAmount,
            chitDuration,
            false,
            tempParticipantList
        );
    }

 function getAll() public view returns (Chit[] memory){
    Chit[] memory res = new Chit[](chitLength+1);
    for (uint i = 1; i < chitLength+1; i++) {
        res[i] = chits[i];
    }
    return res;
  }
}
