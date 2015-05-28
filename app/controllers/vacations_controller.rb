class VacationsController < ApplicationController
  layout false

  def new
    @vacation = Vacation.new
    @vacation.user_id = params[:user_id]
    @user = User.find(@vacation.user_id)

    # 初期値は今日9:00-18:00
    @vacation.start_datetime = datetime_parse("#{Date.today.to_s} 9:00")
    @vacation.end_datetime = datetime_parse("#{Date.today.to_s} 18:00")
    
    # 過去のメモをリストから選択可能にする
    @memos = Vacation.where(user_id: @vacation.user_id).order(:memo).select(:memo).distinct
  end

  def create
    @vacation = Vacation.new(vacation_params)
    
    # 日付と開始時刻で開始日時、日付と終了時刻で終了日時の値を作成する
    @vacation.start_datetime = datetime_parse("#{params[:date]} #{params[:start_time]}")
    @vacation.end_datetime = datetime_parse("#{params[:date]} #{params[:end_time]}")
    
    redirect_path = dashboard_show_path(:user_id => @vacation.user_id, :year => @vacation.year)
    if @vacation.save
      flash[:success] = "Create Vacation!"
      redirect_to redirect_path
    else
      render 'new'
    end
  end


  def edit
  	@vacation = Vacation.find(params[:id])
    @user = User.find(@vacation.user_id)

    # 過去のメモをリストから選択可能にする
    @memos = Vacation.where(user_id: @vacation.user_id).order(:memo).select(:memo).distinct
  end

  def update
    @vacation = Vacation.find(params[:id])

    # 日付と開始時刻で開始日時、日付と終了時刻で終了日時の値を作成する
    @vacation.start_datetime = datetime_parse("#{params[:date]} #{params[:start_time]}")
    @vacation.end_datetime = datetime_parse("#{params[:date]} #{params[:end_time]}")
    
    @vacation.memo = vacation_params[:memo]
    @vacation.fixed = vacation_params[:fixed]
    
    redirect_path = dashboard_show_path(:user_id => @vacation.user_id, :year => @vacation.year)
    if @vacation.save
       redirect_to redirect_path
    end
  end


  def destroy
    @vacation = Vacation.find(params[:id])
    redirect_path = dashboard_show_path(:user_id => @vacation.user_id, :year => @vacation.year)
    if @vacation.destroy  
      redirect_to redirect_path
    end
  end


  def json
    user_id = params[:user_id]
    year = params[:year]            # 年度のはじめ月(４月)
    year_end = (year.to_i + 1).to_s # 年度のおわり月(３月)

    #指定年度の休暇リストを取得(指定年度(4月1日〜3月31日)の範囲を検索)
    vacations = Vacation.where(["user_id = ? and ? <= start_datetime and end_datetime <= ?",
                               user_id,
                               year + '-04-01 00:00:00',
                               year_end + '-03-31 23:59:59'])
                               .order("start_datetime desc")

    render :json => vacations
  end

  def update_ajax
    @vacation = Vacation.find(params[:id])

    # 日付と開始時刻で開始日時、日付と終了時刻で終了日時の値を作成する
    @vacation.start_datetime = datetime_parse("#{params[:date]} #{params[:start_time]}")
    @vacation.end_datetime = datetime_parse("#{params[:date]} #{params[:end_time]}")
    
    @vacation.memo = params[:memo]
    @vacation.fixed = params[:fixed]
    
    @vacation.save

    render :nothing => true
  end


  private
    def vacation_params
      params.require(:vacation).permit(:user_id, :start_datetime, :end_datetime, :memo, :fixed)
    end
    
    require 'date'

    # 文字列を日付に変換
    def datetime_parse(str)
      date = nil
      if str && !str.empty? #railsなら、if str.present? を使う
        begin
          date = DateTime.parse(str).to_s
        # parseで処理しきれない場合
        rescue ArgumentError
          formats = ['%Y:%m:%d %H:%M:%S', '%Y-%m-%d %H:%M'] # 他の形式が必要になったら、この配列に追加
          formats.each do |format|
            begin
              date = DateTime.strptime(str, format)
              break
            rescue ArgumentError
            end
          end
        end
      end
      return date
    end
  
end
