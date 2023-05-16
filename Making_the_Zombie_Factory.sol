pragma solidity >=0.5.0 <0.6.0;

contract ZombieFactory {

    event NewZombie(uint zombieId, string name, uint dna);

    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;

    struct Zombie { //Zombie라는 구조체 형성, 이름과 나이 등 설정 가능, 선언만 해주는 것이기 때문에 =은 작성하지 않는다.
        string name;
        uint dna;
    }

    Zombie[] public zombies;
    //public으로 선언하면 외부에서 가져올 수 있음
    //[] 안에 아무것도 안 적으면 동적배열
    //웬만하면 작성하는 것이 좋음
    //위에서 구조체 선언 후 작성해야 에러 안 남

    function _createZombie(string memory _name, uint _dna) private { //name에서 _를 사용하여 이 함수 안에서만 사용하는 함수임을 나타낸다.
        uint id = zombies.push(Zombie(_name, _dna)) - 1;
        emit NewZombie(id, _name, _dna);
    }

    function _generateRandomDna(string memory _str) private view returns (uint) { 
    //returns 뒤에 어떤 형태의 것이 반환되는지 알려줌
    //공개범위 뒤에 view 적음
    //공개범위 제어자 returns(반환값)
    //외부 변화를 참조하지 않는 경우에는 pure를 작성함 - 이건 컴파일러에서 알려줌
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        //keccak함수는 일방향 함수여서 역산 불가능, 보안강화에 사용
        //같은 값을 넣어주면 길고 복잡한 해시값이 나옴
        return rand % dnaModulus;
    }

    function createRandomZombie(string memory _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name, randDna);
    }

}
