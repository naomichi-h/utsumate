# frozen_string_literal: true

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [375, 667]
  end
  config.before(:each, type: :system, headless: false) do
    driven_by :selenium, options: {
      browser: :chrome
    } do |driver_option|
      # 印刷ダイアログが開いたら自動で保存ボタンを押下する
      driver_option.add_argument('--kiosk-printing')
    end
  end
end
