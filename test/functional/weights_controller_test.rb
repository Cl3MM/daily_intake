require 'test_helper'

class WeightsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    get :show, :id => Weight.first
    assert_template 'show'
  end

  def test_new
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    Weight.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    Weight.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to weight_url(assigns(:weight))
  end

  def test_edit
    get :edit, :id => Weight.first
    assert_template 'edit'
  end

  def test_update_invalid
    Weight.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Weight.first
    assert_template 'edit'
  end

  def test_update_valid
    Weight.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Weight.first
    assert_redirected_to weight_url(assigns(:weight))
  end

  def test_destroy
    weight = Weight.first
    delete :destroy, :id => weight
    assert_redirected_to weights_url
    assert !Weight.exists?(weight.id)
  end
end
