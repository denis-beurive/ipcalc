# This file illustrates the use of class Ip.
# Author::    Denis BEURIVE  (mailto:denis.beurive@gmail.com)
# Copyright:: Copyright (c) 2012 Denis BEURIVE
# License::   Distributes under the same terms as Ruby

# ruby -I../lib
require "ipcalc"



  
myip = "192.168.12.10";  
ip = Ip.new(myip)

myipv6 = "192.168.120.100.12.10";  
ipv6 = Ip.new(myipv6)

# Testing basic conversion.

puts "Testing object's methods..."
puts
puts "Ip(\"#{myip}\").version         = #{ip.version}"
puts "Ip(\"#{myip}\").to_i            = #{ip.to_i}"
puts "Ip(\"#{myip}\").to_bin          = #{ip.to_bin}"   
puts "Ip(\"#{myip}\").to_hex          = #{ip.to_hex}"
puts "Ip(\"#{myip}\").to_bin (pretty) = #{ip.to_bin(true)}"
puts "Ip(\"#{myip}\").to_hex (pretty) = #{ip.to_hex(true)}"  
puts
puts "Ip(\"#{myipv6}\").version         = #{ipv6.version}"
puts "Ip(\"#{myipv6}\").to_i            = #{ipv6.to_i}"
puts "Ip(\"#{myipv6}\").to_bin          = #{ipv6.to_bin}"   
puts "Ip(\"#{myipv6}\").to_hex          = #{ipv6.to_hex}"
puts "Ip(\"#{myipv6}\").to_bin (pretty) = #{ipv6.to_bin(true)}"
puts "Ip(\"#{myipv6}\").to_hex (pretty) = #{ipv6.to_hex(true)}"  
puts

# Testing subnet calculation

puts "List of subnets that contain the IP #{ip}:"
32.downto(1) do |i|
  puts "   " + ip.cidr(i)  
end
puts
puts "Is #{ip} included in \"1.2.3.128/25\" ? #{ip.included_in?("1.2.3.128/25")}"
puts

puts "List of subnets that contain the IP #{ipv6}:"
48.downto(1) do |i|
  puts "   " + ipv6.cidr(i)  
end
puts
puts
puts "Is #{ipv6} included in \"1.2.3.128.0.1/25\" ? #{ipv6.included_in?("1.2.3.128.0.1/25")}"
puts

# Testing + and -

puts "#{ip.to_s.ljust(16)} +1    => #{ip+1}"
puts "#{ip.to_s.ljust(16)} +2    => #{ip+2}"
puts "#{ip.to_s.ljust(16)} -10   => #{ip-10}"
puts "#{ip.to_s.ljust(16)} += 1  => #{ip += 1}"
puts "#{ip.to_s.ljust(16)} -= 1  => #{ip -= 1}"
puts

puts "#{ipv6.to_s.ljust(22)} +1    => #{ipv6+1}"
puts "#{ipv6.to_s.ljust(22)} +2    => #{ipv6+2}"
puts "#{ipv6.to_s.ljust(22)} -10   => #{ipv6-10}"
puts "#{ipv6.to_s.ljust(22)} += 1  => #{ipv6 += 1}"
puts "#{ipv6.to_s.ljust(22)} -= 1  => #{ipv6 -= 1}"
puts

# Testing comparaisons

ip1 = ip+1
ip2 = ip-5

puts "#{ip1.to_s.ljust(16)} ==  #{ip2.to_s.ljust(16)} => #{ip1 ==  ip2}"
puts "#{ip1.to_s.ljust(16)} !=  #{ip2.to_s.ljust(16)} => #{ip1 !=  ip2}"
puts "#{ip1.to_s.ljust(16)} >   #{ip2.to_s.ljust(16)} => #{ip1 >   ip2}"
puts "#{ip1.to_s.ljust(16)} <   #{ip2.to_s.ljust(16)} => #{ip1 <   ip2}"
puts "#{ip1.to_s.ljust(16)} >=  #{ip2.to_s.ljust(16)} => #{ip1 >=  ip2}"
puts "#{ip1.to_s.ljust(16)} <=  #{ip2.to_s.ljust(16)} => #{ip1 <=  ip2}"
puts "#{ip1.to_s.ljust(16)} <=> #{ip2.to_s.ljust(16)} => #{ip1 <=> ip2}"      
puts

