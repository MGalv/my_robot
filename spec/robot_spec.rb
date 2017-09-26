require 'spec_helper'

RSpec.describe Robot do
  let(:robot) { Robot.new }

  describe '#place' do
    context 'when data is invalid' do
      it 'should set placed as false when facing is not valid' do
        robot.place(0,0,'wrong_data')
        expect(robot.placed).to eq(false)
        expect(robot.x).to eq(nil)
        expect(robot.y).to eq(nil)
      end

      it 'should set placed as false when x axis is not nvalid' do
        robot.place(-1,0,'NORTH')
        expect(robot.placed).to eq(false)
        expect(robot.x).to eq(nil)
        expect(robot.y).to eq(nil)
      end

      it 'should set placed as false when x axis is not nvalid' do
        robot.place(0,-1,'NORTH')
        expect(robot.placed).to eq(false)
        expect(robot.x).to eq(nil)
        expect(robot.y).to eq(nil)
      end
    end

    context 'when data is valid' do
      it 'should set placed as true if data is valid' do
        robot.place(0,0,'NORTH')

        expect(robot.placed).to eq(true)
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end

      it 'should set the facing variable as the first dial element' do
        facing = 'SOUTH'
        robot.place(0,0,facing)

        expect(robot.dial.first).to eq(facing)
      end
    end
  end

  describe '#left' do
    context 'when robot was not placed' do
      it 'should ignore command' do
        robot.place(0,0,'wrong_data')
        expect(robot.left).to eq(nil)
      end
    end

    context 'when robot was placed properly' do
      it 'should turn to the left element' do
        robot.place(0,0,'NORTH')
        expect(robot.left).to eq('WEST')
      end
    end
  end

  describe '#right' do
    context 'when robot was not placed' do
      it 'should ignore command' do
        robot.place(0,0,'wrong_data')
        expect(robot.right).to eq(nil)
      end
    end

    context 'when robot was placed properly' do
      it 'should turn to the left element' do
        robot.place(0,0,'NORTH')
        expect(robot.right).to eq('EAST')
      end
    end
  end

  describe '#move' do
    context 'when robot was not placed' do
      it 'should ignore command' do
        robot.place(0,0,'wrong_data')
        expect(robot.move).to eq(nil)
      end
    end

    context 'when robot was placed properly and limits are not reached' do
      it 'should increase the Y position when facing NORTH' do
        robot.place(0,0,'NORTH')
        robot.move
        expect(robot.y).to eq(1)
        expect(robot.x).to eq(0)
      end

      it 'should decrease the Y position when facing SOUTH' do
        robot.place(0,1,'SOUTH')
        robot.move
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end

      it 'should increase the X position when facing EAST' do
        robot.place(0,0,'EAST')
        robot.move
        expect(robot.x).to eq(1)
        expect(robot.y).to eq(0)
      end

      it 'should increase the X position when facing WEST' do
        robot.place(1,0,'WEST')
        robot.move
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end
    end

    context 'when robot was placed properly and limits are reached' do
      it 'should not increase the Y position when facing NORTH' do
        robot.place(0,4,'NORTH')
        robot.move
        expect(robot.y).to eq(4)
        expect(robot.x).to eq(0)
      end

      it 'should not decrease the Y position when facing SOUTH' do
        robot.place(0,0,'SOUTH')
        robot.move
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end

      it 'should not increase the X position when facing EAST' do
        robot.place(4,0,'EAST')
        robot.move
        expect(robot.x).to eq(4)
        expect(robot.y).to eq(0)
      end

      it 'should not increase the X position when facing WEST' do
        robot.place(0,0,'WEST')
        robot.move
        expect(robot.x).to eq(0)
        expect(robot.y).to eq(0)
      end
    end
  end

  describe '#report' do
    context 'when robot was not placed' do
      it 'should ignore command' do
        robot.place(0,0,'wrong_data')
        expect(robot.report).to eq(nil)
      end
    end

    context 'when robot was placed properly' do
      it 'should turn to the left element' do
        robot.place(0,0,'NORTH')
        expect(robot.report).to eq('Output: 0,0,NORTH')
      end
    end
  end
end