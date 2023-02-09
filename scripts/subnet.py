import ipaddress

def get_subnet_info(ip, mask):
    ip_binary = '.'.join([bin(int(x)+256)[3:] for x in ip.split('.')])
    net_len = 0
    if ip_binary.startswith('0'):
        print("ip is in class A")
        net_len = 8

    if ip_binary.startswith('10'):
        print("ip is in class B")
        net_len = 16
        
    if ip_binary.startswith('110'):
        print("ip is in class C")
        net_len = 24    
        
    network = ipaddress.IPv4Network(ip + '/' + mask, strict=False)
    
    net_host_ips = list(network.hosts())

    print("network: %s" % (network.with_prefixlen))
    print("broadcast address: %s" % (network.broadcast_address))
    print("host ip count: %s" % (network.num_addresses - 2))
    print("subnet count: %s" % (pow(2, network.prefixlen - net_len)))
    print("first host ip: %s" % (net_host_ips[0]))
    print("final host ip: %s" % (net_host_ips[-1]))

def get_ip_info(ip):
    ip_binary = '.'.join([bin(int(x)+256)[3:] for x in ip.split('.')])
    if ip_binary.startswith('0'):
        print("ip is in class A")

    if ip_binary.startswith('10'):
        print("ip is in class B")
        
    if ip_binary.startswith('110'):
        print("ip is in class C")
    
def judge_ip_in_subnet(ip, cidr):
    print(ipaddress.IPv4Address(ip) in ipaddress.IPv4Network(cidr))    

def judge_ips_in_same_subnet(ip1, ip2, mask):
    network1 = ipaddress.IPv4Network(ip1 + '/' + mask, strict=False)
    network2 = ipaddress.IPv4Network(ip2 + '/' + mask, strict=False)

    net1_host_ips = list(network1.hosts())
    net2_host_ips = list(network2.hosts())

    ip1_flag = False
    for ip in net1_host_ips:
        if  str(ip) == ip1:
            ip1_flag = True
            
    ip2_flag = False
    for ip in net2_host_ips:
        if str(ip) == ip2:
            ip2_flag = True

    if ip1_flag == False:
        print(ip1 + " is not a host IP")
    
    if ip2_flag == False:
        print(ip2 + " is not a host IP")

    if network1.network_address == network2.network_address:
        print(True)
    else:
        print(False)

if __name__ == '__main__':
    # if you wanna get information related to ip, call get_ip_info(ip)
    # it will tell you the class it reside in
    ip = "173.63.255.252 "
    mask ="255.240.0.0"
    ip2 = "141.4.112.0"
    
    print("------------------------get ip info------------------------")
    get_ip_info(ip)
    
    # if you wanna get information related to a subnet, call get_subnet_info(ip, mask)
    # it will print subnet's broadcast ip, how many subnets it canbe divided and how many host ips it has
    print("------------------------get subnet info------------------------")
    get_subnet_info(ip, mask)
    
    # if you wanna judge if two ips in the same subnet, call judge_ips_in_same_subnet(ip1, ip2, mask)
    print("------------------------judge two ips in same subnet------------------------")
    judge_ips_in_same_subnet(ip, ip2, mask)
    
    # if you wanna make sure a ip is reside in a subnet, judge_ip_in_subnet(ip, cidr)
    print("------------------------judge ip in a subnet------------------------")
    cidr = "192.168.0.0/16"
    judge_ip_in_subnet(ip, cidr)