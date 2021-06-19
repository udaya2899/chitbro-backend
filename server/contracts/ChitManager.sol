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
    string[] usersList;

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
        chitLength++;
    }

    function getAll() public view returns (Chit[] memory) {
        Chit[] memory res = new Chit[](chitLength);
        for (uint256 i = 0; i < chitLength; i++) {
            res[i] = chits[i];
        }
        return res;
    }

    function joinChit(string memory _walletId, uint256 chitId) public {
        if (chits[chitId].roomFilled == true) return;
        uint256 participantListSize = chits[chitId].participants.length;
        string[] memory newParticipantArray =
            new string[](participantListSize + 1);
        for (uint256 i = 0; i < participantListSize; i++) {
            newParticipantArray[i] = chits[chitId].participants[i];
        }
        newParticipantArray[participantListSize] = _walletId;
        if (newParticipantArray.length >= chits[chitId].roomCapacity) {
            chits[chitId].roomFilled = true;
            chits[chitId].participants = newParticipantArray;
        }
      
    }
}

