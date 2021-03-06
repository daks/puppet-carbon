require 'spec_helper'

describe 'carbon' do
  let(:prefix) { "/foo/bar" }
  let(:params) {
    {
      :prefix => prefix,
    }
  }

  it { should compile }

  it { should contain_concat("#{prefix}/conf/carbon.conf").with(:force => true) }
  it { should contain_concat("#{prefix}/conf/storage-schemas.conf").with(:force => true) }
  it { should contain_concat("#{prefix}/conf/storage-aggregation.conf").with(:force => true) }
  it { should contain_concat("#{prefix}/conf/aggregation-rules.conf").with(:force => true) }
  it { should contain_concat("#{prefix}/conf/relay-rules.conf").with(:force => true) }

  #it 'prints the catalog' do
  #  $stderr.puts subject.call.to_yaml
  #end

  it 'sets default schemas' do
    default_schema = param_value(subject.call, 'concat::fragment', 'carbon_storage_schema_default_1min_for_1day', :content)
    default_schema.should match("[default_1min_for_1day]")
  end
end
