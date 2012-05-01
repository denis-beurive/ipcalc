# This file implements the class Ip.
# Author::    Denis BEURIVE  (mailto:denis.beurive@gmail.com)
# Copyright:: Copyright (c) 2012 Denis BEURIVE
# License::   Distributes under the same terms as Ruby


require_relative "Iptools"

# This class handles common operations on IP addresses.
#   o Create an IP address from a given string (ex: "192.168.0.12").
#   o Create an IP address from a given integer value (ex: 16909060 or 0b00000001000000100000001100000100 or 0xaabbccdd)
#   o Get the string representation of the IP address.
#   o Get the decimal representation of the IP address.
#   o Get the binary representation of the IP address.
#   o Get the hexa representation of the IP address.
#   o Increment an IP address (ex: 198.168.0.12 + 3).
#   o Decrement an IP address (ex: 198.168.0.12 - 5).
#   o Compare 2 IP addresses (ex: 198.168.0.12 > 198.168.0.13).
#   o Manipulate an IP address by "dots" (ex: if ip="198.168.0.12", then ip[0]=192 produces ip="192.168.0.12" of ip[3] returns 12).
#   o Operate binary operations <<, >>, |, &, ^ (ex: "198.168.0.12" & "200.168.0.15").
#   o Calculate the subnet of a given class that contains the IP address (ex: What is the subnet of class 24 that includes this IP address?).
#   o Test if the IP address is included in a given subnet (ex: is "192.168.10.12" included into "123.154.12.13/24"?).

