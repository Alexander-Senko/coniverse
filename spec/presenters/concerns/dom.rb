RSpec.shared_context 'DOM builder' do
	let(:attributes)  { { **super(), lang: } }
	let(:lang)        { 'xx' }
	let(:content)     { '[content]' }
	let(:classes)     { %w[ c1 c2 ] }

	describe '#tag' do
		let(:tag_name) { 'tag' }

		it 'renders a tag with default attributes' do
			expect(subject.call { concat content })
					.to have_tag("#{decorated.send :tag_name}##{decorated.dom_id}") do |tags|
						tag = tags.sole

						expect(tag['lang'])
								.to eq lang
						expect(tag['class'].split)
								.to match_array decorated.dom_class
						expect(tag.text)
								.to eq content
					end
		end

		it 'renders a tag with extra classes' do
			expect(subject.call(class: classes) { concat content })
					.to have_tag("#{decorated.send :tag_name}##{decorated.dom_id}") do |tags|
						tag = tags.sole

						expect(tag['lang'])
								.to eq lang
						expect(tag['class'].split)
								.to match_array decorated.dom_class + classes
						expect(tag.text)
								.to eq content
					end
		end

		it 'renders a tag with a specific name' do
			expect(subject.call(tag_name) { concat content })
					.to have_tag("#{tag_name}##{decorated.dom_id}") do |tags|
						tag = tags.sole

						expect(tag['lang'])
								.to eq lang
						expect(tag['class'].split)
								.to match_array decorated.dom_class
						expect(tag.text)
								.to eq content
					end
		end
	end
end
