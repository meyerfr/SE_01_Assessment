class Game
  def initialize
    @games_played = 0
    @scores_per_game = {}
    @array = 4.times.map { [nil] * 4 }
    2.times{fill}
  end

  def fill
    i, j = rand(4), rand(4)
    return fill if @array[i][j]
    @array[i][j] = [2, 2, 2, 2, 4].shuffle.first
  end

  def add_nil_entries(direction, row_index, compact_new_array)
    a = compact_new_array
    print(row_index)
    if %w[right down]
      while a.length < @array[row_index].length
        a.unshift(nil)
      end
      @array[row_index] = a
    elsif %w[left up].include?(direction)
      @array[row_index] = a.concat([nil] * 4)[0..3]
    end
  end

  def move(direction)
    @array = @array.transpose if %w[up down].include?(direction)
    @scores_per_game.store(@games_played, 0)
    4.times do |i|
      a = @array[i].compact
      4.times do |idx|
        if a[idx].to_i == a[idx + 1]
          a[idx] *= 2
          a[idx + 1] = nil
          @scores_per_game[@games_played] += a[idx]
        end
      end
      a.compact!
      add_nil_entries(direction, i, a)
    end


    @array = @array.transpose if %w[up down].include?(direction)
  end

  def show_board
    # @array.each_with_index do |field, idx|
    #   field.nil? ? print('0') : print(field)
    #   print('.') unless idx == @array.length-1
    # end
    puts @array.map { |line| "[%5s] " * 4 % line }
  end

  def play
    @games_played += 1
    show_board
    # print("Score: #{@scores_per_game.values.sum}") if @games_played > 0
    # if @games_played <= 3
      move({ a: 'left', s: 'down', d: 'right', w: 'up' }[gets.strip.to_sym])
    # else
    #   print("Your highest score was #{@scores_per_game.values.max}")
    # end
    fill && play if @array.flatten.include?(nil)
  end
end

Game.new.play
