class Post < ApplicationRecord
  belongs_to :user
  
  validates :heading, length: { in: 6..20, too_short: " слишком короткий", too_long: " слишком длинный" }
  validates :text, length: { in: 6..200, too_short: " слишком короткий", too_long: " слишком длинный" }
  validate :check_user

  HUMANIZED_ATTRIBUTES = 
  {
    :heading => "Заголовок",
    :text => "Текст" 
  }

      
  def self.human_attribute_name(attr, options={})
    HUMANIZED_ATTRIBUTES[attr.to_sym] || super
  end
  
  private
    def check_user
      unless User.find_by(id:self.user_id)
        errors.add(:user_id, 'Пользователь не существует')
      end
    end
end