class Ip
  attr_reader :dots, :version
  
  # Maximum value for an IP V4 address.
  IPMAX_V4 = (2**32) - 1
  
  # Maximum value for an IP V6 address.
  IPMAX_V6 = (2**48) - 1
  
  # Create an IP address V4 or V6.
  #
  # [in_ip] String, or integer, that represents the IP address.
  #         Example: 0b10101101010101011111010101000001 or 2908091713 or "173.85.245.65"
  # [in_v] IP version (4 or 6).
  
  def initialize(in_ip, in_v=4)
    
    if in_ip.is_a?(String)
      @version = Ip.version(in_ip)
      @ip_string = in_ip
    elsif in_ip.is_a?(Integer)
      if in_ip > Ip::IPMAX_V4
        @version = 6
      else
        @version = in_v
      end
      @ip_string = Iptools.i_to_dots(in_ip, @version)
    else
      raise RuntimeError, "Invalid IP addresse #{in_ip} (should be a string or an interger)"
    end
    
    @dots = Ip.valid?(@ip_string, @version)
       
    raise RuntimeError, "Invalid IP addresse #{in_ip}" if (@dots.nil?)
    @ip_int = to_i
  end

  # Return the textual representation of the IP address.
  
  def to_s
    @ip_string
  end

  # Return the integer representation of the IP address.
  
  def to_i
    return @ip_int unless (@ip_int.nil?);
    Iptools.dots_to_i(@dots)
  end
  
  # Return a string that represents the IP address' binary value.
  # The returned string may contain bytes' separators (dots).
  # Example: "1.2.3.4" => "00000001000000100000001100000100" or "00000001.00000010.00000011.00000100"
  #
  # [in_pretty] If TRUE, then the returned string will contain dots to separated bytes.
  #
  # The method returns a string that represents a binary value.  
  
  def to_bin(in_pretty=false)
    s = @ip_int.to_s(2).rjust(@version*8, '0')
    return s unless in_pretty
    
    if (@version == 4)
      /^((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})$/.match(s)[1,4].join('.')
    else
      /^((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})$/.match(s)[1,6].join('.')
    end
  end
  
  # Return a string that represents the IP address' hexa value.
  # The returned string may contain bytes' separators (dots).
  # Example: "1.2.3.4" => "01020304" or "01.02.03.04"
  # 
  # [in_pretty] If TRUE, then the returned string will contain dots to separate bytes.
  #
  # The method returns a string that represents a hexa value. 
  
  def to_hex(in_pretty=false)
    s = @ip_int.to_s(16).rjust(@version*2, '0')
    return s unless in_pretty
    
    if (@version == 4)
      /^([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})$/.match(s)[1,4].join('.')
    else
      /^([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})$/.match(s)[1,6].join('.')
    end
  end
  
  # Operator "+" (and +=)
  
  def +(in_delta)
    v = @ip_int + in_delta
    raise RuntimeError, "+: Invalid operand #{in_delta}" if (v > MAX())
    Ip.new(v, @version)
  end

  # Operator "-" (and -=)
  
  def -(in_delta)
    v = @ip_int - in_delta
    raise RuntimeError, "-: Invalid operand #{in_delta}" if v < 0
    Ip.new(v, @version)
  end
  
  # Operators <=>
  
  def <=>(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int <=> in_ip.to_i
  end
  
  # Operators >
  
  def >(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int > in_ip.to_i
  end

  # Operators <
  
  def <(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int < in_ip.to_i
  end
  
  # Operators >=
  
  def >=(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int >= in_ip.to_i
  end

  # Operators <=
  
  def <=(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int <= in_ip.to_i
  end

  # Operators ==
  
  def ==(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int == in_ip.to_i
  end
  
  # Operators !=
  
  def !=(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    @ip_int != in_ip.to_i
  end
  
  # Return a given dot value extracted from an IP address.
  # Example: If ip is "192.168.0.15", ip[0] is 192, ip[1] is 168...
  
  def [](in_index)
    raise RuntimeError, "[]: Invalid index #{in_index}" if ((in_index < 0) || (in_index > MAX_DOTS_INDEX()))
    @dots[in_index]
  end

  # Assign a value to a given IP's dot.
  # Example: Ip ip is "192.168.0.15", ip[0]=193 then ip="193.168.0.15"
  
  def []=(in_index, in_value)
    raise RuntimeError, "[]: Invalid index #{in_index}" if ((in_index < 0) || (in_index > MAX_DOTS_INDEX()))
    raise RuntimeError, "[]: Invalid value #{in_value}" if ((in_value < 0) || (in_value > 255))
    @dots[in_index] = in_value
    
    # Updtate values.
    @ip_int    = Iptools.dots_to_i(@dots)
    @ip_string = Iptools.i_to_dots(@ip_int, @version)
  end
  
  # Operator >>
  
  def >>(in_decal)
    Ip.new(@ip_int >> in_decal, @version)
  end
  
  # Operator <<
  
  def <<(in_decal)
    Ip.new((@ip_int << in_decal) & MAX(), @version)
  end
  
  # Operator | (binary OR)
  
  def |(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    Ip.new(@ip_int | in_ip.to_i, @version)
  end
  
  # Operator & (binary AND)
  
  def &(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    Ip.new(@ip_int & in_ip.to_i, @version)
  end
  
  # Operator ^ (binary XOR)
  
  def ^(in_ip)
    raise RuntimeError, "Can not compare IPV4 with IPV6!" if @version != in_ip.version
    Ip.new(@ip_int ^ in_ip.to_i, @version)
  end
  
  # Return the CIDR of a given subnet's class that contains this IP address.
  #
  # [in_class] Class of the subnet (example: 26).
  #
  # The method returns the CIDR of the given class that contains this IP address.
  
  def cidr(in_class)
    max_class = MAX_CLASS()
    raise RuntimeError, "Invalid subnet class /#{in_class}" if (in_class > max_class || in_class < 1)
    mask = (2**in_class - 1) << (max_class - in_class)
    Iptools.i_to_dots(@ip_int & mask, @version) + "/#{in_class}" 
  end

  # Test if the IP address is part of a given subnet.
  #
  # [in_subnet] The subnet (example: "173.85.245.32/27").
  #
  # The method returns TRUE or FALSE, whether the given IP address is included into the given subnet or not.
  
  def included_in?(in_subnet)
    m = /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}(\.\d{1,3}\.\d{1,3})?)\s*\/\s*(\d{1,2})$/.match(in_subnet)
    raise RuntimeError, "Invalid subnet #{in_subnet}" if m.nil?
    
    ipv6tag = m[2]
    
    cidrv = 6
    if (ipv6tag.nil?)
      cidrv = 4
    end
    
    raise RuntimeError, "Subnet #{in_subnet} is IP version #{cidrv} and current IP is IP version #{@version}" if @version != cidrv
    
    snet   = m[1]
    classe = m[3]
    s      = cidr(classe.to_i)
    # puts s + "  ---  " + snet + "/" + classe
    s == snet + "/" + classe
  end

  # -------------------------------------------------------------
  # Statics
  # -------------------------------------------------------------

  # Test if a given string represents an IP address.
  #
  # [in_ip] String to test.
  # [in_version] IP version (should be 4 or 6)
  #
  # If the given string represents an IP address, that the method returns an array that represents the IP address.
  # Otherwise, the method returns the value nil.

  def self.valid?(in_ip, in_version=4)
    if (in_version == 4)
      return Ip.validV4?(in_ip)
    end
    if (in_version == 6)
      return Ip.validV6?(in_ip)
    end
    raise RuntimeError, "Invalid IP addresse version #{in_version}"
  end

  # Test if a given string represents an IP V4 address.
  #
  # [in_ip] String to test.
  #
  # If the given string represents an IP V4 address, that the method returns an array that represents the IP address.
  # Otherwise, the method returns the value nil.
  
  def self.validV4?(in_ip)
    dots = [];
    m = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/.match(in_ip)
    return nil if m.nil?
    
    for i in 1..4
      dot = m[i].to_i;
      return nil if dot > 255
      dots.push(dot)
    end
    dots
  end
  
  # Test if a given string represents an IP V6 address.
  #
  # [in_ip] String to test.
  #
  # If the given string represents an IP V6 address, that the method returns an array that represents the IP address.
  # Otherwise, the method returns the value nil.
  
  def self.validV6?(in_ip)
    dots = [];
    m = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/.match(in_ip)
    return nil if m.nil?
    
    for i in 1..6
      dot = m[i].to_i;
      return nil if dot > 255
      dots.push(dot)
    end
    dots
  end 
  
  # Convert a string that represents an IP address into an integer.
  # Example: "1.2.3.4" => 16909060
  #
  # [in_ip] String to convert.
  #
  # The method returns an integer that represents the given IP address.
  
  def self.to_i(in_ip)
    dots = Ip.valid?(in_ip, Ip.version(in_ip));
    raise RuntimeError, "Invalid IP addresse #{in_ip}" if (dots.nil?)
    Iptools.dots_to_i(dots)
  end
  
  # Convert a string that represents an IP address into a string that represents a binary value.
  # The returned string may contain bytes' separators (dots).
  # Example: "1.2.3.4" => "00000001000000100000001100000100" or "00000001.00000010.00000011.00000100"
  #
  # [in_ip] String to convert.
  # [in_pretty] If TRUE, then the returned string will contain dots to separated bytes.
  #
  # The method returns a string that represents a binary value.
  
  def self.to_bin(in_ip, in_pretty=false)
    version = Ip.version(in_ip)
    s = Ip.to_i(in_ip).to_s(2).rjust(Ip.MAX_CLASS(version), '0')
    return s unless in_pretty
    
    if (4 == version)
      return /^((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})$/.match(s)[1,4].join('.')
    end
    /^((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})((?:0|1){8})$/.match(s)[1,6].join('.')
  end
  
  # Convert a string that represents an IP address into a string that represents a hexa value.
  # The returned string may contain bytes' separators (dots).
  # Example: "1.2.3.4" => "01020304" or "01.02.03.04"
  # 
  # [in_ip] String to convert.
  # [in_pretty] If TRUE, then the returned string will contain dots to separate bytes.
  #
  # The method returns a string that represents a hexa value.  
  
  def self.to_hex(in_ip, in_pretty=false)
    version = Ip.version(in_ip)
    s = Ip.to_i(in_ip).to_s(16).rjust(version == 4 ? 8 : 12, '0')
    return s unless in_pretty
    if (4 == version)
      return /^([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})$/.match(s)[1,4].join('.')
    end
    /^([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})([[:xdigit:]]{2})$/.match(s)[1,6].join('.')
  end
  
  # Given a string that represents an IP address, return the IP version (4 or 6).
  #
  # [in_ip] String that represents an IP address.
  #
  # The method returns the IP version of the IP address. The returned value is 4 or 6.
  
  def self.version(in_ip)
    m = /^(\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})(\.\d{1,3}\.\d{1,3})?$/.match(in_ip)
    raise RuntimeError, "Invalid IP address #{in_ip}" if m[1].nil?
    return 4 if m[2].nil?
    return 6
  end
  
  # -------------------------------------------------------------
  # Make private operators that have no sense for an IP address
  # -------------------------------------------------------------

  private
  
  def self.MAX_CLASS(in_version)
    return in_version == 4 ? 32 : 48
  end
  
  def MAX
   return @version == 4 ? Ip::IPMAX_V4 : Ip::IPMAX_V6
  end
  
  def MAX_DOTS_INDEX
    return @version == 4 ? 3 : 5
  end
  
  def MAX_CLASS
    Ip.MAX_CLASS(@version)
  end
  
  def /(other)
  end
  def *(other)
  end
  def %(other)
  end
  def and(other)
  end
  def **(other)
  end 
  def =~(other)
  end 
  def -@
  end
  def +@
  end  
    
end


