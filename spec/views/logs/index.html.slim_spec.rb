# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'logs/index', type: :view do
  before do
    assign(:logs, [
             Log.create!(
               user_id: '',
               sleep: 2,
               meal: false,
               medicine: false,
               bathe: 'Bathe',
               go_out: 'Go Out',
               memo: 'MyText'
             ),
             Log.create!(
               user_id: '',
               sleep: 2,
               meal: false,
               medicine: false,
               bathe: 'Bathe',
               go_out: 'Go Out',
               memo: 'MyText'
             )
           ])
  end

  it 'renders a list of logs' do
    render
    assert_select 'tr>td', text: ''.to_s, count: 2
    assert_select 'tr>td', text: 2.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: false.to_s, count: 2
    assert_select 'tr>td', text: 'Bathe'.to_s, count: 2
    assert_select 'tr>td', text: 'Go Out'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
  end
end
