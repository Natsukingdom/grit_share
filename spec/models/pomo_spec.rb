require 'rails_helper'

RSpec.describe Pomo, type: :model do
  describe 'validation' do
    before(:context) do
      @blank_message = "can't be blank"
    end

    before(:each) do
      @pomo = build(:pomo)
      @user = create(:user)
    end

    context 'invalid' do
      it 'is invalid without start_time' do
        @pomo.start_time = ''
        expect(@pomo.tap(&:validate).errors[:start_time])
          .to include(@blank_message)
      end

      it 'is invalid without user_id' do
        @pomo.user_id = ''
        expect(@pomo.tap(&:validate).errors[:user_id])
          .to include(@blank_message)
      end

      it 'is invalid with missing user_id' do
        @pomo.user_id = (@user.id + 1)
        expect(@pomo.save).to be_falsey
      end

      it 'is invalid with passage_seconds greater than 1500' do
        %w[1501 9999 1600].each do |test_data|
          @pomo.passage_seconds = test_data
          expect(@pomo.tap(&:validate).errors[:passage_seconds])
            .to(include('must be less than or equal to 1500'))
        end
      end

      it 'is invalid with passage_seconds less than 0' do
        %w[-1 -1000].each do |test_data|
          @pomo.passage_seconds = test_data
          expect(@pomo.tap(&:validate).errors[:passage_seconds])
            .to(include('must be greater than or equal to 0'))
        end
      end

      it 'is invalid with end_time earlier than start_time' do
        @pomo.end_time = @pomo.start_time - 1.seconds
        expect(@pomo.tap(&:validate).errors[:end_time])
          .to(include('end_time must be greater than start_time'))
      end

      it 'is invalid with start_time the same as end_time' do
        @pomo.end_time = @pomo.start_time
        expect(@pomo.tap(&:validate).errors[:end_time])
          .to(include('end_time must be greater than start_time'))
      end

      it 'is invalid with passage_seconds greater than than a remainder between start_time and end_time' do
        @pomo.end_time = @pomo.start_time + 1000.seconds
        expect(@pomo.tap(&:validate).errors[:passage_seconds])
          .to(include('passage_seconds must be less than a remainder between start_time and end_time'))
      end
    end

    context 'valid' do
      it 'is valid with user_id be able to reference' do
        expect(@pomo.save).to be_truthy
      end
    end
  end
end
