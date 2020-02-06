# frozen_string_literal: true

RSpec.describe KUsecases::Usecase do

  subject { KUsecases::Usecase.new('key1') }

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
end
