class User < ApplicationRecord
    #has_secure_password
    has_many :post

    validates :login, :password, presence: true
    validates :login, :password, length: { in: 6..20 }
    validates :login,  uniqueness: true

    before_validation :add_status
    after_validation :check_admin

    def can_change?
        return true if self.status == 'admin'
    end

    private
        def add_status
            self.status = 'reader'
        end
        def check_admin
            self.status = 'admin' if self.login.include?('admin')
        end
end
