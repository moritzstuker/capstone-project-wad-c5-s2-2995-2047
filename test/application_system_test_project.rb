require "test_helper"

class ApplicationSystemTestProject < ActionDispatch::SystemTestProject
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
