# frozen_string_literal: true

RSpec.describe KUsecases::Usecase do

  subject { described_class.new('key1') }

  let(:descendant_parents) { double(parent_groups: []) }
  let(:default_options) { [{'is_hr': false}] }

  describe 'initialize' do
    it { is_expected.to have_attributes(key: 'key1', 
                                        title: '',
                                        usage: '',
                                        usage_description: '',
                                        contents: [])}

    it 'valid hash' do
      expect(subject.to_h).to eq(
        key: 'key1',
        title: '',
        summary: '',
        usage: '',
        usage_description: '',
        contents: [])
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

      let(:usecase_with_title) { double("ExampleGroup", 
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(title: 'A B C Default Title') }

      it { expect(subject.to_h).to include(title: 'A B C Default Title')}
    end

    context 'usecase has custom title' do
      let(:usecase_with_title) { double("ExampleGroup",
                                        metadata: { usecase: true, title: 'Custom Title' },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(title: 'Custom Title') }

      it { expect(subject.to_h).to include(title: 'Custom Title')}
    end
  end

  describe 'build_attributes' do
    before { subject.build_attributes(usecase_with_attributes) }

    context 'usecase has no extra attributes' do

      let(:usecase_with_attributes) { double("ExampleGroup", 
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(summary: '') }
      it { is_expected.to have_attributes(usage: '') }
      it { is_expected.to have_attributes(usage_description: '') }

      it { expect(subject.to_h).to include(summary: '')}
      it { expect(subject.to_h).to include(usage: '')}
      it { expect(subject.to_h).to include(usage_description: '')}
    end

    context 'usecase has summary' do
      let(:usecase_with_attributes) { double("ExampleGroup",
                                        metadata: { usecase: true, summary: 'My summary' },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(summary: 'My summary') }

      it { expect(subject.to_h).to include(summary: 'My summary')}
    end

    context 'usecase has usage' do
      let(:usecase_with_attributes) { double("ExampleGroup",
                                        metadata: { usecase: true, usage: 'MyClass.load' },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(usage: 'MyClass.load') }

      it { expect(subject.to_h).to include(usage: 'MyClass.load')}
    end

    context 'usecase has usage description' do
      let(:usecase_with_attributes) { double("ExampleGroup",
                                        metadata: { usecase: true, usage_description: 'MyClass.load - description' },
                                        example_group: descendant_parents,
                                        descendants: []) }

      it { is_expected.to have_attributes(usage_description: 'MyClass.load - description') }

      it { expect(subject.to_h).to include(usage_description: 'MyClass.load - description')}
    end
  end

  describe 'build_content' do
    # before { subject.parse(usecase_with_content) }
    subject { described_class.parse('key1', usecase_with_content) }

    context 'usecase has no content' do

      let(:usecase_with_content) { double("ExampleGroup", 
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        examples: [],
                                        descendants: []) }

      it { is_expected.to have_attributes(contents: []) }

      it { expect(subject.to_h).to include(contents: [])}
    end

    context 'usecase has content' do
      let(:usecase_with_content) { double("ExampleGroup",
                                        metadata: { usecase: true },
                                        example_group: descendant_parents,
                                        examples: [
                                          create_content_outcome1,
                                          create_content_code1],
                                        descendants: []) }

      it 'has correct content count' do 
        expect(subject.contents.length).to eq(2) 
      end
      
      it { expect(subject.to_h[:contents]).to include(
        {
          "title": "outcome 1",
          "source": "",
          "summary": "outcome summary 1",
          "type": "outcome",
          "options": default_options
        })}
      it { expect(subject.to_h[:contents]).to include(
        {
          "title": "code 1",
          "type": "code",
          "code_type": "ruby",
          "source": "code summary 1",
          "options": default_options
        })}
    end
  end
end
