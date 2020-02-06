# frozen_string_literal: true

RSpec.describe KUsecases::Usecases do

  subject { KUsecases::Usecases.new(root_example_group) }

  let(:root_example_group) { nil }

  let(:descendant_parents) { double(parent_groups: [
    double(description: 'Default Title'),
    double(description: 'C'),
    double(description: 'B'),
    double(description: 'A'),
  ]) }

  let(:describe) { double("ExampleGroup",
    metadata: {},
    example_group: descendant_parents,
    descendants: []) 
  }
  let(:usecase1) { double("ExampleGroupUsecase",
    metadata: { usecase: true },
    name: 'usecase1',
    example_group: descendant_parents,
    descendants: [],
    examples: []) 
  }
  let(:usecase2) { double("ExampleGroupUsecase",
    metadata: { 
      usecase: true,
      usage: 'MyClass.load',
      title: 'My custom title'
    },
    name: 'usecase2',
    example_group: descendant_parents,
    descendants: [],
    examples: [
      double('Example', description: 'Expected outcome 1'),
      double('Example', description: 'Expected outcome 2')
    ]) 
  }

  # let(:usecase2) { double("ExampleGroupUsecase", metadata: { usecase: true }, name: 'usecase2', descendants: []) }
  # let(:usecase3) { double("ExampleGroupUsecase", metadata: { usecase: true }, name: 'usecase3', descendants: []) }
  # let(:root_describe) { double("RootExampleGroup", descendants: []) }

  describe 'initialize via rspec' do

    it { is_expected.to_not be_nil }

    context 'when no rspec example_groups' do
      let(:root_example_group) { double("RootExampleGroup", descendants: []) }
  
      it 'usecases should be empty' do
        expect(subject.usecases).to be_empty
      end
    end

    context 'when rspec example_groups does not contain usecase samples' do
      let(:root_example_group) { double("RootExampleGroup", descendants: [describe, describe]) }
  
      it 'usecases should be empty' do
        expect(subject.usecases).to be_empty
      end
    end
    
    context 'when rspec example_groups contain one usecase' do
      let(:root_example_group) { double("RootExampleGroup", :descendants => [describe, usecase1]) }
  
      it 'should have a usecase' do
        expect(subject.usecases.length).to be 1
      end

      it 'should have a key' do
        expect(subject.usecases.first.key).to eq('usecase1')
      end

      it 'should have valid json' do
        expect(subject.to_h).to eq({ 'usecases': [{
          content_blocks: [],
          key: "usecase1",
          outcomes: [],
          title: "A B C Default Title",
          usage: ""
        }]})
        # puts JSON.pretty_generate(subject.to_json)
      end
    end

    context 'when rspec example_groups contain multiple usecase' do
      let(:root_example_group) { double("RootExampleGroup", :descendants => [
        describe,
        usecase1,
        usecase2]) }
  
      it 'should have some usecases' do
        expect(subject.usecases.length).to be 2
      end

      it 'should have valid keys' do
        expect(subject.usecases).to include(an_object_having_attributes(key: 'usecase1'))
        expect(subject.usecases).to include(an_object_having_attributes(key: 'usecase2'))
      end

      it 'should have valid titles' do
        expect(subject.usecases).to include(an_object_having_attributes(title: 'A B C Default Title'))
        expect(subject.usecases).to include(an_object_having_attributes(title: 'My custom title'))
      end

      it 'should have valid usage' do
        expect(subject.usecases).to include(an_object_having_attributes(usage: ''))
        expect(subject.usecases).to include(an_object_having_attributes(usage: 'MyClass.load'))
      end

      it 'should have valid json' do
        expect(subject.to_h).to eq({ 'usecases': [{
          key: 'usecase1',
          title: 'A B C Default Title',
          usage: '',
          outcomes: [],
          content_blocks: []
        }, {
          title: 'My custom title',
          usage: 'MyClass.load',
          key: 'usecase2',
          outcomes: [{
            description: 'Expected outcome 1'
          }, {
            description: 'Expected outcome 2'
          }],
          content_blocks: []
        }]})
      end

      xit 'print' do
        puts JSON.pretty_generate(subject.to_h)
      end
    end
  end
end
