require 'test_helper'

class HelloControllerTest < ActionDispatch::IntegrationTest
  # Functionalテストの例
  test "list action" do
    # GETのHTTPリクエストを生成
    # POSTなども利用できる
    get '/hello/list'
    # インスタンス変数@booksを取得し、要素数が10であるかを検証
    assert_equal 10, assigns(:books).length, 'found rows is wrong.'
    # 正常なステータスコード（:successは200）が返されたかを検証
    assert_response :success, 'list action failed.'
    # 正常なテンプレートが選択されたかを検証
    assert_template 'hello/list'
  end


  test "routing check" do
    # 第二引数から第一引数のパスを再構築できるかの検証
    # 正直良くわからん。　パスが指定されてからコントローラーとアクションを呼び出しているのでは？
    assert_generates('hello/list', { controller: 'hello', action: 'list' })
    # assert_recognizesはパスから指定のコントローラーとアクションが呼び出されているかの検証
    # こっちはわかる
    # assert_recognizes({ controller: 'hello', action: 'list' }, 'hello/list')
  end

  test "select check" do
    # /hello/listにGETでアクセスして
    get '/hello/list'
    # <title>要素が存在するか
    assert_select 'title'
    # <title>要素が存在するか
    # assert_select 'title', true
    # <font>要素が存在しないか
    assert_select 'font', false
    # <title>要素の中身がRailbookであるか（<title>Railbook</title>）
    assert_select 'title', 'Railbook'
    # <script>要素のdata-turbolinks-track属性が「reload」であるか
    # プレースホルダーを利用している
    assert_select 'script[data-turbolinks-track=?]', 'reload'    
    # <title>要素の中身を正規表現でチェック
    assert_select 'title', /[A-Za-z0-9]+/
    # <table>配下にstyle属性をもった<tr>が10個存在するか
    assert_select 'table tr[style]', 10
    # <table>配下にstyle属性をもった<tr>が1~10個存在するか
    assert_select 'table' do
      assert_select 'tr[style]', 1..10
    end
    # <title>要素が1つだけ存在し、テキストがRailbookであるか
    assert_select 'title', { count: 1, text: 'Railbook' }
  end

end
