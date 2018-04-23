require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest

  test "diff check" do
    # 新しいレコードをcreateしたときに１件増えるかテスト
    assert_difference 'Book.count', 1 do
      # /books にPOSTすることでcreateアクションを呼び出す
      post books_url,
        params: {
          book: {
            isbn: '978-4-7741-4223-0',
            title: 'Rubyポケットリファレンス',
            price: 3000,
            publish: '技術評論社'
          }
        }
    end
  end
end
