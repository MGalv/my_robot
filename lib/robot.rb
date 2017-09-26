class Robot
  attr_reader :x, :y, :dial, :limit, :placed

  CARDINALS = {
    'NORTH' => { position: 0, x: 0, y: 1 },
    'EAST' => { position: 1, x: 1, y: 0 },
    'SOUTH' => { position: 2, x: 0, y: -1 },
    'WEST' => { position: 3, x: -1, y: 0 }
  }

  ##
  # Places the robot on the table in position X,Y and facing NORTH, SOUTH, EAST or WEST.
  # Params:
  #   x      - [Required, Integer]. X axis value.
  #   y      - [Required, Integer]. Y axis value.
  #   facing - [Required, String]. Facing cardinal. Valid attributes: NORTH, SOUTH, EAST, WEST.
  ##
  def place(x, y, facing, limit = 5)
    cardinals = CARDINALS.keys
    cardinal = CARDINALS[facing.upcase]
    @limit = limit
    @placed = !!cardinal && valid?(x) && valid?(y)
    return unless placed
    @x = x
    @y = y
    @dial = cardinals.rotate(cardinal[:position])
    self
  end

  ##
  # Rotates the dial(cardinals array) to the left. Returns nil when robot is not placed.
  # Example:
  #   robot = Robot.new.place(0,0, 'NORTH')
  #   robot.dial #=> ['NORTH', 'EAST', 'SOUTH', 'WEST']
  #   robot.left #=> 'WEST'
  #   robot.dial #=> ['WEST', 'NORTH', 'EAST', 'SOUTH']
  ##
  def left
    return unless placed
    dial.rotate! -1
    facing
  end

  ##
  # Rotates the dial(cardinals array) to the left. Returns nil when robot is not placed.
  # Example:
  #   robot = Robot.new.place(0,0, 'NORTH')
  #   robot.dial #=> ['NORTH', 'EAST', 'SOUTH', 'WEST']
  #   robot.left #=> 'EAST'
  #   robot.dial #=> ['EAST', 'SOUTH', 'WEST', 'NORTH']
  ##
  def right
    return unless placed
    dial.rotate!
    facing
  end

  ##
  # Moves the robot to the facing direction one unit at a time. Ignores further movements
  # when the limit inferior or superior is reached. Returns nil when robot is not placed.
  # Example:
  #   robot = Robot.new.place(0,0, 'NORTH')
  #   robot.move
  #   robot.x #=> 1
  #
  #   robot = Robot.new.place(0,4, 'NORTH')
  #   robot.move
  #   robot.x #=> 4
  #
  #   robot = Robot.new.place(0,0, 'SOUTH')
  #   robot.move
  #   robot.x #=> 0
  ##
  def move
    return unless placed
    cardinal = cardinals[facing]
    if valid?(x, cardinal[:x]) && valid?(y, cardinal[:y])
      @x = x + cardinal[:x]
      @y = y + cardinal[:y]
    end
  end

  ##
  # Returns a string containing the output results. Returns nil when robot is not placed.
  # Example:
  #   robot = Robot.new.place(0,0, 'NORTH')
  #   robot.move
  #   robot.report #=> 'Output: 0,1,NORTH'

  def report
    return unless placed
    "Output: #{x},#{y},#{facing}"
  end

  private

  def valid?(position, step=0)
    (0..limit-1).include?(position + step)
  end

  def cardinals
    CARDINALS
  end

  def facing
    dial[0]
  end
end
