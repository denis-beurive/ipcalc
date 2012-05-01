# This file implements the module Iptools.
# Author::    Denis BEURIVE  (mailto:denis.beurive@gmail.com)
# Copyright:: Copyright (c) 2012 Denis BEURIVE
# License::   Distributes under the same terms as Ruby


# This module contains various utilities that are used by all classes that manipulate IP addresses.

module Iptools

  # Convert an array that represents an IP address into an integer.
  # Example: [173, 85, 245, 65] => 2908091713.
  #
  # [in_dots] the array that will be converted into an integer (ex: [192, 168, 0, 10]).
  #
  # The method returns an integer.

  def self.dots_to_i(in_dots)
    bint = 0;
    rdx  = 1; 
    in_dots.reverse.each do |dot|
      bint += dot * rdx
      rdx *= 256
    end
    bint    
  end

  # Convert an integer that represents an IP address into an array.
  # Example: 2908091713 => [173, 85, 245, 65]
  #
  # [in_int] Integer to convert.
  # [in_v] IP version (should be 4 or 6).
  #
  # The method returns an array (with 4 or 6 elements).
  
  def self.i_to_dots(in_int, in_v=4)
    res = [];
    raise RuntimeError, "Invalid IP version #{in_v} (should be 4 or 6)" if (in_v != 4 && in_v != 6) 
    in_v.times do
      r      = in_int % 256;
      in_int = (in_int - r) / 256;
      res.unshift(r.to_s);
    end
    res.join('.');
  end
  
end