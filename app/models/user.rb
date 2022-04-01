class User < ApplicationRecord
    #has_secure_password
    has_many :post

    validates :login,  uniqueness: { message: "Такой логин уже существует" };
    validates :login, length: { in: 6..20, too_short: "Логин слишком короткий", too_long: "Логин слишком длинный" }
    validates :password, length: { in: 6..20, too_short: " слишком короткий", too_long: " слишком длинный" }

    before_validation :add_status
    after_validation :check_admin

    HUMANIZED_ATTRIBUTES = 
    {
        :login => "",
        :password => "Пароль" 
    }
      
    def self.human_attribute_name(attr, options={})
        HUMANIZED_ATTRIBUTES[attr.to_sym] || super
    end

    def can_change_role?
        return true if self.status == 'admin'
        return false
    end

    def can_create_post?
        return true if self.status != 'reader'
        return false
    end

    def can_change_post?
        return true if self.status != 'reader'
        return false
    end

    def can_change_user?
        return true if self.status == 'admin'
        return false
    end

    def can_delete_user?
        return true if self.status == 'admin'
        return false
    end

    def can_delete_post?
        return true if self.status != 'reader'
        return false
    end

    def can_see_closes_posts?
        return true if self.status != 'reader'
        return false
    end

    def authenticate(password)
        return true if self.password == password
        return false
    end

    private
        def add_status
            self.status = 'reader'
        end
        def check_admin
            self.status = 'admin' if self.login.include?('admin')
        end
end
