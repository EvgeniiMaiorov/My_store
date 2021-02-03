class ItemsController < ApplicationController

# before_filter :price_and_weight_to_integer, only: [:create, :update]
before_filter :find_item,                   only: [:show, :edit, :update, :destroy, :upvote]
before_filter :check_if_admin,              only: [:edit, :create, :update, :new, :destroy]
    
    def index
        @items = Item
        @items = @items.where("price >= ?", params[:price_from])        if params[:price_from]
        @items = @items.where("created_at >= ?", 1.day.ago)             if params[:today]
        @items = @items.where("votes_count >= ?", params[:votes_count]) if params[:votes_count]
        @items = @items.order("votes_count DESC", "price")
        #@items = @items.includes(:image)
    end
    
    # /items/:id GET
    def show
        unless @item 
            render_404     
        end   
    end

    # /items/new GET
    def new     
        @item = Item.new
    end

    # /items/:id/edit GET
    def edit       
    end
    
    # /items POST
    def create       
        @item = Item.create(item_params)
        if @item.errors.empty?
            redirect_to item_path(@item)
        else
            render "new"
        end
    end

    # /items/:id PUT
    def update        
        @item.update_attributes(item_params)
            if @item.errors.empty?
                flash[:success] = "Изменения сохранены"
                redirect_to item_path(@item)
            else
                flash.now[:error] = "Не все поля заполнены"
                render "edit"
            end
    end

    # /items/:id DELETE
    def destroy
        @item.destroy
        render json: { success: true }  
        ItemsMailer.item_destroyed(@item).deliver      
    end

    def upvote
        @item.increment!(:votes_count)
        redirect_to action: :index
    end

    def expensive
        @items = Item.where("price > 5000")        
        render "index"
    end

private
   
    def item_params
        params.require(:item).permit(:name, :description, :price, :weight, :real)
    end 

    def price_and_weight_to_integer        
        params[:item][:price]  = params[:item][:price].to_i
        params[:item][:weight] = params[:item][:weight].to_i
    end
    
    def find_item
        @item = Item.find_by(id: params[:id])
        unless @item 
            render_404     
        end    
    end

end
