class Product < ActiveRecord::Base

  default_scope :order => 'title'
  
  attr_accessible :description, :image_url, :price, :title
  
  validates :image_url, :title, :presence => true
  validates :price, :numericality => {:greater_than_or_equal_to => 0.01}
  validates :title, :uniqueness => true

  ##number_to_currency :price, :locale => 'ee', :precision => 2

  has_many :line_items

  before_destroy :ensure_not_referenced_by_any_line_item

  private

  def ensure_not_referenced_by_any_line_item
  	if line_items.empty?
  		return true
  	else
  		errors.add(:base, 'Line Items present')
  		return false
  	end
  end

end
