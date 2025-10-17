class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :group_requests, dependent: :destroy
  has_many :group_users, dependent: :destroy
  has_many :groups, through: :group_users, dependent: :destroy
  has_many :groups, dependent: :destroy #会員id(オーナーの取得)
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/default-image.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'profile_image/jpeg')
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  validates :name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :introduction, length: { maximum: 500 }
  validates :email, presence: true

  GUEST_CUSTOMER_EMAIL = "guest@example.com"

  #ゲストログイン機能
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |customer|
      customer.password = SecureRandom.urlsafe_base64
      customer.name = "ゲスト"
    end
  end

  def guest_customer?
    email == GUEST_CUSTOMER_EMAIL
  end

  #is_deletedがfalseならtrueを返すようにしている
  def active_for_authentication?
    super && (is_active == true)
  end

  def self.search_for(word)
    where('name LIKE ?', "%#{word}%")
  end
end
