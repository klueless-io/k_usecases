# frozen_string_literal: true

RSpec.describe 'KUsecases::Helpers.uc_file_content' do
  include KUsecases::Helpers

  subject { uc_file_content(file) }

  let(:file) { fixture_path('uc_file_content.txt') }

  describe 'uc_file_content' do
    
    context 'can read' do
      it { is_expected.to_not be_empty }
    end

    context 'grab lines' do
      subject { as_array(uc_file_content(file, args )) }

      context 'specific line numbers' do
        let(:args) { { lines: [1,3,5] } }

        it { is_expected.to match_array(['line 1', '', 'line 5']) }
      end

      context 'range of lines wraped in markdown code block' do
        let(:args) { { lines: [*(1..5)], code_type: 'ruby' } }

        it { is_expected.to match_array(['```ruby', 'line 1', 'line 2', '', 'line 4', 'line 5', '```']) }
      end
    end

  end

  def as_array(text)
    text.split("\n").compact.collect(&:strip)
  end

end
