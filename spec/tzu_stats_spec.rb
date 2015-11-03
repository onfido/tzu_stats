require 'spec_helper'

describe TzuStats do
  include StatsD::Instrument::Matchers

  class DoStuff
    include Tzu

    def call(params)
    end
  end

  class DoInvalidStuff
    include Tzu

    def call(params)
      raise Tzu::Invalid.new
    end
  end

  class DoFailingStuff
    include Tzu

    def call(params)
      raise Tzu::Failure.new
    end
  end

  context 'successful result' do
    it 'measures time taken' do
      expect { DoStuff.run({}) }.to trigger_statsd_measure('DoStuff.run')
    end

    it 'increments success count' do
      expect { DoStuff.run({}) }.to trigger_statsd_increment('DoStuff.run.success')
    end
  end

  context 'invalid result' do
    it 'increments invalid count' do
      expect { DoStuff.run({}) }.to trigger_statsd_increment('DoStuff.run.success')
    end
  end

  context 'failure' do
    it 'increments failure count' do
      expect { DoStuff.run({}) }.to trigger_statsd_increment('DoStuff.run.success')
    end
  end
end
