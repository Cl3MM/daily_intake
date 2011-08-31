class IngredientsController < ApplicationController

  before_filter :login_required

  # GET /ingredients
  # GET /ingredients.xml
  def index
    @ingredients = Ingredient.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @ingredients }
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.xml
  def show
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @ingredient }
    end
  end

  # GET /ingredients/new
  # GET /ingredients/new.xml
  def new
    @ingredient = Ingredient.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @ingredient }
    end
  end

  # GET /ingredients/1/edit
  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  # POST /ingredients
  # POST /ingredients.xml
  def create
    @ingredient = Ingredient.new(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to(@ingredient, :notice => 'Ingredient was successfully created.') }
        format.xml  { render :xml => @ingredient, :status => :created, :location => @ingredient }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /ingredients/1
  # PUT /ingredients/1.xml
  def update
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        format.html { redirect_to(@ingredient, :notice => 'Ingredient was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @ingredient.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.xml
  def destroy
    @ingredient = Ingredient.find(params[:id])
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to(ingredients_url) }
      format.xml  { head :ok }
    end
  end

  def add_many
    @ingredients = Ingredient.all
    @content = params[:content]
    if @content == nil || @content == ""
      flash[:error] = "Please paste something to import..."      
    else
      @elem_added = ""
      @elem_failed = ""

      @content.split("\r\n").each do |line|
        item, exist = line.split("\t"), false
        @ingredients.each do |f|
          if f.name == item[0]
            exist = true
            @elem_failed += "Element already exists: #{f.name.capitalize}\n"
          end          
        end
        if !exist and item.length == 6
          @ingredient = Ingredient.new
          @ingredient.name = item[0]
          @ingredient.brand = item[1]
          @ingredient.protein = item[3]
          @ingredient.carbs = item[4]
          @ingredient.fat = item[5]
          if @ingredient.save
            @elem_added += "Element #{@ingredient.name.capitalize} successfully added !\n"
          else
            @elem_failed += "Problem while saving element #{@ingredient.name.capitalize}\n"            
          end
          exist = false
        end
#        @bob = "#{d[0]} | #{d.pop(3).join(" | ")}"
      end
      flash[:notice] = @elem_added if @elem_added.length > 1
      flash[:error] = @elem_failed if @elem_failed.length > 1
    end
    redirect_to ingredients_url
  end

  def import

  end
end
