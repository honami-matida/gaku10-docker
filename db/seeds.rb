# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create!(email: '123@456', password: '123456')

#　顧客の作成
Customer.find_or_create_by!(email: "mattchan@example.com") do |customer|
  customer.name = "まっちゃん"
  customer.password = 'macchan'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_1.png')), filename: 'profile-image_1.png')
end

Customer.find_or_create_by!(email: "camp@example.com") do |customer|
  customer.name = "自然キャンプ@子ども生きる力プロジェクト"
  customer.password = 'camp2024!'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_2.png')), filename: 'profile-image_2.png')
end

Customer.find_or_create_by!(email: "yuzu@example.com") do |customer|
  customer.name = "yuzu sibadog"
  customer.password = 'Yuzu!2024'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_3.png')), filename: 'profile-image_3.png')
end

Customer.find_or_create_by!(email: "tea_tea@example.com") do |customer|
  customer.name = "🐏茶ちゃ🍭"
  customer.password = 'TeaTea#2024'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_4.png')), filename: 'profile-image_4.png')

end

Customer.find_or_create_by!(email: "salmon@example.com") do |customer|
  customer.name = "salmon"
  customer.password = 'Salmon2024%'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_5.png')), filename: 'profile-image_5.png')
end

Customer.find_or_create_by!(email: "july@example.com") do |customer|
  customer.name = "july🎐"
  customer.password = 'July2024!'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_6.png')), filename: 'profile-image_6.png')
end

Customer.find_or_create_by!(email: "hutaba@example.com") do |customer|
  customer.name = "ふたばクラブ公式✅"
  customer.password = 'hutaba#2024'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_7.png')), filename: 'profile-image_7.png')
end

Customer.find_or_create_by!(email: "spica@example.com") do |customer|
  customer.name = "★spica"
  customer.password = 'Spica2024$'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_8.png')), filename: 'profile-image_8.png')
end

Customer.find_or_create_by!(email: "everyday@example.com") do |customer|
  customer.name = "エブリデイ学童"
  customer.password = 'everyday2024!'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_9.png')), filename: 'profile-image_9.png')
end

Customer.find_or_create_by!(email: "gokigen@example.com") do |customer|
  customer.name = "ごきげんボンバー💣"
  customer.password = 'Gokigen2024'
  customer.profile_image.attach(io: File.open(Rails.root.join('app/assets/images/profile-image_10.png')), filename: 'profile-image_10.png')
end

# ジャンルの作成
アイディア = Genre.find_or_create_by!(name: "アイディア") do |genre|
  genre.introduction = "みんなのアイディアを集めます"
end

教えて先生！ = Genre.find_or_create_by!(name: "教えて先生！") do |genre|
  genre.introduction = "質問しましょう"
end

トーク = Genre.find_or_create_by!(name: "トーク") do |genre|
  genre.introduction = "みんなでトークしましょう"
end

# ジャンルを取得
idea_genre = Genre.find_by!(name: "アイディア")
question_genre = Genre.find_by!(name: "教えて先生！")
talk_genre = Genre.find_by!(name: "トーク")


# 投稿の作成
Post.find_or_create_by!(title: "夏休みレクリエーションについてアイディア募集です") do |post|
  post.genre = idea_genre
  post.introduction = "夏休みにむけて、子供達と楽しめるレクリエーションを企画しています。プールや水遊び、スイカ割りなど、たくさんアイディアを募集しています。"
  post.customer = Customer.find_by!(name: "まっちゃん")
end

Post.find_or_create_by!(title: "自然体験について") do |post|
  post.genre = question_genre
  post.introduction = "みなさんは、子どもと自然体験するならどこに行きますか？１.収穫体験、２.海、3.キャンプファイヤー、4.川遊び、5.登山"
  post.customer = Customer.find_by!(name: "自然キャンプ@子ども生きる力プロジェクト")
end

Post.find_or_create_by!(title: "普段の保育で笑ってしまったこと") do |post|
  post.genre = talk_genre
  post.introduction = "みなさんが保育するなかで、子どもでクスッと笑ってしまったことはありますか？"
  post.customer = Customer.find_by!(name: "yuzu sibadog")
end

Post.find_or_create_by!(title: "廃材工作について") do |post|
  post.genre = idea_genre
  post.introduction = "廃材を使って工作できないか考えています。いま、手持ちであるのは、ペットボトルのキャップ、空き箱、紙パック等です。よろしくお願いいたします。"
  post.customer = Customer.find_by!(name: "🐏茶ちゃ🍭")
end

Post.find_or_create_by!(title: "学童のファッション問題について") do |post|
  post.genre = question_genre
  post.introduction = "私が勤務する際は、子どもたちの学年で選ぶ服を変えていますが、基本は動きやすい服で出勤します。特に指定はなく、基本Tシャツと長ズボンです。学童によって服装など違いが大きいような気がします。みなさんはどのような服装で出勤されていますか？"
  post.customer = Customer.find_by!(name: "salmon")
end

Post.find_or_create_by!(title: "最近のコロナ対応について") do |post|
  post.genre = talk_genre
  post.introduction = "コロナも落ち着いて、学童でできることが増えてきました。やはり、日々の消毒や最低限のことは欠かさずするのですが、みなさんはどうされていますか？"
  post.customer = Customer.find_by!(name: "july🎐")
end

Post.find_or_create_by!(title: "ふたば学童") do |post|
  post.genre = talk_genre
  post.introduction = "ふたば学童のトークです。"
  post.customer = Customer.find_by!(name: "ふたばクラブ公式✅")
