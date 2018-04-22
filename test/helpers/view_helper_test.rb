require 'test_helper'
class ViewHelperTest < ActionView::TestCase
  # ビューヘルパーのテスト
  test "format helper" do
    # format_datetimeビューヘルパーのテスト
    result = format_datetime(Time.now, :date)
    # 正しい形式で日付の文字列が返ってきているか
    assert_match /\d{4}年\d{1,2}月\d{1,2}日/, result
  end
end