require 'test_helper'

class AdminLoginTest < ActionDispatch::IntegrationTest
  test "login test" do
    # hello/viewにGETアクセスを送る
    get '/hello/view'
    # 未ログインのためリダイレクトが行われるかチェック
    assert_response :redirect
    # loginコントローラーのindexアクションが呼び出されるかチェック
    assert_redirected_to controller: :login, action: :index
    # flash[:referer]に現在のURL「/hello/view」がセットされているか
    assert_equal '/hello/view', flash[:referer]
    # リダイレクト処理を明示してやる必要があるようだ
    follow_redirect!
    # 正常なステータスコードが返ってくるかチェック
    assert_response :success
    # flash[:referer]に現在のURL「/hello/view」がセットされているか
    assert_equal '/hello/view', flash[:referer]

    # 正常にログイン処理ができているかチェック
    post '/login/auth', 
    params: { username: 'yyamada', password: '12345',
      referer: '/hello/view' }
    assert_response :redirect
    assert_redirected_to controller: :hello, action: :view
    assert_equal users(:yyamada).id, session[:usr]

    follow_redirect!
    assert_response :success   
  end

end
