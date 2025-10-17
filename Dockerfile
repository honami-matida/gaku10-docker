FROM ruby:3.1.2

# 必要なパッケージをインストール（Node.js 18, Yarn, Git 用）
RUN apt-get update -qq && apt-get install -y \
    curl \
    git \
    build-essential \
    libpq-dev \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g yarn

# 作業ディレクトリ
WORKDIR /app

# ローカルの Rails アプリをコンテナにコピー
COPY . /app

# Gem をインストール
RUN gem install bundler -v 2.4.19
RUN bundle install

# ポートを開放
EXPOSE 3000

# デフォルトコマンド
CMD ["rails", "server", "-b", "0.0.0.0"]

ENV NODE_OPTIONS=--openssl-legacy-provider
