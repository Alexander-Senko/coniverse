RSpec.shared_context 'DOM builder' do
	let(:attributes)  { { **super(), lang: } }
	let(:lang)        { 'xx' }
	let(:content)     { '[content]' }
	let(:classes)     { %w[ c1 c2 ] }
end
