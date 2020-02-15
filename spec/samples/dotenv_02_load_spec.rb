# frozen_string_literal: true

RSpec.describe 'dotenv', 
               :usecases,
               :jsonX,
               :debugX,
               :markdown,
               :markdown_prettier,
               :markdown_openX,
               markdown_file: 'docs/samples/docenv-load.md',
               document_title: 'dotenv',
               document_description: '' do

  src_folder = '/Users/davidcruwys/dev/gems_3rd/dotenv'
  src_dotenv = File.join(src_folder, 'lib/dotenv.rb')

    # usecase '', title: 'Overview' do
    #   content '', summary: uc_file_content(src_readme, lines: [*(3..42)]) do
        
    #   end
    # end
end