ip1 = ipv6+1
ip2 = ipv6-5

puts "#{ip1.to_s.ljust(16)} ==  #{ip2.to_s.ljust(16)} => #{ip1 ==  ip2}"
puts "#{ip1.to_s.ljust(16)} !=  #{ip2.to_s.ljust(16)} => #{ip1 !=  ip2}"
puts "#{ip1.to_s.ljust(16)} >   #{ip2.to_s.ljust(16)} => #{ip1 >   ip2}"
puts "#{ip1.to_s.ljust(16)} <   #{ip2.to_s.ljust(16)} => #{ip1 <   ip2}"
puts "#{ip1.to_s.ljust(16)} >=  #{ip2.to_s.ljust(16)} => #{ip1 >=  ip2}"
puts "#{ip1.to_s.ljust(16)} <=  #{ip2.to_s.ljust(16)} => #{ip1 <=  ip2}"
puts "#{ip1.to_s.ljust(16)} <=> #{ip2.to_s.ljust(16)} => #{ip1 <=> ip2}"      
puts

# Testing class methodes

puts "Testing class' methods..."
puts "Ip.to_i(\"1.2.3.4\")            = #{Ip.to_i("1.2.3.4")}"
puts "Ip.to_bin(\"1.2.3.4\")          = #{Ip.to_bin("1.2.3.4")}"
puts "Ip.to_hex(\"1.2.3.4\")          = #{Ip.to_hex("1.2.3.4")}"
puts "Ip.to_bin(\"1.2.3.4\") (pretty) = #{Ip.to_bin("1.2.3.4", true)}"
puts "Ip.to_hex(\"1.2.3.4\") (pretty) = #{Ip.to_hex("1.2.3.4", true)}"  
puts

puts "Ip.to_i(\"1.2.3.4.5.6\")            = #{Ip.to_i("1.2.3.4.5.6")}"
puts "Ip.to_bin(\"1.2.3.4.5.6\")          = #{Ip.to_bin("1.2.3.4.5.6")}"
puts "Ip.to_hex(\"1.2.3.4.5.6\")          = #{Ip.to_hex("1.2.3.4.5.6")}"
puts "Ip.to_bin(\"1.2.3.4.5.6\") (pretty) = #{Ip.to_bin("1.2.3.4.5.6", true)}"
puts "Ip.to_hex(\"1.2.3.4.5.6\") (pretty) = #{Ip.to_hex("1.2.3.4.5.6", true)}"  
puts

# Testing dots' manipulation.

puts "ip = #{ip}"
puts "  0: #{ip[0]}"
puts "  1: #{ip[1]}"
puts "  2: #{ip[2]}"
puts "  3: #{ip[3]}"
puts

ip[2] = 10
puts "Changed the third dot into 10"
puts "Now ip = #{ip}"
puts

puts "ip = #{ipv6}"
puts "  0: #{ipv6[0]}"
puts "  1: #{ipv6[1]}"
puts "  2: #{ipv6[2]}"
puts "  3: #{ipv6[3]}"
puts "  2: #{ipv6[4]}"
puts "  3: #{ipv6[5]}"
puts

ipv6[2] = 10
puts "Changed the third dot into 10"
puts "Now ip = #{ipv6}"
puts

# Testing bitwise operators

ip   = Ip.new('192.168.12.10') 
ipv6 = Ip.new('192.168.120.100.12.10')

puts "Testing >> on IPV#{ip.version} on #{ip}"
puts "#{ip.to_bin}"
puts "#{(ip >> 1).to_bin}"
puts "#{(ip >> 2).to_bin}"
puts

