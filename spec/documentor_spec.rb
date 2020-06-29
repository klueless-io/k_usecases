# frozen_string_literal: true

RSpec.describe KUsecases::Documentor do

  # The following are all accessible from here
  #
  # self.class.children
  # self.class.children.first.children
  # self.class.descendants
  # self.class.descendants.first.metadata
  # self.class.filtered_examples
  # self.class.parent_groups
  # puts self.class.top_level_description
  # puts self.class.description
  # puts RSpec.current_example.description
  # puts self.class.name
  # puts "#{self.class.top_level_description} #{self.class.description} #{RSpec.current_example.description}"
  # puts RSpec.current_example.metadata[:example_group][:parent_example_group][:parent_example_group]
  # puts self.title
  # puts example.description

  subject { described_class.new(example_group) }
  let(:default_options) { [{'is_hr': false}] }

  # This needs to move into context
  let(:documentor_settings) { }
  let(:decendant_children) { [] }

  let(:example_group) { create_example_group }
  let(:descendant_parents) { create_descendant_parents }
  let(:describe) { create_describe }
  let(:usecase1) { create_usecase1 }
  let(:usecase2) { create_usecase2 }

  describe 'initialize' do

    context 'without documentor settings' do
      let(:documentor_settings) { {} }
      let(:decendant_children) { [usecase1] }

      it 'usecases should be empty' do
        expect(subject.usecases).to be_empty
      end
      it 'renderers should be empty' do
        expect(subject.renderers).to be_empty
      end
    end

    context 'when rspec example_groups supplied' do
      let(:documentor_settings) { { usecases: true } }

      context 'but does not contain usecase' do
        let(:decendant_children) { [describe, describe] }
    
        it 'usecases should be empty' do
          expect(subject.usecases).to be_empty
        end
      end

      context 'contains one usecase' do
        let(:decendant_children) { [describe, usecase1] }
    
        it 'should have a usecase' do
          expect(subject.usecases.length).to be 1
        end

        it 'should have a key' do
          expect(subject.usecases.first.key).to eq('usecase1')
        end

        it 'should have valid json' do
          expect(subject.to_h[:usecases]).to eq([{
            contents: [],
            key: "usecase1",
            title: "A B C Default Title",
            summary: '',
            usage: '',
            usage_description: ''
          }])
        end
      end

      context 'contains multiple usecases' do
        let(:decendant_children) { [describe, usecase1, usecase2] }
    
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
          expect(subject.to_h[:usecases]).to eq([{
            key: 'usecase1',
            title: 'A B C Default Title',
            summary: '',
            usage: '',
            usage_description: '',
            contents: []
          }, {
            title: 'My custom title',
            summary: 'My usecase summary',
            usage: 'MyClass.load',
            usage_description: 'My custom usage description',
            key: 'usecase2',
            contents: [{
              title: 'outcome 1',
              source: '',
              summary: 'outcome summary 1',
              type: 'outcome',
              options: default_options
            }, {
              title: 'code 1',
              source: 'code summary 1',
              type: 'code',
              code_type: 'ruby',
              options: default_options
            }]
          }])
        end
      end
      context 'with title' do
        let(:documentor_settings) { { document_title: 'title' } }

        it 'has title' do
          expect(subject.title).to eq('title')
        end
      end
      context 'with description' do
        let(:documentor_settings) { { document_description: 'description' } }

        it 'has description' do
          expect(subject.description).to eq('description')
        end
      end
      context 'with json flag' do
        let(:documentor_settings) { { json: true } }

        it 'has print json renderer' do
          expect(subject.renderers).to include( be_a(KUsecases::Renderers::PrintJsonRenderer) )
        end
      end
      context 'with debug flag' do
        let(:documentor_settings) { { debug: true } }

        it 'has print debug renderer' do
          expect(subject.renderers).to include( be_a(KUsecases::Renderers::PrintDebugRenderer) )
        end
      end
      context 'with markdown flag' do
        let(:documentor_settings) { { markdown: true, markdown_file: 'some_file.md' } }

        it 'has generate markdown renderer' do
          expect(subject.renderers).to include( be_a(KUsecases::Renderers::GenerateMarkdownRenderer) )
        end

        it 'has markdown output file' do
          expect(subject.renderers.first.file).to eq('some_file.md')
        end
      end
    end
  end
end
