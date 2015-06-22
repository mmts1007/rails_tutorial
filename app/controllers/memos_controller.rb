class MemosController < ApplicationController
  # フィルタ処理
  # アクションに処理が入る前にset_memoメソッドを呼ぶ
  # ただし、show, edit, update, destroy 処理の場合呼ぶ
  before_action :set_memo, only: [:show, :edit, :update, :destroy]

  # GET /memos
  # GET /memos.json
  def index
    # Model.all と書くと
    # モデルに紐づくデータを全件取得する
    @memos = Memo.all
  end

  # GET /memos/1
  # GET /memos/1.json
  def show
  end

  # GET /memos/new
  def new
    # 新規作成のためモデルをnew
    @memo = Memo.new
  end

  # GET /memos/1/edit
  def edit
  end

  # POST /memos
  # POST /memos.json
  def create
    # 画面から入力された情報を元にモデルを作成
    @memo = Memo.new(memo_params)

    respond_to do |format|
      if @memo.save
        # データの保存が成功した場合、ユーザの指定のフォーマットでレスポンスを返す
        format.html { redirect_to @memo, notice: 'Memo was successfully created.' }
        format.json { render :show, status: :created, location: @memo }
      else
        format.html { render :new }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /memos/1
  # PATCH/PUT /memos/1.json
  def update
    respond_to do |format|
      # オブジェクトの情報を画面から入力された値で更新する
      if @memo.update(memo_params)
        format.html { redirect_to @memo, notice: 'Memo was successfully updated.' }
        format.json { render :show, status: :ok, location: @memo }
      else
        format.html { render :edit }
        format.json { render json: @memo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /memos/1
  # DELETE /memos/1.json
  def destroy
    # オブジェクトを破棄
    @memo.destroy
    respond_to do |format|
      format.html { redirect_to memos_url, notice: 'Memo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_memo
      # 画面で入力された(URLに指定されている)IDを元にデータを探す
      @memo = Memo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # permitメソッドに記述されたパラメータのみ許容する
    def memo_params
      params.require(:memo).permit(:title, :body)
    end
end