puts "Testing >> on IPV#{ipv6.version}"
puts "#{ipv6.to_bin}"
puts "#{(ipv6 >> 1).to_bin}"
puts "#{(ipv6 >> 2).to_bin}"
puts

puts "Testing <<"
puts "#{ip.to_bin} on IPV#{ip.version} in #{ip}"
puts "#{(ip << 1).to_bin}"
puts "#{(ip << 2).to_bin}"
puts

puts "Testing << on IPV#{ipv6.version}"
puts "#{ipv6.to_bin}"
puts "#{(ipv6 << 1).to_bin}"
puts "#{(ipv6 << 2).to_bin}"
puts  

puts "Testing | on IPV#{ip.version}"
ip1 = ip << 1
puts "#{ip.to_bin} #{ip}"
puts "#{ip1.to_bin} #{ip1}"
puts "#{(ip | ip1).to_bin} #{ip | ip1}"
puts

puts "Testing | on IPV#{ipv6.version}"
ip1v6 = ipv6 << 1
puts "#{ipv6.to_bin} #{ipv6}"
puts "#{ip1v6.to_bin} #{ip1v6}"
puts "#{(ipv6 | ip1v6).to_bin} #{ipv6 | ip1v6}"
puts

puts "Testing & on IPV#{ip.version}"
ip1 = ip << 1
puts "#{ip.to_bin}"
puts "#{ip1.to_bin}"
puts "#{(ip & ip1).to_bin}"
puts

puts "Testing & on IPV#{ipv6.version}"
ip1v6 = ipv6 << 1
puts "#{ipv6.to_bin}"
puts "#{ip1v6.to_bin}"
puts "#{(ipv6 & ip1v6).to_bin}"
puts

puts "Testing ^ on IPV#{ip.version}"
ip1 = ip << 1
puts "#{ip.to_bin}"
puts "#{ip1.to_bin}"
puts "#{(ip ^ ip1).to_bin}"
puts

puts "Testing ^ on IPV#{ipv6.version}"
ip1v6 = ipv6 << 1
puts "#{ipv6.to_bin}"
puts "#{ip1v6.to_bin}"
puts "#{(ipv6 ^ ip1v6).to_bin}"
puts 

# Testing the constructor

dec = 90032000
puts "#{dec}:"
ip = Ip.new(dec)
puts "\t" + ip.to_s.ljust(21) + " -> " + ip.to_i.to_s.ljust(16) + " -> " + ip.to_i.to_s
puts

dec = 90032000
puts "#{dec}:"
ip = Ip.new(dec, 6)
puts "\t" + ip.to_s.ljust(21) + " -> " + ip.to_i.to_s.ljust(16) + " -> " + ip.to_i.to_s
puts

hex = 0xAABBCCDD
puts "#{hex.to_s(16)}:"
ip = Ip.new(hex)
puts "\t" + ip.to_s.ljust(21) + " -> " + ip.to_i.to_s.ljust(16) + " -> " + ip.to_hex.to_s
puts

hex = 0xAABBCCDD
puts "#{hex.to_s(16)}:"
ip = Ip.new(hex, 6)
puts "\t" + ip.to_s.ljust(21) + " -> " + ip.to_i.to_s.ljust(16) + " -> " + ip.to_hex.to_s
puts  

bin = 0b10101101010101011111010101000001
puts "#{bin.to_s(2)}:"
ip = Ip.new(bin)
puts "\t" + ip.to_s.ljust(21) + " -> " + ip.to_i.to_s.ljust(16) + " -> " + ip.to_bin.to_s
puts

bin = 0b10101101010101011111010101000001
puts "#{bin.to_s(2)}:"
ip = Ip.new(bin, 6)
puts "\t" + ip.to_s.ljust(21) + " -> " + ip.to_i.to_s.ljust(16) + " -> " + ip.to_bin.to_s
puts


