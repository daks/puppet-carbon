require 'spec_helper'

describe 'carbon::aggregator' do
  let(:title) { 'a' }
  let(:concat_title) { "aggregator_#{title}" }

  describe "carbon.conf template content" do
    [
      {
        :title => 'should set LINE_RECEIVER_INTERFACE = 50',
        :attr  => 'line_receiver_interface',
        :value => '50',
        :match => 'LINE_RECEIVER_INTERFACE = 50',
      },
      {
        :title => 'should set LINE_RECEIVER_PORT = 50',
        :attr  => 'line_receiver_port',
        :value => '50',
        :match => 'LINE_RECEIVER_PORT = 50',
      },
      {
        :title => 'should set PICKLE_RECEIVER_INTERFACE = 50',
        :attr  => 'pickle_receiver_interface',
        :value => '50',
        :match => 'PICKLE_RECEIVER_INTERFACE = 50',
      },
      {
        :title => 'should set PICKLE_RECEIVER_PORT = 50',
        :attr  => 'pickle_receiver_port',
        :value => '50',
        :match => 'PICKLE_RECEIVER_PORT = 50',
      },
      {
        :title => 'should set RULES = 50',
        :attr  => 'rules',
        :value => '50',
        :match => 'RULES = 50',
      },
      {
        :title => 'should set DESTINATIONS = 50',
        :attr  => 'destinations',
        :value => '50',
        :match => 'DESTINATIONS = 50',
      },
      {
        :title => 'should set REPLICATION_FACTOR = 50',
        :attr  => 'replication_factor',
        :value => '50',
        :match => 'REPLICATION_FACTOR = 50',
      },
      {
        :title => 'should set MAX_QUEUE_SIZE = 50',
        :attr  => 'max_queue_size',
        :value => '50',
        :match => 'MAX_QUEUE_SIZE = 50',
      },
      {
        :title => 'should set USE_FLOW_CONTROL = 50',
        :attr  => 'use_flow_control',
        :value => '50',
        :match => 'USE_FLOW_CONTROL = 50',
      },
      {
        :title => 'should set MAX_DATAPOINTS_PER_MESSAGE = 50',
        :attr  => 'max_datapoints_per_message',
        :value => '50',
        :match => 'MAX_DATAPOINTS_PER_MESSAGE = 50',
      },
      {
        :title => 'should set MAX_AGGREGATION_INTERVALS = 50',
        :attr  => 'max_aggregation_intervals',
        :value => '50',
        :match => 'MAX_AGGREGATION_INTERVALS = 50',
      },
      {
        :title => 'should set WRITE_BACK_FREQUENCY = 50',
        :attr  => 'write_back_frequency',
        :value => '50',
        :match => 'WRITE_BACK_FREQUENCY = 50',
      },
      {
        :title => 'should set USE_WHITELIST = 50',
        :attr  => 'use_whitelist',
        :value => '50',
        :match => 'USE_WHITELIST = 50',
      },
      {
        :title => 'should set CARBON_METRIC_PREFIX = 50',
        :attr  => 'carbon_metric_prefix',
        :value => '50',
        :match => 'CARBON_METRIC_PREFIX = 50',
      },
      {
        :title => 'should set CARBON_METRIC_INTERVAL = 50',
        :attr  => 'carbon_metric_interval',
        :value => '50',
        :match => 'CARBON_METRIC_INTERVAL = 50',
      },
      {
        :title => 'should set LOG_LISTENER_CONN_SUCCESS = 50',
        :attr  => 'log_listener_conn_success',
        :value => '50',
        :match => 'LOG_LISTENER_CONN_SUCCESS = 50',
      },
    ].each do |param|
      context "when #{param[:attr]} is #{param[:value]}" do
        let(:params) do
          { param[:attr].to_sym => param[:value] }
        end

        if param[:attr] == 'title'
          let(:title) { param[:value] }
        end

        let(:fragment_content) { param_value(subject.call, 'concat::fragment', concat_title, :content) }

        it param[:title] do
          Array(param[:match]).each do |item|
            fragment_content.should match(item)
          end

          Array(param[:notmatch]).each do |item|
            fragment_content.should_not match(item)
          end
        end

        it { should contain_concat__fragment(concat_title) }
      end
    end
  end

  it { should contain_file("/etc/init.d/carbon-aggregator-#{title}") }
  it { should contain_service("carbon-aggregator-#{title}") }
end
