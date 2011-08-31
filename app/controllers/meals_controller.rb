class MealsController < ApplicationController
  # GET /meals
  # GET /meals.xml
  before_filter :login_required

  def index

    if not params[:selectedDate].nil?
      @date = Date.strptime(params[:selectedDate], '%m/%d/%Y')
    else
      @date = Date.today
    end

    @meals ||= current_user.meals.meals_at @date

    @totalDailyCal = Meal.totalDailyCalOn @date
    @dailyDetail = Meal.totalDailyDetailsOn @date

    @totalDailyProtein = @dailyDetail["totalDailyProtein"]
    @totalDailyCarbs = @dailyDetail["totalDailyCarbs"]
    @totalDailyFat = @dailyDetail["totalDailyFat"]

    respond_to do |format|
      format.js
      format.html # index.html.erb
      format.xml  { render :xml => @meals }
    end
  end

  def update_meals
    if not params[:selectedDate].nil?
      @date = Date.strptime(params[:selectedDate], '%m/%d/%Y')
    else
      @date = Date.today
    end

    @meals = Meal.meals_at @date
    respond_to do |format|
      format.js
  end
 
  end
  # GET /meals/1
  # GET /meals/1.xml
  def show
    @meal = Meal.find(params[:id])
    @amount = Amount.new

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @meal }
    end
  end

  # GET /meals/new
  # GET /meals/new.xml
  def new
    @meal = Meal.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @meal }
    end
  end

  # GET /meals/1/edit
  def edit
    @meal = Meal.find(params[:id])
  end

  # POST /meals
  # POST /meals.xml
  def create
    @meal = Meal.new(params[:meal])
    @meal.user_id = current_user.id
    respond_to do |format|
      if @meal.save
        format.html { redirect_to(@meal, :notice => 'Meal was successfully created.') }
        format.xml  { render :xml => @meal, :status => :created, :location => @meal }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @meal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /meals/1
  # PUT /meals/1.xml
  def update
    @meal = Meal.find(params[:id])

    respond_to do |format|
      if @meal.update_attributes(params[:meal])
        format.html { redirect_to(@meal, :notice => 'Meal was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @meal.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /meals/1
  # DELETE /meals/1.xml
  def destroy
    @meal = Meal.find(params[:id])
    @meal.destroy

    respond_to do |format|
      format.html { redirect_to(meals_url) }
      format.xml  { head :ok }
    end
  end

  # POST /meals/add_ingredient
  def add_ingredient
    @meal = Meal.find(params[:id])
    @ingredient = Ingredient.find_by_id(params[:amount][:ingredient_id])
    @amount = params[:ingredientAmount]

    respond_to do |format|
      if @meal.find_or_create_by_ingredient(@ingredient, @amount)      
        format.html { redirect_to(@meal, :notice => "#{@ingredient.name} #{@amount} was successfully added.'") }
        format.xml  { head :ok }
      else
        flash[:error] = "Unable to add the ingredient."
        format.html { redirect_to(@meal) }
        format.xml  { render :xml => @meal.errors, :status => :unprocessable_entity }
     end
    end
 
  end

  def del_ingredient
    @meal = Meal.find(params[:id])
    @ingredient = Ingredient.find(params[:meal_id])

    respond_to do |format|
      if @meal.ingredients.include?(@ingredient)
        @meal.ingredients.delete(@ingredient)
        if @meal.save
          format.html { redirect_to(@meal, :notice => "#{@ingredient.name} was successfully deleted.'") }
          format.xml  { head :ok }
        else
          format.html { render :action => "show", :error => "Unable to delete #{@ingredient.name}." }
          format.xml  { render :xml => @meal.errors, :status => :unprocessable_entity }
        end
      else
        format.html { render :action => "show", :error => "Unable to delete #{@ingredient.name}." }
        format.xml  { render :xml => @meal.errors, :status => :unprocessable_entity }
      end
    end
  end

end
