# frozen_string_literal: true

RSpec.describe KUsecases::Usecase do

  subject { described_class.new('key1') }

  let(:descendant_parents) { double(parent_groups: []) }

  describe 'initialize' do
    it { is_expected.to have_attributes(key: 'key1', 
                                        title: '',
                                        usage: '',
                                        outcomes: [],
                                        content_blocks: [])}

    it 'valid hash' do
      expect(subject.to_h).to eq(
        key: 'key1',
        title: '',
        usage: '',
        outcomes: [],
        content_blocks: [])
    end
  end

  describe 'build_title' do
    before { subject.build_title(usecase_with_title) }

    let(:descendant_parents) { double(parent_groups: [
      double(description: 'Default Title'),
      double(description: 'C'),
      double(description: 'B'),
      double(description: 'A'),
    ]) }

    context 'usecase has constructed title' do

      let(:usecase_with_title) { double("ExampleGroupUsecase", 
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(title: 'A B C Default Title') }

      it { expect(subject.to_h).to include(title: 'A B C Default Title')}
    end

    context 'usecase has custom title' do
      let(:usecase_with_title) { double("ExampleGroupUsecase",
                                        metadata: { usecase: true, title: 'Custom Title' },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(title: 'Custom Title') }

      it { expect(subject.to_h).to include(title: 'Custom Title')}
    end
  end

  describe 'build_usage' do
    before { subject.build_usage(usecase_with_usage) }

    context 'usecase has no usage' do

      let(:usecase_with_usage) { double("ExampleGroupUsecase", 
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(usage: '') }

      it { expect(subject.to_h).to include(usage: '')}
    end

    context 'usecase has usage' do
      let(:usecase_with_usage) { double("ExampleGroupUsecase",
                                        metadata: { usecase: true, usage: 'MyClass.load' },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(usage: 'MyClass.load') }

      it { expect(subject.to_h).to include(usage: 'MyClass.load')}
    end
  end

  describe 'build_content' do
    before { subject.build_content(usecase_with_content) }

    context 'usecase has no content' do

      let(:usecase_with_content) { double("ExampleGroupUsecase", 
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(content_blocks: []) }

      it { expect(subject.to_h).to include(content_blocks: [])}
    end

    context 'usecase has content' do
      let(:content1) { { title: 'title 1', description: 'description 1', type: :code, code_type: :ruby} }
      let(:content2) { { title: 'title 2', description: 'description 2'} }
      let(:usecase_with_content) { double("ExampleGroupUsecase",
                                        metadata: { usecase: true, content: [content1, content2] },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it 'content is valid' do 
        expect(subject.content_blocks).to match_array([
          have_attributes(title: 'title 1', description: 'description 1', type: :code, code_type: :ruby),
          have_attributes(title: 'title 2', description: 'description 2', type: :text, code_type: '')
        ]) 
      end
      # it do 
      #   puts JSON.pretty_generate(subject.to_h)
      # end
      
      it { expect(subject.to_h).to include("content_blocks": [
        {
          "title": "title 1",
          "description": "description 1",
          "type": :code,
          "code_type": :ruby
        },
        {
          "title": "title 2",
          "description": "description 2",
          "type": :text,
          "code_type": ""
        }
      ])}
    end
  end
end
