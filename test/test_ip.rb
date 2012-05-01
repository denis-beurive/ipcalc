$:.push("..")
require 'test/unit'
require 'Ip'


class IpTest < Test::Unit::TestCase
  
    def testIpV4
      ip = Ip.new('192.168.12.10')
      
      puts "Testing printing"
      assert_equal('192.168.12.10', ip.to_s)
      assert_equal(4, ip.version)
      assert_equal(3232238602, ip.to_i)
      assert_equal('11000000101010000000110000001010', ip.to_bin)
      assert_equal('c0a80c0a', ip.to_hex)
      assert_equal('11000000.10101000.00001100.00001010', ip.to_bin(true))
      assert_equal('c0.a8.0c.0a', ip.to_hex(true))
      
      puts "Testing subnet manipulation"
      assert(ip.included_in?('192.168.12.8/29'))
      assert_equal('192.168.12.8/29', ip.cidr(29))
      
      puts "Testing + est -"
      assert_equal('192.168.12.11', (ip + 1).to_s)
      assert_equal('192.168.12.9', (ip - 1).to_s)
      ip += 1
      assert_equal('192.168.12.11', ip.to_s)
      ip -= 1
      assert_equal('192.168.12.10', ip.to_s)
      
      puts "Testing comparaison"
      bigger = ip + 1
      assert(bigger > ip)
      assert(ip < bigger)
      assert(bigger >= ip)
      assert(ip <= bigger)
      assert(! (ip == bigger))
      assert(ip == (bigger -1))
      assert_equal(1, bigger <=> ip)
      assert_equal(-1, ip <=> bigger)
      assert_equal(0, ip <=> (bigger - 1))
      
      puts "Testing class methods"
      assert_equal(3232238602, Ip.to_i('192.168.12.10'))
      assert_equal('11000000101010000000110000001010', Ip.to_bin('192.168.12.10'))
      assert_equal('c0a80c0a', Ip.to_hex('192.168.12.10'))
      assert_equal('11000000.10101000.00001100.00001010', Ip.to_bin('192.168.12.10', true))
      assert_equal('c0.a8.0c.0a', Ip.to_hex('192.168.12.10', true))
      
      puts "Testing dots manipulation"
      ip[3] = 5
      ip[0] = 193
      assert_equal('193.168.12.5', ip.to_s)
      assert_equal(168, ip[1])
      
      puts "Testing >> and <<"
      ip = Ip.new('192.168.12.10')
      assert_equal('01100000010101000000011000000101', (ip >> 1).to_bin)
      assert_equal('00110000001010100000001100000010', (ip >> 2).to_bin)
      assert_equal('10000001010100000001100000010100', (ip << 1).to_bin)
      assert_equal('00000010101000000011000000101000', (ip << 2).to_bin)
      
      puts "Testing |, & and ^"
      assert_equal('11000001111110000001110000011110', (ip | (ip << 1)).to_bin)
      assert_equal('10000000000000000000100000000000', (ip & (ip << 1)).to_bin)
      assert_equal('01000001111110000001010000011110', (ip ^ (ip << 1)).to_bin)
      
      puts "Testing constructors"
      assert_equal('5.93.199.128', Ip.new(90032000).to_s)      
      assert_equal('170.187.204.221', Ip.new(0xAABBCCDD).to_s)
      assert_equal('173.85.245.65', Ip.new(0b10101101010101011111010101000001).to_s)
    end
    
    def testIpV6
      ip = Ip.new('192.168.120.100.12.10')
      
      puts "Testing printing"
      assert_equal('192.168.120.100.12.10', ip.to_s)
      assert_equal(6, ip.version)
      assert_equal(211829806861322, ip.to_i)
      assert_equal('110000001010100001111000011001000000110000001010', ip.to_bin)
      assert_equal('c0a878640c0a', ip.to_hex)
      assert_equal('11000000.10101000.01111000.01100100.00001100.00001010', ip.to_bin(true))
      assert_equal('c0.a8.78.64.0c.0a', ip.to_hex(true))
      
      puts "Testing subnet manipulation"
      assert(ip.included_in?('192.168.120.96.0.0/29'))
      assert_equal('192.168.120.96.0.0/29', ip.cidr(29))
      
      puts "Testing + est -"
      assert_equal('192.168.120.100.12.11', (ip + 1).to_s)
      assert_equal('192.168.120.100.12.9', (ip - 1).to_s)
      ip += 1
      assert_equal('192.168.120.100.12.11', ip.to_s)
      ip -= 1
      assert_equal('192.168.120.100.12.10', ip.to_s)
      
      puts "Testing comparaison"
      bigger = ip + 1
      assert(bigger > ip)
      assert(ip < bigger)
      assert(bigger >= ip)
      assert(ip <= bigger)
      assert(! (ip == bigger))
      assert(ip == (bigger -1))
      assert_equal(1, bigger <=> ip)
      assert_equal(-1, ip <=> bigger)
      assert_equal(0, ip <=> (bigger - 1))
      
      puts "Testing class methods"
      assert_equal(211829806861322, Ip.to_i('192.168.120.100.12.10'))
      assert_equal('110000001010100001111000011001000000110000001010', Ip.to_bin('192.168.120.100.12.10'))
      assert_equal('c0a878640c0a', Ip.to_hex('192.168.120.100.12.10'))
      assert_equal('11000000.10101000.01111000.01100100.00001100.00001010', Ip.to_bin('192.168.120.100.12.10', true))
      assert_equal('c0.a8.78.64.0c.0a', Ip.to_hex('192.168.120.100.12.10', true))
      
      puts "Testing dots manipulation"
      ip[3] = 5
      ip[0] = 193
      assert_equal('193.168.120.5.12.10', ip.to_s)
      assert_equal(168, ip[1])
      
      puts "Testing >> and <<"
      ip = Ip.new('192.168.120.100.12.10')
      assert_equal('011000000101010000111100001100100000011000000101', (ip >> 1).to_bin)
      assert_equal('001100000010101000011110000110010000001100000010', (ip >> 2).to_bin)
      assert_equal('100000010101000011110000110010000001100000010100', (ip << 1).to_bin)
      assert_equal('000000101010000111100001100100000011000000101000', (ip << 2).to_bin)
      
      puts "Testing |, & and ^"
      assert_equal('110000011111100011111000111011000001110000011110', (ip | (ip << 1)).to_bin)
      assert_equal('100000000000000001110000010000000000100000000000', (ip & (ip << 1)).to_bin)
      assert_equal('010000011111100010001000101011000001010000011110', (ip ^ (ip << 1)).to_bin)
      
      puts "Testing constructors"
      assert_equal('0.0.170.187.204.221',   Ip.new(2864434397, 6).to_s)      
      assert_equal('0.0.170.187.204.221',   Ip.new(0xAABBCCDD, 6).to_s)
      assert_equal('0.0.173.85.245.65',     Ip.new(0b10101101010101011111010101000001, 6).to_s)
      assert_equal('192.168.120.100.12.10', Ip.new(211829806861322).to_s)
      
      
    end
    

end





