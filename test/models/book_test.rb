require 'test_helper'

class BookTest < ActiveSupport::TestCase

  test "book save" do
    book = Book.new({
      isbn: '978-4-7741-4466-X',
      title: 'Ruby on Rails本格入門',
      price: 3100,
      publish: '技術評論社',
      published: '2017-02-14',
      dl: false
    })
    # 第二引数には失敗時のメッセージを設定する
    assert book.save, 'Failed to save'
  end

  test "book validate" do
    book = Book.new({
      isbn: '978-4-7741-4466',
      title: 'Ruby on Rails本格入門',
      price: 3100,
      publish: '技術評論社',
      published: '2017-02-14',
      dl: false
    })
    # 保存に失敗するかテスト
    assert !book.save, 'Failed to validate'
    # ２つのバリデーション違反があるか
    # (isbnの文字数・isbnの形式)
    assert_equal book.errors.size, 2, 'Failed to validate count'
    # isbnのバリデートエラーが発生しているか
    assert book.errors[:isbn].any?, 'Failed to isbn validate'
  end

  # test "where method test" do
  #   result = Book.find_by(title: '改訂新版JavaScript本格入門')
  #   # result が Bookインスタンスであるか
  #   assert_instance_of Book, result ,'result is not instance of Book'
  #   # books.ymlで:modernjsというキーで定義されているisbnと同一であるかチェック
  #   assert_equal books(:modernjs).isbn, result.isbn, 'isbn column is wrong.'
  #   assert_equal books(:modernjs).published, result.published,
  #     'published column is wrong.'
  # end
  
  def setup
    @b = books(:modernjs)
  end

  def teardown
    @b = nil
  end

  test "where method test" do
    result = Book.find_by(title: '改訂新版JavaScript本格入門')
    assert_instance_of Book, result ,'result is not instance of Book'
    assert_equal @b.isbn, result.isbn, 'isbn column is wrong.'
    assert_equal @b.published, result.published, 'published column is wrong.'
  end

end
