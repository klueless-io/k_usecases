# frozen_string_literal: true

RSpec.describe 'dotenv', 
               :usecases,
               :jsonX,
               :debugX,
               :markdown,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/samples/docenv-installation.md',
               document_title: 'dotenv',
               document_description: '' do

  describe 'installation' do

    usecase '', title: 'overview' do

      content do
        
      end

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
