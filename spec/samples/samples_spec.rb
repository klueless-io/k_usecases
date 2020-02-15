# frozen_string_literal: true

RSpec.describe Array, 
               :usecases,
               :jsonX,
               :debugX,
               :markdownX,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/samples.md',
               document_title: 'Document Title',
               document_description: 'Document Descrition' do

  describe 'load' do
    subject { described_class.load() }

    usecase 'basics',
            usage: "#{described_class.name}.load",
            usage_description: '#{described_class.name}.load - description goes here',
            content: [{
              title: 'Initialize an array',
              description: 'ar = [1,2,3]',
              type: :code,
              code_type: :ruby
            }, {
              title: 'Push to array',
              description: 'ar << 4',
              code_type: :ruby
            }] do

      code 'Initialize an array' do
      end

      code 'Push to array' do
      end

      outcome 'AAAAAA' do
        ar = [1,2,3]
        expect(ar).to match_array([1, 2, 3])
      end

      outcome 'BBBBBB' do
        ar = [1,2,3]
        ar << 4
        expect(ar).to match_array([1, 2, 3, 4])
      end
    end

    usecase 'Overwrite the title',
            usage: "#{described_class.name}.load",
            title: 'Default.load will load your application configuration from your `.env` file found in the project root' do
      outcome 'aaaa' do
        # puts @document
      end
    end

    describe '-> namespace ->' do

      usecase 'Can I move content_block into a test block',
        usage: "#{described_class.name}.load" do

        code 'example' do
          
        end

        outcome 'xxxxx' do
        end
      end

    end

    context 'and this' do
    end
  end

  describe 'more stuff' do
    context 'with deeper' do
      context 'and deeper levels' do
      end
    end
  end
end
