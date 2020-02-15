# frozen_string_literal: true

RSpec.describe 'KUsecases::Helpers.uc_grab_lines' do
  include KUsecases::Helpers

  let(:content) { <<~TEXT.strip
                    line 1
                    line 2
                    
                    line 4
                    line 5
                  TEXT
  }

  describe 'uc_grab_lines' do

    subject { as_array(uc_grab_lines(content, lines_to_include)) }

    context 'specific line numbers' do
      let(:lines_to_include) { [1,3,5] }

      it { is_expected.to match_array(['line 1', '', 'line 5']) }
    end

    context 'range of line numbers' do
      let(:lines_to_include) { [*(1..4)] }

      it { is_expected.to match_array(['line 1', 'line 2', '', 'line 4']) }
    end

    context 'specific and range of line numbers' do
      let(:lines_to_include) { [1,*(3..4), 5] }

      it { is_expected.to match_array(['line 1', '', 'line 4', 'line 5']) }
    end
  end

  def as_array(text)
    text.split("\n").compact.collect(&:strip)
  end
end