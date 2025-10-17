class Group < ApplicationRecord

  has_many :group_users, dependent: :destroy
  has_many :customers, through: :group_users, dependent: :destroy
  has_many :group_requests, dependent: :destroy

  belongs_to :owner, class_name: 'Customer', foreign_key: 'owner_id' #会員id(オーナー)の取得
  belongs_to :genre

  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  validates :introduction, presence: true, length: { minimum: 10, maximum: 500 }
  has_one_attached :group_image

  def get_group_image(width, height)
    unless group_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      group_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'profile_image/jpeg')
    end
    group_image.variant(resize_to_limit: [width, height]).processed
  end

  # def is_owned_by?(customers)
  #   owner.id == customers.id
  # end

end
