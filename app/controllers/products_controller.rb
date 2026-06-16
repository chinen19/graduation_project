class ProductsController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :create, :edit, :update, :index]

  
   def index
      # カテゴリ一覧の取得
      @categories = Category.all
      puts "カテゴリ数: #{@categories.count}"  # ログに出力
      puts @categories.inspect  # カテゴリの内容を出力
    
      # メモ一覧の取得（カテゴリ絞り込み対応）
      if params[:category_id].present?
        @products = current_user.products.includes(:category)
                                .where(category_id: params[:category_id])
                                .order(created_at: :desc)
      else
        @products = current_user.products.includes(:category)
                              .order(created_at: :desc)
    end
    
    # メモ作成フォーム用の空のオブジェクトを作成
    @product = Product.new
  end

  def show
  end

  def new
    @product = Product.new
    @products = current_user.products.includes(:category)  # 一覧表示用(任意)
    @categories = Category.all
  end

  def create
    @product = current_user.products.build(product_params)
    
    if @product.save
      redirect_to root_path, notice: 'メモを作成しました'
    else
      # エラー時は index を再表示
      @products = current_user.products.includes(:category).order(created_at: :desc)
      @categories = Category.all
      render :index, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @product.update(product_params)
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'メモを更新しました' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update("product-#{@product.id}", partial: 'products/product', locals: { product: @product }),
            turbo_stream.update("modal", "")
          ]
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @product = current_user.products.find(params[:id])
    @product.destroy!
    
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'メモを削除しました', status: :see_other }
      format.turbo_stream  # Turbo Stream 形式でレスポンスを返す
    end
  end
  
  private
  
  # 共通処理: 商品の取得
  def set_product
    @product = Product.find(params[:id])
  end
  
  # 共通処理: カテゴリの取得
  def set_categories
    @categories = Category.all
  end
  
  # ストロングパラメータ
  def product_params
    params.require(:product).permit(:name, :category_id, :rating, :comment)
  end
end