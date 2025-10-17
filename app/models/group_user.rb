class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :customer
  
  def includesCustomer?(customer)
    group_users.exists?(customer_id: customer.id)
  end
end
