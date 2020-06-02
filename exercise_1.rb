class Exercise1
  def initialize
    @array = [nil, nil, 2, nil]
  end

  def fill
    first_free_field = @array.index{|x| x.nil?}
    @array[first_free_field] = 2
  end

  def move(direction)
    a = @array.compact
    4.times { |idx| a[idx], a[idx + 1] = a[idx] * 2, nil if a[idx].to_i == a[idx + 1] }
    a.compact!
    case direction
    when 'right'
      while a.length < @array.length
        a.unshift(nil)
      end
      @array = a
    when 'left'
      @array = a.compact.concat([nil] * 4)[0..3]
    end
  end

  def play
    @array.each_with_index do |field, idx|
      field.nil? ? print('0') : print(field)
      print('.') unless idx == @array.length-1
    end
    move({ a: 'left', d: 'right' }[gets.strip.to_sym])
    fill && play if @array.flatten.include?(nil)
  end
end

Exercise1.new.play
