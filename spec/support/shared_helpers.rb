shared_context 'parse text' do |text|
  before { @result = Ircp.parse(text) }
  subject { @result }
  let(:result) { @result }
end

shared_context 'initialize message' do |*args|
  before { @result = Ircp::Message.new(*args) }
  subject { @result }
  let(:result) { @result }
end

shared_examples_for 'prefix for' do |options|
  subject { result.prefix }
  if options.nil?
    it { should be_nil }
  else
    options.each do |key, value|
      its(key) { should eq value }
    end
  end
end

shared_examples_for 'params for' do |*args|
  subject { result.params }
  args.each.with_index do |arg, index|
    its([index]) { should eq arg }
  end
end