end

Post.find_or_create_by!(title: "アドバイスください。先輩から怒られました。") do |post|
  post.genre = question_genre
  post.introduction = "20代後半女です。入社して半年たちました。先日、子ども達へ全体の声掛けをしているときに、子供達の目の前で、先輩から「もっと声を出さないとみんなに聞こえないよ」とお叱りを受けてしまいました。もともと声が小さく、確かに子供達に声掛けする時に声がかきけされてしまうことがあります。それと同時に、みんなの前で注意しなくていいのに、と思ってしまいました。もっと腹から声を出せるようにしたいし、自分が至らなくてモヤモヤしてしまう自分にアドバイスいただきたいです。よろしくお願いいたします。"
  post.customer = Customer.find_by!(name: "★spica")
end

Post.find_or_create_by!(title: "子供たちのおやつについて") do |post|
  post.genre = talk_genre
  post.introduction = "みなさんの学童ではおやつは出ていますか？もしあったら、どのようなものが出ているのか教えていただきたいです。"
  post.customer = Customer.find_by!(name: "エブリデイ学童")
end

Post.find_or_create_by!(title: "💣💥🤯🌋🔥💣") do |post|
  post.genre = talk_genre
  post.introduction = "学童の困ったこと🌋させませんか？"
  post.customer = Customer.find_by!(name: "ごきげんボンバー💣")
end

# グループの作成
Group.find_or_create_by!(name: "グループA") do |group|
  group.genre = idea_genre
  group.introduction = "アイディアを共有しよう。新しいアイディアを生み出すためのグループです。"
  group.owner_id = Customer.find_by!(email: "mattchan@example.com").id  # まっちゃん
end

Group.find_or_create_by!(name: "グループB") do |group|
  group.genre = question_genre
  group.introduction = "質問や相談をしましょう。お互いにサポートし合うグループです。"
  group.owner_id = Customer.find_by!(email: "camp@example.com").id  # 自然キャンプ@子ども生きる力プロジェクト
end

Group.find_or_create_by!(name: "グループC") do |group|
  group.genre = talk_genre
  group.introduction = "楽しくおしゃべりしよう。リラックスした会話が楽しめるグループです。"
  group.owner_id = Customer.find_by!(email: "yuzu@example.com").id  # yuzu sibadog
end

Group.find_or_create_by!(name: "グループD") do |group|
  group.genre = idea_genre
  group.introduction = "新しいアイディアをシェアしよう。創造的な発想を共有するグループです。"
  group.owner_id = Customer.find_by!(email: "tea_tea@example.com").id  # 🐏茶ちゃ🍭
end

Group.find_or_create_by!(name: "グループE") do |group|
  group.genre = question_genre
  group.introduction = "困ったことがあれば質問しよう。助け合いながら解決策を見つけるグループです。"
  group.owner_id = Customer.find_by!(email: "salmon@example.com").id  # salmon
end

Group.find_or_create_by!(name: "グループF") do |group|
  group.genre = talk_genre
  group.introduction = "リラックスしておしゃべりしよう。楽しい会話で心を癒すグループです。"
  group.owner_id = Customer.find_by!(email: "july@example.com").id  # july🎐
end

Group.find_or_create_by!(name: "ふたば学童") do |group|
  group.genre = talk_genre
  group.introduction = "ふたば学童のトークです。"
  group.owner_id = Customer.find_by!(email: "hutaba@example.com").id  # ふたばクラブ公式✅
end

Group.find_or_create_by!(name: "グループH") do |group|
  group.genre = question_genre
  group.introduction = "質問やアドバイスを求めよう。お互いに助け合いながら学ぶグループです。"
  group.owner_id = Customer.find_by!(email: "spica@example.com").id  # ★spica
end

Group.find_or_create_by!(name: "グループI") do |group|
  group.genre = talk_genre
  group.introduction = "会話を楽しもう。気軽におしゃべりできるリラックスしたグループです。"
  group.owner_id = Customer.find_by!(email: "everyday@example.com").id  # エブリデイ学童
end

Group.find_or_create_by!(name: "💣💥🤯🌋🔥💣") do |group|
  group.genre = talk_genre
  group.introduction = "学童の困ったこと🌋させませんか？"
  group.owner_id = Customer.find_by!(email: "gokigen@example.com").id  # ごきげんボンバー💣
end
customer = Customer.find_by(email: "hutaba@example.com")
group1=Group.find_by(name: "グループA")

group2=Group.find_by(name: "グループB")

group3=Group.find_by(name: "グループC")

GroupUser.create(group_id: group1.id,customer_id: customer.id)
GroupRequest.create(group_id: group1.id, customer_id: customer.id, is_status: "approved")

GroupUser.create(group_id: group2.id,customer_id: customer.id)
GroupRequest.create(group_id: group2.id, customer_id: customer.id, is_status: "approved")

GroupUser.create(group_id: group3.id,customer_id: customer.id)
GroupRequest.create(group_id: group3.id, customer_id: customer.id, is_status: "approved")

# コメントの作成



# # 投稿の作成
# Post.create!(title: "投稿タイトル1", content: "これは投稿1の内容です。", customer: a)
# Post.create!(title: "投稿タイトル2", content: "これは投稿2の内容です。", customer: b)
# Post.create!(title: "投稿タイトル3", content: "これは投稿3の内容です。", customer: c)