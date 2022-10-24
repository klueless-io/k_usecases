# frozen_string_literal: true

RSpec.describe 'dotenv', 
               :usecases,
               :json,
               :debugX,
               :markdown,
               :markdown_prettier,
               :markdown_open,
               markdown_file: 'docs/samples/dotenv-installation.md',
               document_title: 'dotenv',
               document_description: '' do

  src_folder = '/Users/davidcruwys/dev/gems_3rd/dotenv'
  src_readme = File.join(src_folder, 'README.md')

  usecase '', title: 'Overview' do
    content '', summary: uc_file_content(src_readme, lines: [*(3..43)]) do
      
    end

    css 'xyz', code: '.a { color: blue }' do
    end

    code 'Initialize an array', code_type: :ruby do
      puts 'Xmen'
    end

  end
end
