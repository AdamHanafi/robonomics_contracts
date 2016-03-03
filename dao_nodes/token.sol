contract token {
    address public creator;
    address public em;
    string public symbol;
    string public name;
    uint public baseUnit;
    uint totalSupply;
    mapping (address => uint) public balanceOf;
    mapping (address => mapping(address => bool)) approveOf;
    mapping (address => mapping(address => bool)) approveOnceOf;
    mapping (address => mapping(address => uint)) approveOnceValueOf;

    modifier creatorCheck { if (msg.sender == em) _ }

    /* Events */
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event AddressApproval(address indexed _address, address indexed _proxy, bool _result);
    event AddressApprovalOnce(address indexed _address, address indexed _proxy, uint256 _value);

    /*Initial */
    function token(string _symbol, string _name, uint _unit, address _em) {
        creator = msg.sender;
        em = _em;
        symbol = _symbol;
        name = _name;
        baseUnit = _unit;
    }  

    /* Creator functions */
    function getTotalSupply() creatorCheck returns (uint supply) {
        return totalSupply;
    }

    function emission(uint _amount) creatorCheck returns(bool result) {
        balanceOf[creator] += _amount;
        totalSupply += _amount;
        return true;
    }

    function burn(uint _amount) creatorCheck returns(bool result) {
        if (balanceOf[creator] < _amount) {return false;}
        balanceOf[creator] -= _amount;
        totalSupply -= _amount;
        return true;
    }

    /* Agent function */

    function getBalance(address _account) returns (uint256 balance) {
		balance = 0;
        if (approveOf[_account][msg.sender]) {
			balance = balanceOf[_account];
		}
        return balance;
    }

    function myBalance() returns (uint256 balance) {
		balance = balanceOf[msg.sender];
        return balance;
    }

    function transfer(address _to, uint256 _value) returns (bool result) {
        if (balanceOf[msg.sender] < _value) {return false;}
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        Transfer(msg.sender, _to, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if(approveOf[_from][msg.sender])
        {
            if (balanceOf[_from] < _value) {return false;}
            balanceOf[_from] -= _value;
            balanceOf[_to] += _value;  
            Transfer(_from, _to, _value);          
            return true;
        } else if(approveOnceOf[_from][msg.sender] && approveOnceValueOf[_from][msg.sender]<=_value) {
            if (balanceOf[_from] < _value) {return false;}
            balanceOf[_from] -= _value;
            balanceOf[_to] += _value;  
            Transfer(_from, _to, _value);          
            return true;  
        }
    }

    function approve(address _address) returns (bool result) {
        approveOf[msg.sender][_address] = true;
        AddressApproval(_address, msg.sender, true);
        return true;
    }

    function unapprove(address _address) returns (bool result) {
        approveOf[msg.sender][_address] = false;
        return true;        
    }

    function approveOnce(address _address, uint _maxValue) returns (bool result) {
        approveOnceOf[msg.sender][_address] = true;
        approveOnceValueOf[msg.sender][_address] = _maxValue;
        AddressApprovalOnce(_address, msg.sender, _maxValue);
        return true;       
    }

    function unapproveOnce(address _address) returns (bool result) {
        approveOnceOf[msg.sender][_address] = false;
        approveOnceValueOf[msg.sender][_address] = 0;
        return true;       
    }

    function isApprovedOnceFor(address _target, address _proxy) returns (uint maxValue) {
        maxValue = approveOnceValueOf[_target][_proxy];
        return maxValue;
    }

    function isApprovedFor(address _target, address _proxy) returns (bool result) {
        result = approveOnceOf[_target][_proxy];
        return result;
    }
}