class EncodedPolyline
  def self.encode(number, precision=5)
    number = (number * (10 ** precision)).round
    n = number << 1
    n = ~n if number < 0
    str = ""
    while n >= 0x20 do
        str << ((0x20 | (n & 0x1f)) + 63).chr
        n = n >> 5
    end
    return str << (n + 63).chr
  end

  def self.decode_arr(arr, precision=5)
    num = 0
    arr[0..-2].each_with_index do |elem, i|
      num = (num | (((elem[0] - 63) ^ 0x20) << (i * 5)))
    end
    num = (num | ((arr.last[0] - 63) << ((arr.size-1) * 5)))
    num = ~num if ((num & 0x1) == 1)
    num = num >> 1
    num = num.to_f * (10 ** -precision)
    return num
  end

  def self.decode(str, precision=5)
    self.decode_arr(str.split(//), precision)
  end

  def self.encode_points(coordinates, precision=5)
    output = ""
    output << encode(coordinates.first[0], precision)
    output << encode(coordinates.first[1], precision)

    (1..coordinates.size-1).each do |i|
      previous = coordinates[i-1]
      current = coordinates[i]
      output << encode(current[0] - previous[0], precision)
      output << encode(current[1] - previous[1], precision)
    end
    return output
  end

  def self.decode_points(str, precision=5)
    decoded_points = []
    point_chars = []

    str.each_char do |char|
      point_chars << char
      if ((char[0] - 63) & 0x20).zero?
        decoded_points << decode_arr(point_chars, precision)
        point_chars = []
      end
    end

    coordinates = [[decoded_points.shift, decoded_points.shift]]
     while decoded_points.any?
       coordinates << [
         coordinates.last[0] + decoded_points.shift,
         coordinates.last[1] + decoded_points.shift
       ]
     end
    return coordinates
  end
end
