require 'tzu_stats/version'

module TzuStats
  def self.extended(base)
    base.send :extend, StatsD::Instrument

    # measures time taken
    base.statsd_measure :run!, ->(obj, args) { "#{obj.class.to_s}.run" }

    # count success, invalid & failure
    base.statsd_count_outcomes :run!, ->(obj, args) { "#{obj.class.to_s}.run" }
  end

  def statsd_count_outcomes(method, name, *metric_options)
    add_to_method(method, name, :count_outcomes) do |old_method, new_method, metric_name|
      define_method(new_method) do |*args, &block|
        begin
          truthiness = result = send(old_method, *args, &block)
        rescue => e
          truthiness, exception = false, e
          raise
        else
          result
        ensure
          if truthiness
            suffix = 'success'
          else
            suffix = exception && exception.is_a?(Tzu::Invalid) ? 'invalid' : 'failure'
          end

          key = "#{StatsD::Instrument.generate_metric_name(metric_name, self, *args)}.#{suffix}"
          StatsD.increment(key, 1, *metric_options)
        end
      end
    end
  end

end

Tzu.send :extend, TzuStats
