# frozen_string_literal: true

RSpec.describe Array, 
               :usecases,
               :jsonX,
               :debugX,
               :markdown,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/samples.md',
               document_title: 'Document title',
               document_description: 'Document descrition' do

  describe 'load' do
    subject { described_class.load() }

    usecase 'basics',
            usage: "#{described_class.name}.load",
            usage_description: "#{described_class.name}.load - description goes here" do

      ruby 'Initialize an array', :hr,
        code: 'ar = [1,2,3]' do
      end

      ruby '',
        code: 'ar << 4' do
      end

      css '',
        code: 'a { color: "blue" }' do
      end

      outcome 'Some content', :hr do
        ar = [1,2,3]
        expect(ar).to match_array([1, 2, 3])
      end

      outcome 'Some more content with', 
        summary: 'A detailed summary provided' do
        ar = [1,2,3]
        expect(ar).to match_array([1, 2, 3])
      end
    end
  end
end
