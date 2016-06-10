lamp:
  slave:
    username: 'someslave'
    password: 'password'
    host: "'%'"

interfaces:
  public: eth0
  private: eth2

mine_functions:
  internal_ips:
    mine_function: network.ipaddrs
    interface: eth2
  external_ips:
    mine_function: network.ipaddrs
    interface: eth0

user-ports:
  ssh:
    chain: INPUT
    proto: tcp
    dport: 22
  salt-master:
    chain: INPUT
    proto: tcp
    dport: 4505
  salt-minion:
    chain: INPUT
    proto: tcp
    dport: 4506
  mysql:
    chain: INPUT
    proto: tcp
    dport: 3306
  http:
    chain: INPUT
    proto: tcp
    dport: 80
  https:
    chain: INPUT
    proto: tcp
    dport: 443
