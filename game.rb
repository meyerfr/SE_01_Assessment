class Game
  def initialize
    @games_played = 0
    @scores_per_game = {}
    @array = [nil, nil, 2, nil]
  end

  def fill
    first_free_field = @array.index{|x| x.nil?}
    @array[first_free_field] = 2
  end

  def move(direction)
    a = @array.compact
    @scores_per_game.store(@games_played, 0)
    4.times do |idx|
      if a[idx].to_i == a[idx + 1]
        a[idx], a[idx + 1] = a[idx] * 2, nil
        @scores_per_game[@games_played] += a[idx]
      end
    end

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

  def show_board
    @array.each_with_index do |field, idx|
      field.nil? ? print('0') : print(field)
      print('.') unless idx == @array.length-1
    end
  end

  def play
    @games_played += 1
    show_board
    print("Score: #{@scores_per_game.values.sum}") if @games_played > 0
    if @games_played <= 3
      move({ a: 'left', d: 'right' }[gets.strip.to_sym])
    else
      print("Your highest score was #{@scores_per_game.values.max}")
    end
    fill && play if @games_played <= 3
  end
end

Game.new.play
